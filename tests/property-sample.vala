/* Properties Sample Code
 * Keep in sync with <http://live.gnome.org/Vala/PropertiesSample>
 */
using GLib;

public class Sample : Object {
	private string automatic {
		get; set;
	}

	private string _name;
	public string name {
		get;

		set {
			_name = value;
			notify("name");
		}
	}

	private string _read_only;
	public string read_only {
		get { return _read_only; }
	}

	public Sample(construct string! name) {
	}

	construct {
		_automatic = "InitialAutomatic";
		_read_only = "InitialReadOnly";
	}

	public void run() {
		notify += (s, p) => {
			/* FIXME Cast needed as signatures conflict for the 
			 * notify method and the notify signal of GObject.
			 * See Bug 473804.
			 */
			stdout.printf("property `%s' has changed!\n",
				      ((ParamSpec) p).name);
		};


		automatic = "TheNewAutomatic";
		name = "TheNewName";

		// The following statement would be rejected
		// read_only = "TheNewReadOnly";

		stdout.printf("automatic: %s\n", automatic);
		stdout.printf("name: %s\n", name);
		stdout.printf("read_only: %s\n", read_only);
		stdout.printf("automatic: %s\n", automatic);
        }

        static int main (string[] args) {
                var test = new Sample("InitialName");

                test.run();

                return 0;
        }
}
