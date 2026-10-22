namespace ESCO_API.Excptions
{
    public class DomainException : Exception
    {
        public DomainException(string message) : base(message) { }
    }
}