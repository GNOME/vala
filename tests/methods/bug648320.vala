public interface Foo : Object {
	public abstract int i { get; set; }

	public void foo () {
		int j = 0;
		SourceFunc bar = () => j == i;
	}
}

void main() {
}
