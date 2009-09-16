/** Just a test file for parser2 **/

namespace Valadoc {
	void main (string[] args) {
		Settings settings = new Settings ();
		ErrorReporter reporter = new ErrorReporter ();
		DocumentationParser parser = new DocumentationParser(settings, reporter);

		string filename = args[1];
		string content;
		if (FileUtils.get_contents (filename, out content)) {
			Object root = parser.parse_comment (content, filename, 0, 0);
			stdout.printf ("\n%s\n", ((Node) root).to_string ());
		}
	}
}
