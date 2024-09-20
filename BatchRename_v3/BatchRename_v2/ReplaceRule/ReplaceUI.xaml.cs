using Contract;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace ReplaceRule
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class ReplaceUI : Window
    {
        public IRule ReturnData { get; set; }
        public ReplaceUI(IRule name)
        {
            InitializeComponent();
            ReturnData = name;
        }
        private void applyButton(object sender, RoutedEventArgs e)
        {
            var sb = new StringBuilder();
            sb.Append(OldWord.Text);
            sb.Append(" -> ");
            sb.Append(NewWord.Text);
            IRule prototype = new Replace();
            ReturnData = prototype.Parse(sb.ToString());

            DialogResult = true;
        }

        private void cancleButton(object sender, RoutedEventArgs e)
        {

        }

        private void ReplaceUI_Loaded(object sender, RoutedEventArgs e)
        {

        }
    }
}
