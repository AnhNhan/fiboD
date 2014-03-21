
module iterative;

import common;

num fiboIterative(in num nth)
{
    if (nth == 0)
        return 0;
    if (nth == 1)
        return 1;

    num a = 1;
    num b = 1;
    num c;

    num step = 2;

    for (; step < nth; ++step)
    {
        b = a + b;
        c = a;
        a = b;
        b = c;
    }

    return a;
}
