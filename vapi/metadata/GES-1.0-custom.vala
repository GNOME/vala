namespace GES {
	public abstract class BaseEffect : GES.Operation {
		[Version (since = "1.18")]
		public bool set_time_translation_funcs ([CCode (delegate_target_pos = 2.33333, destroy_notify_pos = 2.66667)] owned GES.BaseEffectTimeTranslationFunc? source_to_sink_func, [CCode (delegate_target_pos = 2.33333, destroy_notify_pos = 2.66667)] owned GES.BaseEffectTimeTranslationFunc? sink_to_source_func);
	}
}
