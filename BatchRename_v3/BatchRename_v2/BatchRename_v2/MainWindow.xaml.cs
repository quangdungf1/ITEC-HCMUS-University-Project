using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
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
using RemoveAllSpaceRule;
using ConverToPascalRule;
using AddCounterRule;
using LowerCaseRule;
using ReplaceRule;
using AddPrefixRule;
using AddSurfixRule;
using ChangeExtensionRule;
using Contract;
using System.IO;
using System.Reflection;
using Microsoft.Win32;
using System.Data;
using System.Windows.Forms;
using BatchRename_v2.FileBase;
using Path = System.IO.Path;
using System.ComponentModel;
using MessageBox = System.Windows.MessageBox;
using System.Diagnostics.Metrics;
using System.Windows.Forms.Design;
using static System.Net.WebRequestMethods;
using File = System.IO.File;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;
using OpenFileDialog = Microsoft.Win32.OpenFileDialog;

namespace BatchRename_v2
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        ObservableCollection<FileClass> fileList = new ObservableCollection<FileClass>();
        ObservableCollection<FolderClass> folderList = new ObservableCollection<FolderClass>();
        ObservableCollection<object> _ruleBox = new ObservableCollection<object> { };
        public ObservableCollection<object> _fileStorage = new ObservableCollection<object>();
        List<IRule> rules = new List<IRule>();
        List<string> _fileStore = new List<string>();

        int countRule { get; set; }
        List<int> RuleCount = new List<int>();
        ObservableCollection<string> _fileFullPath = new ObservableCollection<string>();
        private void updateRuleList()
        {

            _RuleListBox.Items.Clear();
            foreach (var rule in rules)
            {
                _RuleListBox.Items.Add(rule);
            }
            MessageBox.Show("Update success!");

        }
        public MainWindow()
        {
            InitializeComponent();
        }
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            string folder = AppDomain.CurrentDomain.BaseDirectory;
            DirectoryInfo folderInfo = new DirectoryInfo(folder);
            var dllFiles = folderInfo.GetFiles("*.dll");
            List<IRule> plugins = new List<IRule>();

            foreach (var dllFile in dllFiles)
            {
                var assembly = Assembly.LoadFrom(dllFile.FullName);

                var types = assembly.GetTypes();

                foreach (var type in types)
                {
                    if (type.IsClass &&
                    typeof(IRule).IsAssignableFrom(type))
                    {
                        plugins.Add((IRule)Activator.CreateInstance(type)!);
                    }
                }

            }
            foreach (var plugin in plugins)
            {
                _ruleBox.Add(plugin);
            }
            _RulesComboBox.ItemsSource = _ruleBox;
        }

        private void addRuleButton(object sender, RoutedEventArgs e)
        {
            if (_RulesComboBox.SelectedItem != null)
            {
                var ruleSelected = (IRule)_RulesComboBox.SelectedItem;
                var instance = ruleSelected.Clone();
                countRule++;
                instance.Position = countRule;
                RuleCount.Add(countRule);
                _RuleListBox.Items.Add(instance);
                var item = new
                {
                    RuleCount = countRule,
                };
                rules.Add(instance);
            }
            else
            {
                MessageBox.Show("Please chose Rule to add");
            }
        }
        static public int fileCount = 0;
        private void addFileButton(object sender, RoutedEventArgs e)
        {
            var openFileDialog = new System.Windows.Forms.OpenFileDialog();
            openFileDialog.Multiselect = true;

            if (openFileDialog.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                foreach (var file in openFileDialog.FileNames)
                {
                    string preview_name = System.IO.Path.GetFileName(file);
                    foreach (IRule rule in _RuleListBox.Items)
                    {
                        if (rule.Name == "AddCounter")
                        {
                            string counterNum = fileCount.ToString();
                            rule.Parse(counterNum);
                        }
                        preview_name = rule.Rename(preview_name);
                    }

                    string status;
                    if (file != null)
                    {
                        status = "Found";
                    }
                    else
                        status = "Not Found";

                    fileTab.Items.Add(new FileClass()
                    {
                        FileName = System.IO.Path.GetFileName(file),
                        FilePath = file,
                        FileRename = preview_name,
                        FileError=status,
                    });
                }
            }
        }

        private void addFolderButton(object sender, RoutedEventArgs e)
        {
            System.Windows.Forms.FolderBrowserDialog screen = new();

            if (screen.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                string[] Paths = Directory.GetDirectories(screen.SelectedPath, "*",
                    System.IO.SearchOption.AllDirectories);
                foreach (var path in Paths)
                {
                    string preview_name = path.Substring(screen.SelectedPath.Length + 1);
                    foreach (IRule rule in _RuleListBox.Items)
                    {
                        if (rule.Name == "AddCounter")
                        {
                            string counterNum = fileCount.ToString();
                            rule.Parse(counterNum);
                        }
                        preview_name = rule.Rename(preview_name);
                    }
                    string status;
                    if (path != null)
                    {
                        status = "Found";
                    }
                    else
                        status = "Not Found";
                    folderTab.Items.Add(new FolderClass()
                    {
                        FolderPath = path,
                        FolderName = path.Substring(screen.SelectedPath.Length + 1),
                        FolderRename = preview_name,
                        FolderError=status
                    });


                }
            }
        }
        private void EditButtonClicked(object sender, RoutedEventArgs e)
        {
            var selectedRule=(IRule)_RuleListBox.SelectedItem;
            int num = selectedRule.Position;
            if (selectedRule != null)
            {
                for (int i = 0; i < rules.Count; i++)
                {
                    var rule = rules[i];
                    if (rule.Position == selectedRule.Position)
                    {
                        IRule r = null;
                        r = rule.ShowEditUI(rule);
                        rules[i] = r;
                        updateRuleList();
                    }
                }
            }
            else
            {
                MessageBox.Show("Please chose rule posotion!");
            }
        }
        private void deleteRuleButton(object sender, RoutedEventArgs e)
        {
            _RuleListBox.ItemsSource = null;
            _RuleListBox.Items.Clear();
            //_CountRuleComboBox.Items.Clear();
            fileTab.ItemsSource = null;
            fileTab.Items.Clear();
            folderTab.ItemsSource = null;
            folderTab.Items.Clear();
            rules.Clear();
            // clear source collections
            if (fileList != null) fileList.Clear();
            if (folderList != null) folderList.Clear();
        }

        private void deleteSaveButton(object sender, RoutedEventArgs e)
        {
            // Folder and File Path
            string saveFolderPath = @"C:\BatchRenameSave";
            string saveFilePath = @"C:\BatchRenameSave\Progress.txt";
            // Screen
            var screen = new OpenFileDialog();
            // Checking Screen
            if (screen.ShowDialog() == true)
            {
                var info = new FileInfo(screen.FileName);
                string filename = info.Name;
                // Checking if screen Path = File Path
                if (screen.FileName == saveFilePath)
                {
                    using (StreamWriter sw = new StreamWriter(saveFilePath))
                    {
                        sw.Dispose();
                    }
                    MessageBox.Show("Delete file save successfully!");
                }
                else
                {
                    MessageBox.Show($"{saveFilePath} is the Save File!");
                }
            }
            else
            {
                MessageBox.Show("File not been found!");
            }
        }


        private void loadButton(object sender, RoutedEventArgs e)
        {
            // Folder and File Path
            string saveFolderPath = @"C:\BatchRenameSave";
            string saveFilePath = @"C:\BatchRenameSave\Progress.txt";
            // Screen
            var screen = new OpenFileDialog();


            // Checking Screen
            if (screen.ShowDialog() == true)
            {
                // Take Name
                var info = new FileInfo(screen.FileName);
                string filename = info.Name;
                if (screen.FileName == saveFilePath)
                {
                    //string[] lines = File.ReadAllLines(filename);
                    using (StreamReader sr = new StreamReader(screen.FileName))
                    {
                        string line = sr.ReadLine();
                        while ((line = sr.ReadLine()) != "---END---")
                        {
                            if (line.Contains("AddCounter"))
                            {
                                IRule rule = new AddCounter();
                                countRule++;
                                rule.Position = countRule;
                                var item = new
                                {
                                    RuleCount = countRule,
                                };
                                rules.Add(rule);
                            }
                            else if (line.Contains("AddPrefix"))
                            {
                                string[] tokens = line.Split(" Set ");
                                IRule rule = new AddPrefix();
                                rule = rule.Parse(tokens[1]);
                                countRule++;
                                rule.Position = countRule;
                                var item = new
                                {
                                    RuleCount = countRule,
                                };
                                rules.Add(rule);
                            }
                            else if (line.Contains("LowerCase"))
                            {
                                IRule rule = new LowerCase();
                                countRule++;
                                rule.Position = countRule;
                                var item = new
                                {
                                    RuleCount = countRule,
                                };
                                rules.Add(rule);
                            }
                            else if (line.Contains("RemoveAllSpace"))
                            {
                                IRule rule = new RemoveAllSpace();
                                countRule++;
                                rule.Position = countRule;
                                var item = new
                                {
                                    RuleCount = countRule,
                                };
                                rules.Add(rule);
                            }
                            else if (line.Contains("AddSurfix"))
                            {
                                string[] tokens = line.Split(" Set ");
                                IRule rule = new AddSurfix();
                                rule = rule.Parse(tokens[1]);
                                countRule++;
                                rule.Position = countRule;
                                var item = new
                                {
                                    RuleCount = countRule,
                                };
                                rules.Add(rule);
                            }
                            else if (line.Contains("ConvertToPascal"))
                            {
                                IRule rule = new ConvertToPascalCase();
                                countRule++;
                                rule.Position = countRule;
                                var item = new
                                {
                                    RuleCount = countRule,
                                };
                                rules.Add(rule);
                            }
                            else if (line.Contains("ChangeExtension"))
                            {
                                string[] tokens = line.Split(" Set ");
                                IRule rule = new ChangeExtension();
                                rule = rule.Parse(tokens[1]);
                                countRule++;
                                rule.Position = countRule;
                                var item = new
                                {
                                    RuleCount = countRule,
                                };
                                rules.Add(rule);
                            }
                            else if (line.Contains("Replace"))
                            {
                                string[] tokens = line.Split(" Set ");
                                IRule rule = new Replace();
                                rule = rule.Parse(tokens[1]);
                                countRule++;
                                rule.Position = countRule;
                                var item = new
                                {
                                    RuleCount = countRule,
                                };
                                rules.Add(rule);
                            }
                        }
                    }
                    updateRuleList();
                }
            }
            else
            {
                MessageBox.Show($"{saveFilePath} is the Save File!");
            }
        }

        private void saveButton(object sender, RoutedEventArgs e)
        {
            string saveFolderPath = @"C:\BatchRenameSave";
            string saveFilePath = @"C:\BatchRenameSave\Progress.txt";
            if (_RuleListBox.Items.Count == 0)
            {
                MessageBox.Show("Nothing to save!");
                return;
            }
            // Checking if Folder is not existing
            if (!Directory.Exists(saveFolderPath))
            {
                // Create new Folder
                Directory.CreateDirectory(saveFolderPath);
            }
            // Checking if File Save is existing ?
            if (File.Exists(saveFolderPath))
            {
                // Write data into File
                using (StreamWriter sw = new StreamWriter(saveFilePath))
                {
                    // Save rules
                    foreach (var rule in rules)
                    {
                        string ruleInfo = $"{rule.GetType().FullName} {rule.Description}";
                        sw.WriteLine(ruleInfo);
                    }
                    // End of script
                    sw.Write("---END---");
                }
                // Show Message if Save Successfully
                MessageBox.Show($"Save successfully at {saveFilePath}");
            }
            else
            {
                // Create new File
                using (StreamWriter sw = File.CreateText(saveFilePath))
                {
                    // File Save's Name
                    sw.WriteLine("Save History");
                    // Save Rule
                    foreach (var rule in rules)
                    {
                        string ruleInfo = $"{rule.GetType().FullName} {rule.Description}";
                        sw.WriteLine(ruleInfo);
                    }
                    // End of script
                    sw.Write("---END---");
                }
                // Show Message if Save Successfully
                MessageBox.Show($"Save successfully at {saveFilePath}");
            }
        }

        

        private void _batchRename_click(object sender, RoutedEventArgs e)
        {
            fileList = new ObservableCollection<FileClass>();
            folderList = new ObservableCollection<FolderClass>();
            //Add items from fileTab    
            foreach (FileClass file in fileTab.Items) fileList.Add(file);
            //If no method is selected
            if (_RuleListBox.Items.Count == 0)
            {
                MessageBox.Show("Method box is empty!");
                return;
            }
            //If no file in FileTab
            if (fileList.Count == 0)
            {
                MessageBox.Show("No file in List!");
                return;
            }
            for (int i = 0; i < fileList.Count; i++)
            {
                string result = fileList[i].FileName;
                string path = fileList[i].FilePath;
                foreach (IRule rule in _RuleListBox.Items)
                {
                    if (rule.Name == "AddCounter")
                    {
                        string counterNum = fileCount.ToString();
                        rule.Parse(counterNum);
                    }
                    result = rule.Rename(result);
                    ObservableCollection<FileClass> temp = new(fileList);
                    temp.Remove(temp[i]);
                    foreach (FileClass f in temp)
                    {
                        if (result == f.FileName)
                        {
                            fileList[i].FileError = "Duplicate File Name.";
                            fileList[i].FileRename = result;
                        }
                    }
                    if (result == " ")
                    {
                        // a space mean there was an error when executed this method 
                        fileList[i].FileError = "Renaming file failed";
                        break;
                    }
                }
                if (fileList[i].FileError != "Duplicate File Name.")
                {
                    fileList[i].FileRename = result;
                    fileList[i].FileError = "Successful";
                }
                if (fileList[i].FileError == "Successful")
                {

                    var info = new FileInfo(fileList[i].FilePath);
                    var Folder = info.Directory;
                    var newPath = $"{Folder}\\{result}";
                    File.Move(fileList[i].FilePath, newPath);
                    MessageBox.Show($"Renamed Successful");
                }
                fileCount = 0;
            }
            for (int i = 0; i < folderList.Count; i++)
            {
                string result = folderList[i].FolderName;
                string path = folderList[i].FolderPath;
                foreach (IRule rule in _RuleListBox.Items)
                {
                    if (rule.Name == "AddCounter")
                    {
                        string counterNum = fileCount.ToString();
                        rule.Parse(counterNum);
                    }
                    result = rule.Rename(result);
                    ObservableCollection<FolderClass> temp = new(folderList);
                    temp.Remove(temp[i]);
                    foreach (FolderClass f in temp)
                    {
                        if (result == f.FolderName)
                        {
                            folderList[i].FolderError = "Duplicate Folder Name.";
                            folderList[i].FolderRename = result;
                        }
                    }
                    if (result == " ")
                    {
                        // a space mean there was an error when executed this method 
                        folderList[i].FolderError = "Renaming folder failed";
                        break;
                    }
                }
                // all done without error?
                if (folderList[i].FolderError != "Duplicate Folder Name.")
                {
                    folderList[i].FolderRename = result;
                    folderList[i].FolderError = "Successful.";
                }
                if (folderList[i].FolderError == "Successful.")
                {
                    var info = new FileInfo(folderList[i].FolderPath);
                    var Folder = info.Directory;
                    var newPath = $"{Folder}\\{result}";
                    File.Move(folderList[i].FolderPath, newPath);
                    MessageBox.Show($"Renamed Successful");
                }
                fileCount = 0;
            }
        }

        private void _RuleListBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        
    }
}
