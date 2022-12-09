void main () {
	{
		float foo = 0x1.fP1F;
		assert (foo == 3.875f);
		var bar = 0xab.cdp2f;
		assert (bar == 687.203125f);
	}
	{
		double foo = 0xf.ap3D;
		assert (foo == 125.0);
		var bar = 0xdead.beefp5d;
		assert (bar > 1824183.866699 && bar < 1824183.8666993);
	}
	{
		double foo = 0x2022.1209p4;
		assert (foo > 131617.127197 && foo < 131617.127198);
		var bar = 0x47.11p9;
		assert (bar == 36386.0);
	}
	{
		double foo = 0x0.8P1;
		assert (foo == 1.0);
	}
	{
		double foo = 0xab.cdp20;
		assert (foo == 180146176.0);
	}
}
