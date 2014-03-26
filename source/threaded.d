
module threaded;

import common;

import std.concurrency;

num threadedFiboRec(in num nth)
{
    spawn(&fiboThread, thisTid, nth);
    return receiveOnly!num;
}

private void fiboThread(Tid owner_tid, num nth)
{
    if (nth == 0)
    {
        send(owner_tid, 0U);
        return;
    }
    if (nth == 1)
    {
        send(owner_tid, 1U);
        return;
    }

    spawn(&fiboThread, thisTid, nth - 1);
    spawn(&fiboThread, thisTid, nth - 2);

    num a = receiveOnly!num;
    num b = receiveOnly!num;

    send(owner_tid, a + b);
}
