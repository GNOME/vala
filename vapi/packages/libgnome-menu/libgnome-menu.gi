<?xml version="1.0"?>
<api version="1.0">
	<namespace name="GMenu">
		<callback name="GMenuTreeChangedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="tree" type="GMenuTree*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="GMenuTree">
			<method name="add_monitor" symbol="gmenu_tree_add_monitor">
				<return-type type="void"/>
				<parameters>
					<parameter name="tree" type="GMenuTree*"/>
					<parameter name="callback" type="GMenuTreeChangedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_directory_from_path" symbol="gmenu_tree_get_directory_from_path">
				<return-type type="GMenuTreeDirectory*"/>
				<parameters>
					<parameter name="tree" type="GMenuTree*"/>
					<parameter name="path" type="char*"/>
				</parameters>
			</method>
			<method name="get_menu_file" symbol="gmenu_tree_get_menu_file">
				<return-type type="char*"/>
				<parameters>
					<parameter name="tree" type="GMenuTree*"/>
				</parameters>
			</method>
			<method name="get_root_directory" symbol="gmenu_tree_get_root_directory">
				<return-type type="GMenuTreeDirectory*"/>
				<parameters>
					<parameter name="tree" type="GMenuTree*"/>
				</parameters>
			</method>
			<method name="get_sort_key" symbol="gmenu_tree_get_sort_key">
				<return-type type="GMenuTreeSortKey"/>
				<parameters>
					<parameter name="tree" type="GMenuTree*"/>
				</parameters>
			</method>
			<method name="get_user_data" symbol="gmenu_tree_get_user_data">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="tree" type="GMenuTree*"/>
				</parameters>
			</method>
			<method name="lookup" symbol="gmenu_tree_lookup">
				<return-type type="GMenuTree*"/>
				<parameters>
					<parameter name="menu_file" type="char*"/>
					<parameter name="flags" type="GMenuTreeFlags"/>
				</parameters>
			</method>
			<method name="ref" symbol="gmenu_tree_ref">
				<return-type type="GMenuTree*"/>
				<parameters>
					<parameter name="tree" type="GMenuTree*"/>
				</parameters>
			</method>
			<method name="remove_monitor" symbol="gmenu_tree_remove_monitor">
				<return-type type="void"/>
				<parameters>
					<parameter name="tree" type="GMenuTree*"/>
					<parameter name="callback" type="GMenuTreeChangedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_sort_key" symbol="gmenu_tree_set_sort_key">
				<return-type type="void"/>
				<parameters>
					<parameter name="tree" type="GMenuTree*"/>
					<parameter name="sort_key" type="GMenuTreeSortKey"/>
				</parameters>
			</method>
			<method name="set_user_data" symbol="gmenu_tree_set_user_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="tree" type="GMenuTree*"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="dnotify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="unref" symbol="gmenu_tree_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="tree" type="GMenuTree*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GMenuTreeAlias">
			<method name="get_directory" symbol="gmenu_tree_alias_get_directory">
				<return-type type="GMenuTreeDirectory*"/>
				<parameters>
					<parameter name="alias" type="GMenuTreeAlias*"/>
				</parameters>
			</method>
			<method name="get_item" symbol="gmenu_tree_alias_get_item">
				<return-type type="GMenuTreeItem*"/>
				<parameters>
					<parameter name="alias" type="GMenuTreeAlias*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GMenuTreeDirectory">
			<method name="get_comment" symbol="gmenu_tree_directory_get_comment">
				<return-type type="char*"/>
				<parameters>
					<parameter name="directory" type="GMenuTreeDirectory*"/>
				</parameters>
			</method>
			<method name="get_contents" symbol="gmenu_tree_directory_get_contents">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="directory" type="GMenuTreeDirectory*"/>
				</parameters>
			</method>
			<method name="get_desktop_file_path" symbol="gmenu_tree_directory_get_desktop_file_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="directory" type="GMenuTreeDirectory*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="gmenu_tree_directory_get_icon">
				<return-type type="char*"/>
				<parameters>
					<parameter name="directory" type="GMenuTreeDirectory*"/>
				</parameters>
			</method>
			<method name="get_is_nodisplay" symbol="gmenu_tree_directory_get_is_nodisplay">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="directory" type="GMenuTreeDirectory*"/>
				</parameters>
			</method>
			<method name="get_menu_id" symbol="gmenu_tree_directory_get_menu_id">
				<return-type type="char*"/>
				<parameters>
					<parameter name="directory" type="GMenuTreeDirectory*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gmenu_tree_directory_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="directory" type="GMenuTreeDirectory*"/>
				</parameters>
			</method>
			<method name="get_tree" symbol="gmenu_tree_directory_get_tree">
				<return-type type="GMenuTree*"/>
				<parameters>
					<parameter name="directory" type="GMenuTreeDirectory*"/>
				</parameters>
			</method>
			<method name="make_path" symbol="gmenu_tree_directory_make_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="directory" type="GMenuTreeDirectory*"/>
					<parameter name="entry" type="GMenuTreeEntry*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GMenuTreeEntry">
			<method name="get_comment" symbol="gmenu_tree_entry_get_comment">
				<return-type type="char*"/>
				<parameters>
					<parameter name="entry" type="GMenuTreeEntry*"/>
				</parameters>
			</method>
			<method name="get_desktop_file_id" symbol="gmenu_tree_entry_get_desktop_file_id">
				<return-type type="char*"/>
				<parameters>
					<parameter name="entry" type="GMenuTreeEntry*"/>
				</parameters>
			</method>
			<method name="get_desktop_file_path" symbol="gmenu_tree_entry_get_desktop_file_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="entry" type="GMenuTreeEntry*"/>
				</parameters>
			</method>
			<method name="get_display_name" symbol="gmenu_tree_entry_get_display_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="entry" type="GMenuTreeEntry*"/>
				</parameters>
			</method>
			<method name="get_exec" symbol="gmenu_tree_entry_get_exec">
				<return-type type="char*"/>
				<parameters>
					<parameter name="entry" type="GMenuTreeEntry*"/>
				</parameters>
			</method>
			<method name="get_generic_name" symbol="gmenu_tree_entry_get_generic_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="entry" type="GMenuTreeEntry*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="gmenu_tree_entry_get_icon">
				<return-type type="char*"/>
				<parameters>
					<parameter name="entry" type="GMenuTreeEntry*"/>
				</parameters>
			</method>
			<method name="get_is_excluded" symbol="gmenu_tree_entry_get_is_excluded">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="entry" type="GMenuTreeEntry*"/>
				</parameters>
			</method>
			<method name="get_is_nodisplay" symbol="gmenu_tree_entry_get_is_nodisplay">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="entry" type="GMenuTreeEntry*"/>
				</parameters>
			</method>
			<method name="get_launch_in_terminal" symbol="gmenu_tree_entry_get_launch_in_terminal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="entry" type="GMenuTreeEntry*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gmenu_tree_entry_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="entry" type="GMenuTreeEntry*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GMenuTreeHeader">
			<method name="get_directory" symbol="gmenu_tree_header_get_directory">
				<return-type type="GMenuTreeDirectory*"/>
				<parameters>
					<parameter name="header" type="GMenuTreeHeader*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GMenuTreeItem">
			<method name="get_parent" symbol="gmenu_tree_item_get_parent">
				<return-type type="GMenuTreeDirectory*"/>
				<parameters>
					<parameter name="item" type="GMenuTreeItem*"/>
				</parameters>
			</method>
			<method name="get_user_data" symbol="gmenu_tree_item_get_user_data">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="item" type="GMenuTreeItem*"/>
				</parameters>
			</method>
			<method name="ref" symbol="gmenu_tree_item_ref">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="item" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_user_data" symbol="gmenu_tree_item_set_user_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GMenuTreeItem*"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="dnotify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="unref" symbol="gmenu_tree_item_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="gpointer"/>
				</parameters>
			</method>
		</struct>
		<struct name="GMenuTreeSeparator">
		</struct>
		<enum name="GMenuTreeFlags">
			<member name="GMENU_TREE_FLAGS_NONE" value="0"/>
			<member name="GMENU_TREE_FLAGS_INCLUDE_EXCLUDED" value="1"/>
			<member name="GMENU_TREE_FLAGS_SHOW_EMPTY" value="2"/>
			<member name="GMENU_TREE_FLAGS_INCLUDE_NODISPLAY" value="4"/>
			<member name="GMENU_TREE_FLAGS_SHOW_ALL_SEPARATORS" value="8"/>
			<member name="GMENU_TREE_FLAGS_MASK" value="15"/>
		</enum>
		<enum name="GMenuTreeItemType">
			<member name="GMENU_TREE_ITEM_INVALID" value="0"/>
			<member name="GMENU_TREE_ITEM_DIRECTORY" value="1"/>
			<member name="GMENU_TREE_ITEM_ENTRY" value="2"/>
			<member name="GMENU_TREE_ITEM_SEPARATOR" value="3"/>
			<member name="GMENU_TREE_ITEM_HEADER" value="4"/>
			<member name="GMENU_TREE_ITEM_ALIAS" value="5"/>
		</enum>
		<enum name="GMenuTreeSortKey">
			<member name="GMENU_TREE_SORT_NAME" value="0"/>
			<member name="GMENU_TREE_SORT_DISPLAY_NAME" value="1"/>
		</enum>
	</namespace>
</api>
