using GLib;

[Compact]
class CompactClass {
	public int field;
}

[Compact]
class CompactClassWithDestructor {
	~CompactClassWithDestructor () {
		stdout.printf ("~CompactClassWithDestructor\n");
	}

	/* FIXME bug 533977 */
	public char dummy;
}

class DerivedClass : CompactClass {
}

[Compact]
public class PublicClass {
	public int field;
}

[Compact]
abstract class AbstractClass {
	public int field;
}

[Compact]
class ClassWithCreationMethod {
	public ClassWithCreationMethod () {
		stdout.printf ("ClassWithCreationMethod\n");
	}

	public int field;
}

[Compact]
class ClassWithNamedCreationMethod {
	public ClassWithNamedCreationMethod.named () {
		stdout.printf ("ClassWithNamedCreationMethod\n");
	}

	public int field;
}

class SimpleGTypeInstanceClass {
}

class DerivedGTypeInstanceClass : SimpleGTypeInstanceClass {
}

public class PublicGTypeInstanceClass {
}

class GTypeInstanceClassWithCreationMethod {
	public GTypeInstanceClassWithCreationMethod () {
		stdout.printf ("GTypeInstanceClassWithCreationMethod\n");
	}
}

class GTypeInstanceClassWithNamedCreationMethod {
	public GTypeInstanceClassWithNamedCreationMethod.named () {
		stdout.printf ("GTypeInstanceClassWithNamedCreationMethod\n");
	}
}

class SimpleGObjectClass : Object {
}

class DerivedGObjectClass : SimpleGObjectClass {
}

public class PublicGObjectClass : Object {
}

abstract class AbstractGObjectClass : Object {
}

class GObjectClassWithCreationMethod : Object {
	public GObjectClassWithCreationMethod () {
	}
}

class GObjectClassWithNamedCreationMethod : Object {
	public GObjectClassWithNamedCreationMethod.named () {
	}
}

void main () {
	stdout.printf ("Classes Test:\n");

	stdout.printf ("new CompactClass ()\n");
	var compact_class = new CompactClass ();
	stdout.printf ("new DerivedClass ()\n");
	var derived_class = new DerivedClass ();
	stdout.printf ("new PublicClass ()\n");
	var public_class = new PublicClass ();
	stdout.printf ("new ClassWithCreationMethod ()\n");
	var class_with_creation_method = new ClassWithCreationMethod ();
	stdout.printf ("new ClassWithNamedCreationMethod ()\n");
	var class_with_named_creation_method = new ClassWithNamedCreationMethod.named ();
	stdout.printf ("new CompactClassWithDestructor ()\n");
	var compact_class_with_destructor = new CompactClassWithDestructor ();
	compact_class_with_destructor = null;

	stdout.printf ("new SimpleGTypeInstanceClass ()\n");
	var simple_gtypeinstance_class = new SimpleGTypeInstanceClass ();
	stdout.printf ("new DerivedGTypeInstanceClass ()\n");
	var derived_gtypeinstance_class = new DerivedGTypeInstanceClass ();
	stdout.printf ("new PublicGTypeInstanceClass ()\n");
	var public_gtypeinstance_class = new PublicGTypeInstanceClass ();
	stdout.printf ("new GTypeInstanceClassWithCreationMethod ()\n");
	var gtypeinstance_class_with_creation_method = new GTypeInstanceClassWithCreationMethod ();
	stdout.printf ("new GTypeInstanceClassWithNamedCreationMethod ()\n");
	var gtypeinstance_class_with_named_creation_method = new GTypeInstanceClassWithNamedCreationMethod.named ();

	stdout.printf ("new SimpleGObjectClass ()\n");
	var simple_gobject_class = new SimpleGObjectClass ();
	stdout.printf ("new DerivedGObjectClass ()\n");
	var derived_gobject_class = new DerivedGObjectClass ();
	stdout.printf ("new PublicGObjectClass ()\n");
	var public_gobject_class = new PublicGObjectClass ();
	stdout.printf ("new GObjectClassWithCreationMethod ()\n");
	var gobject_class_with_creation_method = new GObjectClassWithCreationMethod ();
	stdout.printf ("new GObjectClassWithNamedCreationMethod ()\n");
	var gobject_class_with_named_creation_method = new GObjectClassWithNamedCreationMethod.named ();

	stdout.printf ("new CompactClass () { field = 1 }\n");
	compact_class = new CompactClass () { field = 1 };
	stdout.printf ("compact_class.field = %d\n", compact_class.field);

	stdout.printf (".\n");
}

