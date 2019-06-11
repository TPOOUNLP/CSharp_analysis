using System;

namespace CsharpProject
{
    class TooManyLinesInMethodClass
    {
        static void Main(string[] args)
        {
            Console.WriteLine("A class with too many lines in some methods");
        }

        public static void MethodWith11Lines()
        {
            Console.WriteLine("line1");
            Console.WriteLine("line2");
            Console.WriteLine("line3");
            Console.WriteLine("line4");
            Console.WriteLine("line5");
            Console.WriteLine("line6");
            Console.WriteLine("line7");
            Console.WriteLine("line8");
            Console.WriteLine("line9");
            Console.WriteLine("line10");
            Console.WriteLine("line11");
        }

        public static void MethodWith21Lines()
        {
            Console.WriteLine("line1");
            Console.WriteLine("line2");
            Console.WriteLine("line3");
            Console.WriteLine("line4");
            Console.WriteLine("line5");
            Console.WriteLine("line6");
            Console.WriteLine("line7");
            Console.WriteLine("line8");
            Console.WriteLine("line9");
            Console.WriteLine("line10");
            Console.WriteLine("line11");
            Console.WriteLine("line12");
            Console.WriteLine("line13");
            Console.WriteLine("line14");
            Console.WriteLine("line15");
            Console.WriteLine("line16");
            Console.WriteLine("line17");
            Console.WriteLine("line18");
            Console.WriteLine("line19");
            Console.WriteLine("line20");
            Console.WriteLine("line21");
        }

        public static void MethodWith1Line()
        {
            Console.WriteLine("line1");
        }

        public static void MethodWith5Lines()
        {
            Console.WriteLine("line1");
            Console.WriteLine("line2");
            Console.WriteLine("line3");
            Console.WriteLine("line4");
            Console.WriteLine("line5");
        }
    }
}
