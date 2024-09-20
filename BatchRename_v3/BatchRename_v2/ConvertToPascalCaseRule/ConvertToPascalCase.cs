using System.Globalization;
using Contract;
namespace ConverToPascalRule
{
    public class ConvertToPascalCase : IRule
    {
        public string Name { get; set; } = "Convert To Pascal";
        public int Position { set; get; } = 1;
        public string Description { get; set; } = "";
        public string Rename(string str)
        {
            return new CultureInfo("en-US").TextInfo.ToTitleCase(str);
        }
        public IRule Parse(string str)
        {
            IRule rule = null;
            rule = new ConvertToPascalCase();
            return rule;
        }
        public IRule Clone()
        {
            return new ConvertToPascalCase();
        }
        public IRule ShowEditUI(IRule name)
        {
            return name;
        }
    }
}