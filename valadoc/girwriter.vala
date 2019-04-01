/* girwriter.vala
 *
 * Copyright (C) 2011  Florian Brosch
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Florian Brosch <flo.brosch@gmail.com>
 */


using Valadoc.Api;

/**
 * Code visitor generating .gir file for the public interface.
 */
public class Valadoc.GirWriter : Vala.GIRWriter {
	private GtkdocRenderer renderer;
	private SymbolResolver resolver;

	public GirWriter (SymbolResolver resolver) {
		this.renderer = new GtkdocRenderer ();
		this.resolver = resolver;
	}

	private string? translate (Content.Comment? documentation) {
		if (documentation == null) {
			return null;
		}

		renderer.render_symbol (documentation);

		return MarkupWriter.escape (renderer.content);
	}

	private string? translate_taglet (Content.Taglet? taglet) {
		if (taglet == null) {
			return null;
		}

		renderer.render_children (taglet);

		return MarkupWriter.escape (renderer.content);
	}

	protected override string? get_interface_comment (Vala.Interface viface) {
		Interface iface = resolver.resolve (viface) as Interface;
		return translate (iface.documentation);
	}

	protected override string? get_struct_comment (Vala.Struct vst) {
		Struct st = resolver.resolve (vst) as Struct;
		return translate (st.documentation);
	}

	protected override string? get_enum_comment (Vala.Enum ven) {
		Enum en = resolver.resolve (ven) as Enum;
		return translate (en.documentation);
	}

	protected override string? get_class_comment (Vala.Class vc) {
		Class c = resolver.resolve (vc) as Class;
		return translate (c.documentation);
	}

	protected override string? get_error_code_comment (Vala.ErrorCode vecode) {
		ErrorCode ecode = resolver.resolve (vecode) as ErrorCode;
		return translate (ecode.documentation);
	}

	protected override string? get_enum_value_comment (Vala.EnumValue vev) {
		Api.EnumValue ev = resolver.resolve (vev) as Api.EnumValue;
		return translate (ev.documentation);
	}

	protected override string? get_constant_comment (Vala.Constant vc) {
		Constant c = resolver.resolve (vc) as Constant;
		return translate (c.documentation);
	}

	protected override string? get_error_domain_comment (Vala.ErrorDomain vedomain) {
		ErrorDomain edomain = resolver.resolve (vedomain) as ErrorDomain;
		return translate (edomain.documentation);
	}

	protected override string? get_field_comment (Vala.Field vf) {
		Field f = resolver.resolve (vf) as Field;
		return translate (f.documentation);
	}

	protected override string? get_delegate_comment (Vala.Delegate vcb) {
		Delegate cb = resolver.resolve (vcb) as Delegate;
		return translate (cb.documentation);
	}

	protected override string? get_method_comment (Vala.Method vm) {
		Method m = resolver.resolve (vm) as Method;
		return translate (m.documentation);
	}

	protected override string? get_property_comment (Vala.Property vprop) {
		Property prop = resolver.resolve (vprop) as Property;
		return translate (prop.documentation);
	}

	protected override string? get_delegate_return_comment (Vala.Delegate vcb) {
		Delegate cb = resolver.resolve (vcb) as Delegate;
		if (cb.documentation == null) {
			return null;
		}

		Content.Comment? documentation = cb.documentation;
		if (documentation == null) {
			return null;
		}

		Vala.List<Content.Taglet> taglets = documentation.find_taglets (cb, typeof(Taglets.Return));
		foreach (Content.Taglet taglet in taglets) {
			return translate_taglet (taglet);
		}

		return null;
	}

	protected override string? get_signal_return_comment (Vala.Signal vsig) {
		Api.Signal sig = resolver.resolve (vsig) as Api.Signal;
		if (sig.documentation == null) {
			return null;
		}

		Content.Comment? documentation = sig.documentation;
		if (documentation == null) {
			return null;
		}

		Vala.List<Content.Taglet> taglets = documentation.find_taglets (sig, typeof(Taglets.Return));
		foreach (Content.Taglet taglet in taglets) {
			return translate_taglet (taglet);
		}

		return null;
	}

	protected override string? get_method_return_comment (Vala.Method vm) {
		Method m = resolver.resolve (vm) as Method;
		if (m.documentation == null) {
			return null;
		}

		Content.Comment? documentation = m.documentation;
		if (documentation == null) {
			return null;
		}

		Vala.List<Content.Taglet> taglets = documentation.find_taglets (m, typeof(Taglets.Return));
		foreach (Content.Taglet taglet in taglets) {
			return translate_taglet (taglet);
		}

		return null;
	}

	protected override string? get_signal_comment (Vala.Signal vsig) {
		Api.Signal sig = resolver.resolve (vsig) as Api.Signal;
		return translate (sig.documentation);
	}

	protected override string? get_parameter_comment (Vala.Parameter param) {
		Api.Symbol symbol = resolver.resolve (((Vala.Symbol) param.parent_symbol));
		if (symbol == null) {
			return null;
		}

		Content.Comment? documentation = symbol.documentation;
		if (documentation == null) {
			return null;
		}

		Vala.List<Content.Taglet> taglets = documentation.find_taglets (symbol, typeof(Taglets.Param));
		foreach (Content.Taglet _taglet in taglets) {
			Taglets.Param taglet = (Taglets.Param) _taglet;
			if (taglet.parameter_name == param.name) {
				return translate_taglet (taglet);
			}
		}

		return null;
	}
}


