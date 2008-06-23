namespace Gsf {
  public struct off_t : int64 {
  }
  /*  public static delegate void XMLInNodeStartFunc(XMLIn xin, string[] attrs);
      public static delegate void XMLInNodeEndFunc(XMLIn xin, XMLBlob unknown);*/
  [CCode (cheader_filename = "gsf/gsf-input-impl.h")]
  public class Input {
    public static extern Gsf.Input uncompress(Gsf.Input# src);
  }
}