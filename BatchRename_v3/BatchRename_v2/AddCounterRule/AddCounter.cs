using Contract;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace AddCounterRule
{
    public class AddCounter : IRule
    {
        public string Name { get; set; } = "Add Counter";
        public int Position { set; get; } = 1;
        public int AddFileCount { set; get; }
        public string Description { get; set; } = "";

        public string Rename(string str)
        {
            AddFileCount++;
            if (str.Contains("."))
            {
                int dotIndex = str.LastIndexOf(".");
                string ext = str.Substring(dotIndex);
                string name = str.Substring(0, dotIndex);
                return $"{name} ({AddFileCount}){ext}";
            }
            else
                return $"{str} ({AddFileCount})";
        }

        public IRule Parse(string str)
        {
            IRule rule = null;
            rule = new AddCounter()
            {
                AddFileCount = Convert.ToInt16(str)
            };
            return rule;

        }
        public IRule Clone()
        {
            return new AddCounter();
        }

        public IRule ShowEditUI(IRule name)
        {

            return name;
        }


    }
}