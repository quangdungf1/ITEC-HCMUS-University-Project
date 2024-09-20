using Contract;
namespace RemoveAllSpaceRule
{
    public class RemoveAllSpace : IRule
    {
        public string Name { get; set; } = "Remove All Space From Begining to End ";
        public int Position { set; get; } = 1;
        public string Description { get; set; } = "";
        public string Rename(string str)
        {
            string newstr = str.Trim();
            return newstr;
        }
        public IRule Parse(string str)
        {
            IRule rule = null;
            rule = new RemoveAllSpace();
            return rule;
        }
        public IRule Clone()
        {
            return new RemoveAllSpace();
        }
        public IRule ShowEditUI(IRule name)
        {
            return name;
        }
    }
}