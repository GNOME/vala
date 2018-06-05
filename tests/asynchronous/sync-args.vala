public interface IFoo : Object {
	public abstract async string ifunc (int i, out int out_j, string s) throws Error;
}

public class Foo : Object, IFoo {
	public async string ifunc (int i, out int out_j, string s) throws Error {
		assert (i == 23);
		assert (s == "ifoo");
		return "result_ifoo";
	}

	public virtual async string vfunc (int i, out int out_j, string s) throws Error {
		assert (i == 42);
		assert (s == "vfoo");
		return "result_vfoo";
	}

	public async string func (int i, string s, [SyncArg] out int out_j) throws Error {
		assert (i == 4711);
		assert (s == "foo");
		return "result_foo";
	}
}

async void run () {
	var foo = new Foo ();
	int i;
	foo.ifunc.begin (23, out i, "ifoo", (o, r) => {
		var result = ((Foo) o).ifunc.end (r);
		assert (result == "result_ifoo");
	});
	foo.vfunc.begin (42, out i, "vfoo", (o, r) => {
		var result = ((Foo) o).ifunc.end (r);
		assert (result == "result_vfoo");
	});
	foo.func.begin (4711, "foo", out i, (o, r) => {
		var result = ((Foo) o).ifunc.end (r);
		assert (result == "result_foo");
	});
}

void main () {
	run.begin ();
}
