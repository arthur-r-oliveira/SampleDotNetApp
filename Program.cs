// See https://aka.ms/new-console-template for more information
Console.WriteLine("Hello, World!");

DateTime utcTime = DateTime.UtcNow;
Console.WriteLine($"UTC Time Before: {utcTime.ToUniversalTime()}");
Console.WriteLine($"Local Time: {utcTime.ToLocalTime()})");
