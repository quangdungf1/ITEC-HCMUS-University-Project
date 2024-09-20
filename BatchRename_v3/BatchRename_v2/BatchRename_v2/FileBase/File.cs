using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BatchRename_v2.FileBase
{
    public class FileClass : INotifyPropertyChanged
    {
        public string? FileName { get; set; }
        public string? FilePath { get; set; }
        public string? FileRename { get; set; }
        public string? FileError { get; set; }


        public event PropertyChangedEventHandler? PropertyChanged;
        private void NotifyChange(string origin)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged.Invoke(this, new PropertyChangedEventArgs(origin));
            }
        }
        public FileClass Clone()
        {
            return new FileClass()
            {
                FileName = this.FileName,
                FileRename = this.FileRename,
                FilePath = this.FilePath,
            };
        }

    }

    public class FolderClass : INotifyPropertyChanged
    {

        public string? FolderName { get; set; }

        public string? FolderRename { get; set; }
        public string? FolderPath { get; set; }
        public string? FolderError { get; set; }

        public event PropertyChangedEventHandler? PropertyChanged;
        private void NotifyChange(string origin)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged.Invoke(this, new PropertyChangedEventArgs(origin));
            }
        }
        public FolderClass Clone()
        {
            return new FolderClass()
            {
                FolderName = this.FolderName,
                FolderRename = this.FolderRename,
                FolderPath = this.FolderPath

            };
        }
    }
}
