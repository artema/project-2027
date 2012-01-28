using System;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Resources;
using System.Windows;
using _2027.Domain;
using ConfigUtils;

namespace _2027.Model
{
    public class MainModel
    {
        private const string GamePath = @"System\2027.exe";
        private const string RunningPath = @"System\Running.ini";

        private const string GameConfigPath = @"2027\System\2027.ini";
        private const string UserConfigPath = @"2027\System\2027User.ini";
        private const string EnbConfigPath = @"System\enbseries.ini";

        private const string LanguageRussian = "rus";
        private const string LanguageEnglish = "eng";

        public bool CheckForErrors(out string error)
        {
            error = null;

            var manager = new ResourceManager("_2027.Properties.Resources", Assembly.GetExecutingAssembly());

            if (!File.Exists(@"System\DeusEx.exe"))
            {
                error = manager.GetString("ErrorInvalidDir");
                return true;
            }

            if (!File.Exists(@"System\UBrowser.u"))
            {
                error = manager.GetString("ErrorInvalidVersion");
                return true;
            }

            return false;
        }

        public void LaunchGame()
        {
            if (File.Exists(RunningPath))
                File.Delete(RunningPath);
            
            var process = Process.Start(GamePath, @"ini=""..\2027\System\2027.ini"" userini=""..\2027\System\2027User.ini"" log=""..\2027\System\2027.log""");

            if (process != null)
            {
                process.ProcessorAffinity = new IntPtr(1);
            }
        }

        public GameOptions ReadGameOptions()
        {
            var config = new UnrealConfig(GameConfigPath);
            var enbConfig = new UnrealConfig(EnbConfigPath);

            var options = new GameOptions
                              {
                                  Language = ParseLanguage(config.GetSetting("Engine.Engine", "Language")),
                                  Resolution = ParseResolution(config.GetSetting("WinDrv.WindowsClient", "FullscreenViewportX"), config.GetSetting("WinDrv.WindowsClient", "FullscreenViewportY")),
                                  RunInWindow = !bool.Parse(config.GetSetting("WinDrv.WindowsClient", "StartupFullscreen"))
                              };

            switch (config.GetSetting("Engine.Engine", "GameRenderDevice"))
            {
                case "OpenGLDrv.OpenGLRenderDevice":
                    options.Effect = ScreenEffect.OpenGL;
                    break;

                case "D3D9Drv.D3D9RenderDevice":
                    options.Effect = int.Parse(enbConfig.GetSetting("GLOBAL", "UseEffect")) == 1 ? ScreenEffect.D3D9_ENB : ScreenEffect.D3D9;
                    break;

                case "D3D10Drv.D3D10RenderDevice":
                    options.Effect = ScreenEffect.D3D10;
                    break;
            }

            if (options.Resolution.Width <= 0 || options.Resolution.Height <= 0)
            {
                options.Resolution = new ScreenResolution
                                         {
                                             Width = Convert.ToUInt32(SystemParameters.VirtualScreenWidth),
                                             Height = Convert.ToUInt32(SystemParameters.VirtualScreenHeight)
                                         };

                options.RunInWindow = false;
            }

            return options;
        }

        public void SaveGameOptions(GameOptions options)
        {
            var config = new UnrealConfig(GameConfigPath);

            string language;

            switch (options.Language)
            {
                case GameLanguage.Russian:
                    language = LanguageRussian;
                    break;

                case GameLanguage.English:
                    language = LanguageEnglish;
                    break;

                default:
                    throw new Exception("Invalid language");
            }

            switch (options.Effect)
            {
                case ScreenEffect.OpenGL:
                    config.SetSetting("Engine.Engine", "GameRenderDevice", "OpenGLDrv.OpenGLRenderDevice");
                    break;

                case ScreenEffect.D3D9:
                case ScreenEffect.D3D9_ENB:
                    config.SetSetting("Engine.Engine", "GameRenderDevice", "D3D9Drv.D3D9RenderDevice");
                    break;

                case ScreenEffect.D3D10:
                    config.SetSetting("Engine.Engine", "GameRenderDevice", "D3D10Drv.D3D10RenderDevice");
                    break;
            }

            config.SetSetting("WinDrv.WindowsClient", "WindowedViewportX", options.Resolution.Width.ToString());
            config.SetSetting("WinDrv.WindowsClient", "WindowedViewportY", options.Resolution.Height.ToString());
            config.SetSetting("WinDrv.WindowsClient", "FullscreenViewportX", options.Resolution.Width.ToString());
            config.SetSetting("WinDrv.WindowsClient", "FullscreenViewportY", options.Resolution.Height.ToString());
            config.SetSetting("WinDrv.WindowsClient", "StartupFullscreen", !options.RunInWindow ? "True" : "False");

            config.SetSetting("Engine.Engine", "Language", language);
            config.Save();

            var enbConfig = new UnrealConfig(EnbConfigPath);
            enbConfig.SetSetting("GLOBAL", "UseEffect", options.Effect == ScreenEffect.D3D9_ENB ? "1" : "0");
            enbConfig.Save();

            var userConfig = new UnrealConfig(UserConfigPath);
            var fov = CalculateFov(options.Resolution);
            userConfig.SetSetting("Engine.PlayerPawn", "DesiredFOV", fov.ToString());
            userConfig.SetSetting("Engine.PlayerPawn", "DefaultFOV", fov.ToString());

            userConfig.SetSetting("DeusEx.DeusExPlayer", "bShowItemArticles",
                                  options.Language == GameLanguage.English ? "True" : "False");

            userConfig.Save();
        }

        private static double CalculateFov(ScreenResolution resolution)
        {
            return RadianToDegree(2 * Math.Atan((((double)resolution.Width / (double)resolution.Height) / (4.0 / 3.0)) * Math.Tan(DegreeToRadian(75) / 2)));
        }

        static private double DegreeToRadian(double angle) { return Math.PI * angle / 180.0; }

        static private double RadianToDegree(double angle) { return angle * (180.0 / Math.PI); }

        private GameLanguage ParseLanguage(string language)
        {
            if (string.IsNullOrEmpty(language))
                throw new ArgumentException("language");

            switch (language)
            {
                case LanguageRussian:
                    return GameLanguage.Russian;

                case LanguageEnglish:
                    return GameLanguage.English;

                default:
                    return GameLanguage.English;
            }
        }

        private ScreenResolution ParseResolution(string screenWidth, string screenHeight)
        {
            if (string.IsNullOrEmpty(screenWidth))
                throw new ArgumentException("screenWidth");

            if (string.IsNullOrEmpty(screenHeight))
                throw new ArgumentException("screenHeight");

            try
            {
                return new ScreenResolution
                           {
                               Width = uint.Parse(screenWidth),
                               Height = uint.Parse(screenHeight)
                           };
            }
            catch
            {
                return new ScreenResolution { Width = 0, Height = 0 };
            }
        }
    }
}
