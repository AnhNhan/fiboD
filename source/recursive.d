
module recursive;

import common;

num fiboRec(in num nth)
{
    if (nth == 0)
        return 0;
    if (nth == 1)
        return 1;

    return fiboRec(nth - 1) + fiboRec(nth - 2);
}

/**
 * Recursive Fibonacci with an associative array for memoization.
 */

alias Memo = num[num];
enum MemoInitVal = num.max;

num fiboRecMemo(in num nth)
{
    if (nth == 0)
        return 0;
    if (nth == 1)
        return 1;

    Memo memo;

    for (int ii; ii < nth; ++ii)
    {
        memo[ii] = MemoInitVal;
    }

    memo[nth] = fiboRecMemo(nth - 1, memo) + fiboRecMemo(nth - 2, memo);

    return memo[nth];
}

num fiboRecMemo(in num nth, ref Memo memo)
{
    if (nth == 0)
        return 0;
    if (nth == 1)
        return 1;

    if (memo[nth] == MemoInitVal)
    {
        memo[nth] = fiboRecMemo(nth - 1, memo) + fiboRecMemo(nth - 2, memo);
    }

    return memo[nth];
}

/**
 * Recursive Fibonacci with a dynamic array for memoization.
 */

alias DynamicMemo = num[];

// Template param nth_t is only for initialization.
num fiboRecDynamicMemo(in num nth)
{
    if (nth == 0)
        return 0;
    if (nth == 1)
        return 1;

    DynamicMemo memo;
    memo.length = nth + 1;

    for (int ii; ii <= nth; ++ii)
    {
        memo[ii] = MemoInitVal;
    }

    memo[nth] = fiboRecDynamicMemo(nth - 1, memo) + fiboRecDynamicMemo(nth - 2, memo);

    return memo[nth];
}

num fiboRecDynamicMemo(in num nth, ref DynamicMemo memo)
{
    if (nth == 0)
        return 0;
    if (nth == 1)
        return 1;

    if (memo[nth] == MemoInitVal)
    {
        memo[nth] = fiboRecDynamicMemo(nth - 1, memo) + fiboRecDynamicMemo(nth - 2, memo);
    }

    return memo[nth];
}
