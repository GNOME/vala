namespace Gdl
{
  public class DockObject
  {
    [CCode (cname = "GDL_DOCK_OBJECT_AUTOMATIC")]
    public bool is_automatic ();
    [CCode (cname = "GDL_DOCK_OBJECT_ATTACHED")]
    public bool is_attached ();
    [CCode (cname = "GDL_DOCK_OBJECT_IN_REFLOW")]
    public bool is_in_reflow ();
    [CCode (cname = "GDL_DOCK_OBJECT_IN_DETACH")]
    public bool is_in_detach ();
    [CCode (cname = "GDL_DOCK_OBJECT_SET_FLAGS")]
    public bool is_set_flags (DockObjectFlags flags);
    [CCode (cname = "GDL_DOCK_OBJECT_UNSET_FLAGS")]
    public bool is_unset_flags (DockObjectFlags flags);
    [CCode (cname = "GDL_DOCK_OBJECT_FROZEN")]
    public bool is_frozen ();
  }
}

