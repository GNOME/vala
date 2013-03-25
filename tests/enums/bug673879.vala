enum Test
{
    TEST = 10
}

void main()
{
    Test? test = null;

    test = Test.TEST;
    assert ((!)test == 10);
}
