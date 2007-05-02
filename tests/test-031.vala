using GLib;

class Maman.Foo {
	const float[] FLOAT_TESTS = { 
		float.EPSILON, 0.0, 1.0, 
		-float.INFINITY,
		float.INFINITY,
		float.NAN
	};

	const double[] DOUBLE_TESTS = { 
		double.EPSILON, 0.0, 1.0, 
		-double.INFINITY,
		double.INFINITY,
		double.NAN
	};

	static void main (string[] args) {
		stdout.printf (
			"float: range=%s...%s\n" +
			"       digits=%s(%s), exp=%s..%s(%s..%s)\n" +
			"       epsilon=%s, infinity=%s/%s, nan=%s\n",

		      	float.MIN.to_string (), 
		      	float.MAX.to_string (),

		      	float.MANT_DIG.to_string (),
		      	float.DIG.to_string (),
		      	float.MIN_EXP.to_string (), 
		      	float.MAX_EXP.to_string (),
		      	float.MIN_10_EXP.to_string (), 
		      	float.MAX_10_EXP.to_string (),

		      	float.EPSILON.to_string (),
			float.INFINITY.to_string (),
			(-float.INFINITY).to_string (),
			float.NAN.to_string ());

		for (int i = 0; i < 6; i++) { // XXX use foreach
			float value = FLOAT_TESTS[i];
			int infinity = value.is_infinity ();

			stdout.printf (
				"float(%g): nan=%s, finite=%s, normal=%s, infinity=%s\n", 
				
				value,
				value.is_nan () ? "true" : "false", 
				value.is_finite () ? "true" : "false",
				value.is_normal () ? "true" : "false", 

				infinity > 0 ? "positive" : 
				infinity < 0 ? "negative" : "none");
		}

		stdout.printf (
			"double: range=%s...%s\n" +
			"        digits=%s(%s), exp=%s..%s(%s..%s)\n" +
			"        epsilon=%s, infinity=%s/%s, nan=%s\n",

		      	double.MIN.to_string (), 
		      	double.MAX.to_string (),

		      	double.MANT_DIG.to_string (),
		      	double.DIG.to_string (),
		      	double.MIN_EXP.to_string (), 
		      	double.MAX_EXP.to_string (),
		      	double.MIN_10_EXP.to_string (), 
		      	double.MAX_10_EXP.to_string (),

		      	double.EPSILON.to_string (),
			double.INFINITY.to_string (),
			(-double.INFINITY).to_string (),
			double.NAN.to_string ());

		for (int i = 0; i < 6; i++) { // XXX use foreach
			double value = DOUBLE_TESTS[i];
			int infinity = value.is_infinity ();

			stdout.printf(
				"double(%g): nan=%s, finite=%s, normal=%s, infinity=%s\n", 
				
				value,
				value.is_nan () ? "true" : "false", 
				value.is_finite () ? "true" : "false",
				value.is_normal () ? "true" : "false", 

				infinity > 0 ? "positive" : 
				infinity < 0 ? "negative" : "none");
		}
	}
}
