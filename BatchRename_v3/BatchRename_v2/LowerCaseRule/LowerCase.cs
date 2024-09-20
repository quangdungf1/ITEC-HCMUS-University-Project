using System.Text.RegularExpressions;
using Contract;
namespace LowerCaseRule
{
    public class LowerCase : IRule
    {
        public string Name { get; set; } = "LowerCase";
        public int Position { set; get; } = 1;
        public string Description { get; set; } = "";
        public string Rename(string str)
        {
            str = Regex.Replace(str.Trim(), @"\s+", " ").ToLower();
            str = str.Replace(" ", "");
            return str;
        }
        public IRule Parse(string data)
        {
            IRule rule = null;

            rule = new LowerCase();

            return rule;
        }
        public IRule Clone()
        {
            return new LowerCase();
        }
        public IRule ShowEditUI(IRule name)
        {
            return name;
        }
    }
}