namespace Gda {
	[CCode (cprefix = "GDA_DATA_MODEL_ACCESS_", cheader_filename = "libgda/libgda.h")]
	[Flags]
	public enum DataModelAccessFlags {
		RANDOM,
		CURSOR_FORWARD,
		CURSOR_BACKWARD,
		CURSOR,
		INSERT,
		UPDATE,
		DELETE,
		WRITE
	}

	[CCode (cprefix = "GDA_META_STRUCT_FEATURE_", cheader_filename = "libgda/libgda.h")]
	[Flags]
	public enum MetaStructFeature {
		NONE,
		FOREIGN_KEYS,
		VIEW_DEPENDENCIES,
		ALL
	}

	/* interface with the Lemon parser */
	protected struct SqlParserIface {
		Gda.SqlParser    parser;
		Gda.SqlStatement parsed_statement;
	}

	public errordomain SqlError {
		STRUCTURE_CONTENTS_ERROR,
		MALFORMED_IDENTIFIER_ERROR,
		MISSING_IDENTIFIER_ERROR,
		VALIDATION_ERROR
	}
}
