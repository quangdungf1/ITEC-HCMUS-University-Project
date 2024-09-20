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

namespace AddPrefixRule
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class AddPrefixUI : Window
    {
        public IRule ReturnData { get; set; }
        public AddPrefixUI(IRule name)
        {
            InitializeComponent();
            ReturnData = name;
        }
        private void AddPrefix_Loaded(object sender, RoutedEventArgs e)
        {

        }

        private void applyButton(object sender, RoutedEventArgs e)
        {
            IRule prototype = new AddPrefix();
            ReturnData = prototype.Parse(Prefix.Text);

            DialogResult = true;
        }

        private void cancleButton(object sender, RoutedEventArgs e)
        {
            DialogResult = false;
        }
    }
}
