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

namespace ChangeExtensionRule
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class ChangeExtensionUI : Window
    {
        public ChangeExtensionUI(IRule name)
        {
            InitializeComponent();
            ReturnData = name;
        }
        public IRule ReturnData { get; set; }
        private void ChangeExtension_Loaded(object sender, RoutedEventArgs e)
        {

        }

        private void applyButton(object sender, RoutedEventArgs e)
        {
            IRule prototype = new ChangeExtension();
            ReturnData = prototype.Parse(Extension.Text);
            DialogResult = true;
        }

        private void cancleButton(object sender, RoutedEventArgs e)
        {

        }
    }
}
