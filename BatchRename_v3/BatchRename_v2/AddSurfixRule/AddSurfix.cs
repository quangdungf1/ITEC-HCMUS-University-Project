using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Contract;
namespace AddSurfixRule
{
    public class AddSurfix : IRule
    {
        public string Name { get; set; } = "AddSurfix";
        public string Description { get; set; } = "";
        public int Position { get; set; }
        public string suffix_char { get; set; } = "";
        public IRule Clone()
        {
            return new AddSurfix();
        }

        public IRule Parse(string data)
        {
            IRule rule = null;
            
            rule = new AddSurfix()
            {
                suffix_char = data,
                Description = $"Set {data}",
            };
            return rule;
        }

        public string Rename(string origin)
        {
            var sb = new StringBuilder();
            sb.Append(origin);
            sb.Append(" ");
            sb.Append(suffix_char);
            return sb.ToString();
        }

        public IRule ShowEditUI(IRule name)
        {
            var screen = new AddSurfixUI(name);
            if (screen.ShowDialog() == true)
            {
                name = screen.ReturnData;
            }
            return name;
        }
    }
}
