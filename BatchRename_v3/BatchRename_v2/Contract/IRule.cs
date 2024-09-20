using System.Runtime;
using System.Text;
using System;
using System.Globalization;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.IO;
using System.Runtime.ConstrainedExecution;
using System.Data;


namespace Contract

{
    public interface IRule
    {
        public string Name { get; set; }
        public int Position { get; set; }
        public string Description { get; set; }
        public string Rename(string origin);
        public IRule ShowEditUI(IRule name);
        public IRule Parse(string data);
        public IRule Clone();


    }
}