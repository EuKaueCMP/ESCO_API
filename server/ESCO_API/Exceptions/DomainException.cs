namespace ESCO_API.Excptions
{
    public class DomainExceptionException : Exception
    {
        public DomainExceptionException(string message) : base(message) { }
    }
}