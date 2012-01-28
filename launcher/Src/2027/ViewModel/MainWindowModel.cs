using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Resources;
using _2027.Domain;
using _2027.Model;

namespace _2027.ViewModel
{
    public struct GameLanguageItem
    {
        public GameLanguage Language { get; set; }

        public string Text { get; set; }
    }

    public struct ScreenResolutionItem
    {
        public ScreenResolution Resolution { get; set; }

        public override string ToString()
        {
            if (Resolution.Equals(default(ScreenResolution)))
            {
                var manager = new ResourceManager("_2027.Properties.Resources", Assembly.GetExecutingAssembly());
                return manager.GetString("ResolutionCustomLabel");
            }

            return Resolution.Width + "x" + Resolution.Height;
        }
    }

    public struct ScreenEffectItem
    {
        public ScreenEffect Effect { get; set; }

        public string Name { get; set; }

        public override string ToString()
        {
            return Name;
        }
    }

    public class MainWindowModel
    {
        private readonly MainModel _model = new MainModel();

        public bool CheckForErrors(out string error)
        {
            return _model.CheckForErrors(out error);
        }

        public void LaunchGame()
        {
            _model.LaunchGame();
        }

        public void SaveOptions()
        {
            _model.SaveGameOptions(Options);
        }

        public void OpenWebsite()
        {
            if (Options.Language == GameLanguage.Russian)
                Process.Start("http://project2027.com/ru/");
            else if (Options.Language == GameLanguage.English)
                Process.Start("http://project2027.com/en/");
        }

        public void OpenForum()
        {
            if (Options.Language == GameLanguage.Russian)
                Process.Start("http://planetdeusex.ru/forum/index.php?showforum=3");
            else if (Options.Language == GameLanguage.English)
                Process.Start("http://www.dxalpha.com/forum/viewforum.php?f=141");
        }

        private GameOptions _options;

        public GameOptions Options
        {
            get { return _options ?? (_options = _model.ReadGameOptions()); }
        }

        public IList<GameLanguageItem> LanguageItems
        {
            get
            {
                var manager = new ResourceManager("_2027.Properties.Resources", Assembly.GetExecutingAssembly());

                return new[]
                       {
                           new GameLanguageItem{ Language = GameLanguage.English, Text = manager.GetString("LanguageEnglish") },
                           new GameLanguageItem{ Language = GameLanguage.Russian, Text = manager.GetString("LanguageRussian") }
                       };
            }
        }

        public IList<ScreenResolutionItem> ScreenResolutionItems
        {
            get
            {
                return new[]
                       {
                           CreateScreenResolutionItem(0, 0),
                           CreateScreenResolutionItem(1920, 1200),
                           CreateScreenResolutionItem(1920, 1080),
                           CreateScreenResolutionItem(1680, 1050),
                           CreateScreenResolutionItem(1600, 1200),
                           CreateScreenResolutionItem(1600, 900),
                           CreateScreenResolutionItem(1440, 900),
                           CreateScreenResolutionItem(1400, 1050),
                           CreateScreenResolutionItem(1360, 1024),
                           CreateScreenResolutionItem(1360, 768),
                           CreateScreenResolutionItem(1280, 1024),
                           CreateScreenResolutionItem(1280, 960),
                           CreateScreenResolutionItem(1280, 800),
                           CreateScreenResolutionItem(1280, 720),
                           CreateScreenResolutionItem(1024, 768)
                       };
            }
        }

        public IList<ScreenEffectItem> ScreenEffectItems
        {
            get
            {
                return new[]
                       {
                           CreateScreenEffectItem("D3D9_ENB", ScreenEffect.D3D9_ENB),
                           CreateScreenEffectItem("D3D9", ScreenEffect.D3D9),
                           CreateScreenEffectItem("D3D10", ScreenEffect.D3D10),
                           CreateScreenEffectItem("OpenGL", ScreenEffect.OpenGL)
                       };
            }
        }

        private static ScreenResolutionItem CreateScreenResolutionItem(uint width, uint height)
        {
            return new ScreenResolutionItem { Resolution = new ScreenResolution { Width = width, Height = height } };
        }

        private static ScreenEffectItem CreateScreenEffectItem(string name, ScreenEffect type)
        {
            var manager = new ResourceManager("_2027.Properties.Resources", Assembly.GetExecutingAssembly());

            return new ScreenEffectItem { Name = manager.GetString("Effects_" + name), Effect = type };
        }
    }
}
