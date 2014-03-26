
import common;
import iterative;
import recursive;
import threaded;

import std.stdio;

alias FibonacciFunction = num function(in num);

void main()
{
    auto fibonacciSequence = [
        0,
        1,
        1,
        2,
        3,
        5,
        8,
        13,
        21,
        34,
        55,
        89,
        144,
        233,
        377,
        610,
        987,
    ];

    auto perfTestNths = [3, 5, 10, 20];

    FibonacciFunction[string] functions = [
        "fiboIterative" : &fiboIterative
      , "fiboRec" : &fiboRec
      , "fiboRecMemo": &fiboRecMemo
      , "fiboRecDynamicMemo": &fiboRecDynamicMemo
      //, "threadedFiboRec": &threadedFiboRec
    ];

    writeln("");

    foreach (name, func; functions)
    {
        writeln("Function " ~ name ~ ":");

        write("  ");
        for (int step; step < fibonacciSequence.length; ++step)
        {
            cmp(fibonacciSequence[step], func(step));
        }

        write("\n\n");

        writeln("  Perf test:");
        foreach (nth; perfTestNths)
        {
            writeln("    N = ", nth);
            perf(func, nth, name);
        }

        write("\n\n");
    }

    writeln("Finito.");
}

void cmp(V1, V2)(V1 exp, V2 act)
{
    if (exp != act)
    {
        import std.conv : to;
        writeln("expectation failed. expected " ~ to!string(exp) ~ ", but got " ~ to!string(act));
        return;
    }

    write(".");
}

void perf(F, V, S)(F f, V v, S f_name)
{
    import std.datetime : StopWatch;

    StopWatch w;

    w.start();

    for (int ii; ii < NumPerfIterations; ++ii)
    {
        f(v);
    }

    w.stop();

    writeln("    " ~ f_name ~ " took ", w.peek.msecs, "ms");
}
