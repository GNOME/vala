void main() {
	var outervar = "outerfoo";
	SourceFunc firstfunc = () => {
		outervar = "outerbar";
		return false;
	};

	SourceFunc secondfunc = () => {
		var innervar = "innerfoo";
		SourceFunc innerfunc = () => {
			innervar = "innerbar";
			return false;
		};
		return false;
	};
}
