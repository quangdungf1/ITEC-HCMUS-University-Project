using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Contract;

namespace ChangeExtensionRule
{
    public class ChangeExtension : IRule
    {
        public string Name { get; set; } = "Change Extension";
        public string Extension { get; set; } = "";
        public int Position { set; get; } = 1;
        public string Description { get; set; } = "";
        public string Rename(string str)
        {
            int dotIndex = str.LastIndexOf(".");
            string ext = str.Substring(dotIndex);
            string name = str.Substring(0, dotIndex);
            return $"{name}.{Extension}";
        }
        public IRule Parse(string data)
        {
            IRule rule = null;
            rule = new ChangeExtension()
            {
                Extension = data,
                Description = $"Set {data}",
            };
            return rule;

        }
        public IRule Clone()
        {
            return new ChangeExtension();
        }

        public IRule ShowEditUI(IRule name)
        {
            var screen = new ChangeExtensionUI(name);
            if (screen.ShowDialog() == true)
            {
                name = screen.ReturnData;
            }
            return name;
        }
    }
}
