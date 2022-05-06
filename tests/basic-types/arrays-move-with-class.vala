class TestDestructorCalls {
	public static int destructor_calls = 0;
	private int idx;

	public TestDestructorCalls (int idx) { this.idx = idx; }

	~TestDestructorCalls () { destructor_calls++; }
}

void test_array_with_classes_move (int src, int dest, int count, int expected_destructor_calls)
{
	const int arr_size = 5;
	TestDestructorCalls.destructor_calls = 0; 
	TestDestructorCalls[] arr = new TestDestructorCalls[arr_size];
        for(int i=0; i<arr_size; i++)
	{
            arr[i] = new TestDestructorCalls (i);
	}

        arr.move (src, dest, count);
	assert (TestDestructorCalls.destructor_calls == expected_destructor_calls);
}

void main()
{
	test_array_with_classes_move(0, 2, 3, 1);
	test_array_with_classes_move(2, 0, 3, 2);
	test_array_with_classes_move(0, 3, 1, 1);

}
