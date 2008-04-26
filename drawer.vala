

using Cairo;
using GLib;
using Gee;


public abstract class Drawer.Base : Object {
	public string name {
		construct set;
		get;
	}

	public string nspace {
		construct set;
		get;
	}

	public Class parent {
		construct set;
		get;
	}

	public Gee.Collection<Interface> ifaces {
		construct set;
		get;
	}

	public int implemented_interfaces {
		get {
			return this.ifaces.size;
		}
	}
}


public class Drawer.Interface : Base {
	public Interface ( string name,
										 string nspace,
										 Class parent,
										 Gee.Collection<Interface> ifaces ) {
		this.name = name;
		this.nspace = nspace;
		this.parent = parent;
		this.ifaces = ifaces;
	}
}



public class Drawer.Class : Base {
	public Class ( string name,
								 string nspace,
								 Class parent,
								 Gee.Collection<Interface> ifaces ) {
		this.name = name;
		this.nspace = nspace;
		this.parent = parent;
		this.ifaces = ifaces;
	}
}



public class Drawer.Drawer : Object {
	public int block_height {
		get;
		set;
	}

	public int block_width {
		get;
		set;
	}

	public int class_arrow_len {
		get;
		set;
	}

	public int interface_arrow_len {
		get;
		set;
	}

	private int get_height ( Class cl ) {
		int blocks;

		for ( blocks = 0; cl != null ; blocks++ ) {
			cl = cl.parent;
		}

		return blocks * this.block_height  +  (blocks - 1) * this.class_arrow_len;
	}

	private int get_width ( Class cl ) {
		int blocks = 0;

		while ( cl != null ) {
			if ( cl.ifaces != null ) {
				int size = 0;

				foreach ( Interface iface in cl.ifaces ) {
					if ( this.redefined_interface ( cl, iface ) )
						size++;
				}

				if ( size > blocks )
					blocks = size;
			}
			cl = cl.parent;
		}

		return ( blocks +1 ) * this.block_width +  blocks * this.interface_arrow_len;
	}

	private void draw_cass_box ( Class cl, Cairo.Context context, int pos ) {
	
	}

	private int parent_classes ( Class cl ) {
		int i;

		for ( i = 0; cl.parent != null ; i++ )
			cl = cl.parent;

		return i;
	}

	private void draw_data_type ( Cairo.Context context, string name, int x, int y ) {
		FontExtents fe;
		TextExtents te;
		int tx;
		int ty;

		// draw the box:
		context.rectangle( x, y, this.block_width, this.block_height );
		context.set_source_rgb( 0, 0, 0 );
		context.fill( );

		context.rectangle( x+1, y+1, this.block_width-2, this.block_height-2 );
		context.set_source_rgb( 1, 1, 1 );
		context.fill( );


		// text:
		context.set_font_size ( 12 );
		context.select_font_face ( "Georgia", FontSlant.NORMAL, FontWeight.NORMAL );
		context.text_extents ( name, ref te);

		tx = x + ( this.block_width - 2 ) / 2 - (int)te.width / 2;
		ty = y + this.block_height / 2 + (int)te.height / 2;

		context.move_to ( tx, ty );		context.set_source_rgb ( 0, 0, 0);
		context.show_text ( name );
	}

	private void draw_arrow ( Cairo.Context context, int x, int y, int len, bool down ) {
		context.move_to ( x, y );
		context.set_source_rgb( 0, 0, 0 );

		if ( down == true ) {
			context.line_to ( x, y+this.class_arrow_len );
			context.stroke( );

			context.move_to ( x, y+this.class_arrow_len );
			context.line_to ( x+5, y+this.class_arrow_len-5 );
			context.stroke( );

			context.move_to ( x, y+this.class_arrow_len );
			context.line_to ( x-5, y+this.class_arrow_len-5 );
			context.stroke( );
		}
		else {
			context.line_to ( x-this.interface_arrow_len, y );
			context.stroke( );

			context.move_to ( x-this.interface_arrow_len, y );
			context.line_to ( x-this.interface_arrow_len+5, y+5 );
			context.stroke( );

			context.move_to ( x-this.interface_arrow_len, y );
			context.line_to ( x-this.interface_arrow_len+5, y-5 );
			context.stroke( );
		}
	}

	private bool redefined_interface ( Class cl, Interface iface ) {
		cl = cl.parent;
		while ( cl != null ) {
			if ( cl.ifaces == null )
				continue ;

			foreach ( Interface iface2 in cl.ifaces ) {
				if ( iface2 == iface )
					return true;
			}
			cl = cl.parent;
		}
		return false;
	}

	public void draw_class ( Class cl, string path ) {
		int height = this.get_height ( cl );
		int width = this.get_width ( cl );

		// create a picture with a white background:
		var img = new Cairo.ImageSurface ( Cairo.Format.RGB24, width , height );
		var context = new Cairo.Context ( img );

		context.rectangle( 0,  0, width, height );
		context.set_source_rgb( 1, 1, 1 );
		context.fill( );

		// draw the classes:
		for ( int i = 0; cl != null ; i++ ) {
			int y = ( i == 0 )? height - this.block_height :
				(this.parent_classes(cl)-i+1) * (this.block_height + this.class_arrow_len);

			int x = this.block_width / 2;

			this.draw_data_type ( context, cl.name, 0, y );
			this.draw_arrow ( context, x, y+this.block_height, 10, true );

			if ( cl.ifaces != null ) {
				int i = 0;
				foreach ( Interface iface in cl.ifaces ) {
					if ( this.redefined_interface( cl, iface ) )
						continue ;

					i++;
					int xh = (this.block_width + this.interface_arrow_len)*i;

					this.draw_arrow ( context, xh, y+(this.block_height / 2), 10, false );
					this.draw_data_type ( context, iface.name, xh, y );
				}
			}

			cl = cl.parent;
		}

		//img.write_to_png ( path );
	}
}

