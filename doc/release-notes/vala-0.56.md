# Vala 0.56

After 4 months of work we are proud to announce a new release of Vala. This time it contains lots of new language features and advancements and of course also the usual bug fixes and binding updates.

### Asynchronous Main Function

With the new release the main function can now be defined as `async`. This has multiple advantages. For example is it now possible to call asynchronous functions with `yield`:

```vala
async int main (string[] args) {
    string dir = args.length == 2 ? args[1] : ".";
    var file = File.new_for_commandline_arg (dir);
    try {
        FileEnumerator enumerator =
            yield file.enumerate_children_async (
                "standard::*,time::*",
                FileQueryInfoFlags.NOFOLLOW_SYMLINKS
            );
        List<FileInfo> children =
            yield enumerator.next_files_async (int.MAX);
        print ("total %lu\n", children.length ());
        foreach (var info in children) {
            // <file-type> <access-date> <size> <name>
            print ("%26s %24s %10"+int64.FORMAT+" B %s\n",
            info.get_content_type (),
            info.get_access_date_time ().to_string (),
            info.get_size (),
            info.get_name ());
        }
    } catch (Error e) {
        printerr ("failed to enumerate files - %s\n", e.message);
        return 1;
    }
    return 0;
}
```

In main blocks (experimental feature that allows it to write code in a file without putting in a main function) invoking functions with `yield` is also supported by making the main block automatically asynchronous.

Merge Request [#226](https://gitlab.gnome.org/GNOME/vala/-/merge_requests/226)

### Nested functions

A simple but very useful feature is to be able to nest functions inside of other functions or methods. These functions are then only visible to the code in the function that contains the nested one. But on the other way the code in the nested function has access to variables in the upper method. Actually they are only lambdas assigned to a local variable.

Use cases are to structure very complicated functions into multiple smaller ones, without exposing them publicly. In this example the same asynchronous callback is used for two invocations, in which you otherwise would use lambdas:

```vala
void write_streams (OutputStream stream1, OutputStream stream2, uint8[] data) {
    void nested_function (Object object_source, AsyncResult result) {
        OutputStream stream = object_source as OutputStream;
        try {
            ssize_t size = stream.write_async.finish (result);
            stdout.printf (@"Written $size bytes\n");
        } catch (Error e) {
            stderr.printf ("Error writing to stream: %s", e.message);
        }
    }
    
    stream1.write_async (data, nested_function);
    stream2.write_async (data, nested_function);
}
```

Merge Request [#203](https://gitlab.gnome.org/GNOME/vala/-/merge_requests/203)

### Redesign of error and warning output

If programming errors are outputted at compile time in a pretty way and provide as much information as possible, they massively help and speed up finding the mistakes and correcting them.
In the new release this part got an update. Look at the differences yourself:

```shell
int foo = bar();
          ^^^
```

Vala 0.56:

```shell
    2 | int foo = bar();
      |           ^~~
```

What looks better? :)

Issue [#764](https://gitlab.gnome.org/GNOME/vala/-/issues/764)

### Dynamic invocation of Signals

Libraries using the GObject type system are providing usually documentation about their API so other languages can use them. However sometimes some parts are missing. With the `dynamic` keyword an object can be treated as not having all properties or signals specified and they can be accessed dynamically without checking:

```vala
dynamic Gst.Element appsink = Gst.ElementFactory.make ("appsink", "my_src");
appsink.max_buffers = 0;
appsink.eos.connect (on_eos);
Gst.Sample? res = appsink.pull_sample.emit ();
```

As you can see, signals are now also callable with `.emit ()`. This is necessary to differentiate between a method or a dynamic signal. But this syntax can be also used with non-dynamic variables if wanted.

Merge Request [#227](https://gitlab.gnome.org/GNOME/vala/-/merge_requests/227)

### Partial classes

In rare cases, if a class is so huge and complex, it can be now split up into multiple pieces even into multiple files. All parts of the class only need the `partial` keyword in front of it.

```vala
public partial class Foo : Object {
    public double bar { get; set; }
}

public partial class Foo : Initable {
    public virtual bool init (Cancellable? cancellable = null) {
        stdout.printf ("hello!\n");
        this.bar = 0.56;
        return true;
    }
}
```

Merge Request [#200](https://gitlab.gnome.org/GNOME/vala/-/merge_requests/200)

### Length-type for Arrays

The length of an array is usually specified by an 32bit integer. However in some cases, especially in bindings to other libaries, sometimes the length of an array is given by a different type of integer. We now have support for that:

```vala
string[] list = new string[10:uint8];
```

Issue [#607](https://gitlab.gnome.org/GNOME/vala/-/issues/607)

### Foreach support on Glib.Sequence and Glib.Array

This small change will be a big improvement for users of these data structures. Instead of manually looping with for, they are now ready to be used with a foreach loop over the items in the sequence or array.

Merge Request [#234](https://gitlab.gnome.org/GNOME/vala/-/merge_requests/234)

### New Bindings

A bunch of new bindings to libraries got added this release. Here is a list:

- libsoup is now also available in version 3.0 and webkit2gtk in version 4.1 and 5.0 so you can start porting you Vala apps to the new releases of these libraries
- linux-media can now be used from Vala. There were also lots of more additions and fixes in other linux kernel interface bindings.
- During the port of the gnome-desktop library it was split up into gnome-desktop-4, gnome-rr-4 and gnome-bg-4. They are all now available to use in your new app.
- the GLib vapi was updated to version 2.72, including the new Signal- and BindingGroups and DebugController

### GNOME Getting started tutorial

The GNOME developer documentation has besides other stuff a excellent section on getting started with GTK and app development. Most of the [tutorials](https://developer.gnome.org/documentation/tutorials.html) there have now code examples in Vala. So read it and write your first Vala application! :)

### Vala Flatpak Sdk Extension

You can find on flathub now the `org.freedesktop.Sdk.Extension.vala` Extension. It contains the Vala compiler, language server and more tooling. You can use it either for compiling your Vala app, or if you need for example the language server at runtime, like an IDE. Instructions can be found at the [flathub repository](https://github.com/flathub/org.freedesktop.Sdk.Extension.vala).

### Google Summer of Code

We have proposed a project idea for the Google Summer of Code for working on Vala. If you are interested, check out the [project ideas page](https://discourse.gnome.org/t/gsoc-2022-project-ideas/8931#add-support-for-the-latest-gir-attributes-and-gi-docgen-formatting-to-valadoc-15) on GNOME discourse.

You are always invited to join our matrix chat [#vala:gnome.org](https://matrix.to/#/#_gimpnet_#vala:gnome.org) and ask questions about Vala or how to contribute. Until then, have a nice time and build great apps with Vala!
