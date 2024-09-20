using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Contract;

namespace ReplaceRule
{
    public class Replace : IRule
    {
        public string Name { get; set; } = "Replace";
        public string FromString { get; set; } = "";
        public string ToString { get; set; } = "";
        public string Description { get; set; } = "";
        public int Position { get; set; } = 1;

        public IRule Clone()
        {
            return new Replace();
        }

        public IRule Parse(string data)
        {
            IRule rule = null;
            string[] tokens = data.Split(new string[] { " " }, StringSplitOptions.None);
            rule = new Replace()
            {
                FromString = tokens[0],
                ToString = tokens[2],

                Description = $"Set {tokens[0]} ==> {tokens[2]} ",
            };
            return rule;
        }

        public string Rename(string origin)
        {
            string result = "";

            StringBuilder sb = new StringBuilder();

            sb.Append(origin);
            sb.Replace(FromString, ToString);
            result = sb.ToString();
            return result;
        }

        public IRule ShowEditUI(IRule name)
        {
            var screen = new ReplaceUI(name);
            if (screen.ShowDialog() == true)
            {
                name = screen.ReturnData;
            }
            return name;
        }
    }
}
