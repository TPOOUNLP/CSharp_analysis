using System;

namespace CsharpProject
{
    class ClassWithRepeatedMethods
    {
        static void Main(string[] args)
        {
            Console.WriteLine("A class with repeated methods");
        }

        public static void MethodRepeated1()
        {
            Console.WriteLine("Hello world, method repeated in the same class");
        }

        public static void MethodRepeated2()
        {
            Console.WriteLine("Hello world, method repeated in the same class");
        }

        public static void DiferentClassesMethodRepeated1()
        {
            Console.WriteLine("Hello world, method repeated in different classes");
        }
    }
}
