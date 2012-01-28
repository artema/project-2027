using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Input;
using _2027.Domain;
using _2027.ViewModel;

namespace _2027
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private readonly MainWindowModel _model = new MainWindowModel();

        public MainWindow()
        {
            string error;
            NoStartupError = !_model.CheckForErrors(out error);
            StartupErrorText = error;

            DataContext = this;

            InitializeComponent();

            SetSelectedResolution();
        }

        public bool NoStartupError { get; private set; }

        public string StartupErrorText { get; private set; }

        public MainWindowModel Model { get { return _model; } }

        public IList<GameLanguageItem> LanguageItems
        {
            get { return Model.LanguageItems; }
        }

        public IList<ScreenResolutionItem> ResolutionItems
        {
            get { return Model.ScreenResolutionItems; }
        }

        public IList<ScreenEffectItem> EffectItems
        {
            get { return Model.ScreenEffectItems; }
        }

        public int SelectedLanguage
        {
            get
            {
                return LanguageItems.IndexOf((from item in LanguageItems
                                              where item.Language == Model.Options.Language
                                              select item).FirstOrDefault());
            }
            set { Model.Options.Language = LanguageItems[value].Language; }
        }

        public ScreenResolution SelectedResolution
        {
            get { return Model.Options.Resolution; }
            set { Model.Options.Resolution = value; }
        }

        public ScreenEffect SelectedEffect
        {
            get { return Model.Options.Effect; }
            set { Model.Options.Effect = value; }
        }

        public bool HasResolutionError { get; set; }

        public int SelectedResolutionIndex
        {
            get
            {
                var i = 0;

                for (i = 0; i < ResolutionItems.Count; i++)
                {
                    if (ResolutionItems[i].Resolution.Equals(Model.Options.Resolution))
                        return i;
                }

                return 0;
            }

            set
            {
                if (value != 0)
                {
                    SelectedResolution = ResolutionItems[value].Resolution;
                    SetSelectedResolution();
                }

                UpdateSelectedResolution();
            }
        }

        public int SelectedEffectIndex
        {
            get
            {
                var i = 0;

                for (i = 0; i < EffectItems.Count; i++)
                {
                    if (EffectItems[i].Effect.Equals(Model.Options.Effect))
                        return i;
                }

                return 0;
            }

            set
            {
                SelectedEffect = EffectItems[value].Effect;
            }
        }

        private void SetSelectedResolution()
        {
            customResolutionX.Text = SelectedResolution.Width.ToString();
            customResolutionY.Text = SelectedResolution.Height.ToString();
        }

        private void UpdateSelectedResolution()
        {
            SelectedResolution = new ScreenResolution
            {
                Width = uint.Parse(customResolutionX.Text),
                Height = uint.Parse(customResolutionY.Text)
            };
        }

        protected void OnPreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            e.Handled = !AreAllValidNumericChars(e.Text);
            base.OnPreviewTextInput(e);
        }


        private static bool AreAllValidNumericChars(string str)
        {
            uint result;
            return uint.TryParse(str, out result);
        }


        private void buttonStartGame_Click(object sender, RoutedEventArgs e)
        {
            uint result;
            if (string.IsNullOrEmpty(customResolutionX.Text) || !uint.TryParse(customResolutionX.Text, out result) || result == 0) return;
            if (string.IsNullOrEmpty(customResolutionY.Text) || !uint.TryParse(customResolutionY.Text, out result) || result == 0) return;

            UpdateSelectedResolution();

            Model.SaveOptions();
            Model.LaunchGame();
            Close();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
        }

        private void Website_MouseUp(object sender, MouseButtonEventArgs e)
        {
            Model.OpenWebsite();
        }

        private void Forum_MouseUp(object sender, MouseButtonEventArgs e)
        {
            Model.OpenForum();
        }
    }
}
