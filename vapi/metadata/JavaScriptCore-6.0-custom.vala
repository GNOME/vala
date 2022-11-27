namespace JSC {
	public class Class : GLib.Object {
		public void add_property (string name, GLib.Type property_type, [CCode (delegate_target_pos = 4.33333, destroy_notify_pos = 4.66667, type = "GCallback")] owned JSC.ClassGetPropertyCb? getter, [CCode (delegate_target_pos = 4.33333, destroy_notify_pos = 4.66667, type = "GCallback")] owned JSC.ClassSetPropertyCb? setter);
	}
	[CCode (cname = "GCallback", instance_pos = 1.9)]
	public delegate T ClassGetPropertyCb<T> (JSC.Class instance);
	[CCode (cname = "GCallback", instance_pos = 2.9)]
	public delegate void ClassSetPropertyCb<T> (JSC.Class instance, T value);

	[CCode (cname = "GCallback", instance_pos = 1.9)]
	public delegate T ClassConstructorCb<T> (GLib.GenericArray<JSC.Value> values);
	[CCode (cname = "GCallback", instance_pos = 2.9)]
	public delegate T ClassMethodCb<T> (JSC.Class instance, GLib.GenericArray<JSC.Value> values);
}
