using System;


//  Abstract Class

namespace AbstractVersion
{
    // Abstract Base Class
    abstract class Notification
    {
        // مشترك بين جميع الكلاسات
        protected string message;

        // Constructor
        public Notification(string m)
        {
           message = m;
        }

        // لازم يتم تعريفها في الأبناء
        public abstract void Send();

        // concrete method - regular 
        public void Preview()
        {
            Console.WriteLine("Preview: " + message);
        }
    }

    // Email
    class EmailNotification : Notification
    {
        private string emailAddress;

        //constructor+inheretance
        public EmailNotification(string m, string e): base(m)
        {
            emailAddress = e;
        }

        public override void Send()
        {
            Console.WriteLine($"[Email] To {emailAddress}: {message}");
        }
    }

    // SMS
    class SMSNotification : Notification
    {
        private string phoneNumber;

        public SMSNotification(string m, string p)
            : base(m)
        {
            phoneNumber = p;
        }

        public override void Send()
        {
            Console.WriteLine($"[SMS] To {phoneNumber}: {message}");
        }
    }

    // Push
    class PushNotification : Notification
    {
        private string deviceId;

        public PushNotification(string m, string d)
            : base(m)
        {
           deviceId = d;
        }

        public override void Send()
        {
            Console.WriteLine($"[Push] To Device {deviceId}: {message}");
        }
    }
}

//  Interface
namespace InterfaceVersion
{
    // Interface (فقط تعريف)
    interface INotification
    {
        void Send();
    }

    // Email
    class EmailNotification : INotification
    {
        private string message;
        private string emailAddress;

        public EmailNotification(string m, string e)
        {
            message = m;
            emailAddress = e;
        }

        public void Send()
        {
            Console.WriteLine($"[Email] To {emailAddress}: {message}");
        }
    }

    // SMS
    class SMSNotification : INotification
    {
        private string message;
        private string phoneNumber;

        public SMSNotification(string m, string p)
        {
           message = m;
           phoneNumber = p;
        }

        public void Send()
        {
            Console.WriteLine($"[SMS] To {phoneNumber}: {message}");
        }
    }

    // Push
    class PushNotification : INotification
    {
        private string message;
        private string deviceId;

        public PushNotification(string m, string d)
        {
            message = m;
            deviceId = d;
        }

        public void Send()
        {
            Console.WriteLine($"[Push] To Device {deviceId}: {message}");
        }
    }
}


class Program
{
    static void Main(string[] args)
    { // AbstractVersion: اسم ال namespace  لانه عندي 2 
        AbstractVersion.Notification n1 = new AbstractVersion.EmailNotification("Email!", "test@email.com");

        AbstractVersion.Notification n2 = new AbstractVersion.SMSNotification(" SMS!", "0791234567");

        AbstractVersion.Notification n3 = new AbstractVersion.PushNotification(" Push!", "Device123");

        // Preview + Send
        n1.Preview();
        n1.Send();

        n2.Preview();
        n2.Send();

        n3.Preview();
        n3.Send();

        Console.WriteLine("  ");

        InterfaceVersion.INotification i1 =
            new InterfaceVersion.EmailNotification(" Email!", "test@email.com");

        InterfaceVersion.INotification i2 =
            new InterfaceVersion.SMSNotification(" SMS!", "0791234567");

        InterfaceVersion.INotification i3 =
            new InterfaceVersion.PushNotification(" Push!", "Device123");

        // فقط Send لا يوجد Preview
        i1.Send();
        i2.Send();
        i3.Send();

        Console.ReadKey();
    }
}