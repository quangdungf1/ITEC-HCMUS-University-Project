using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Contract;

namespace AddPrefixRule
{
    public class AddPrefix : IRule
    {
        public string Name { get; set; } = "AddPrefix";
        public string Value { get; set; } = "";
        public string Description { get; set; } = "";
        public int Position { get; set; } = 1;
        public IRule Clone()
        {
            return new AddPrefix();
        }
        public IRule Parse(string data)
        {
            IRule rule = null;
            rule = new AddPrefix()
            {
                Value = data,
                Description = $"Set {data}",
            };
            return rule;
        }
        public string Rename(string origin)
        {
            var sb = new StringBuilder();
            sb.Append(Value);
            sb.Append(" ");
            sb.Append(origin);
            return sb.ToString();
        }

        public IRule ShowEditUI(IRule name)
        {
            var screen = new AddPrefixUI(name);
            if (screen.ShowDialog() == true)
            {
                name = screen.ReturnData;
            }
            return name;
        }
    }
}
