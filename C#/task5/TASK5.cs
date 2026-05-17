using PaymentSystem;
using System;

namespace PaymentSystem
{
    // Base Class
    class Payment
    {
        public double Amount;

        public Payment(double amount) //constructor انشاء
        {
            Amount = amount;
        }

        //  override
        public virtual void ProcessPayment()
        {
            Console.WriteLine(" payment Process");
        }

        //  Pay(amount)
        public void Pay(double amount)
        {
            Amount = amount;
            ProcessPayment();

        }

        //  Pay(amount, currency)
        public void Pay(double amount, string currency)
        {
            Amount = amount;
            Console.WriteLine($"Currency: {currency}");
            ProcessPayment();
        }
    }

    class Cash : Payment
    {
        public Cash(double amount) : base(amount) //constructor +inheretance
        { 
        }

        public override void ProcessPayment()
        {
            Console.WriteLine($"Cash Payment of {Amount} processed successfully.");
        }

       
    }

    class CreditCard : Payment
    {
        private int SecurityCode;

        public CreditCard(double amount, int securityCode) : base(amount) //constructor +inheretance
        {
            SecurityCode = securityCode;
        }

        public override void ProcessPayment()
        {
            Console.WriteLine($"Credit Card Payment of {Amount} processed successfully.");
            Console.WriteLine($"Security Code Verified: {SecurityCode}");
        }
    }


}

class Program
{
    static void Main(string[] args)
    {
        // Cash payment
        Cash C = new Cash(100);
        C.Pay(100);

        Console.WriteLine("  ");

        // Credit Card payment
        CreditCard Cc = new CreditCard(250, 123);
        Cc.Pay(250, "USD");

        Console.ReadKey();
    }

}