namespace _2027.Domain
{
    public class GameOptions
    {
        public GameLanguage Language { get; set; }

        public ScreenResolution Resolution { get; set; }

        public ScreenEffect Effect { get; set; }

        public bool RunInWindow { get; set; }
    }

    public enum GameLanguage
    {
        Russian,
        English
    }

    public struct ScreenResolution
    {
        public uint Width;

        public uint Height;
    }

    public enum ScreenEffect
    {
        D3D9_ENB,
        D3D9,
        D3D10,
        OpenGL
    }
}
