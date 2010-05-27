<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Rest">
		<struct name="FacebookProxy">
			<method name="build_login_url" symbol="facebook_proxy_build_login_url">
				<return-type type="char*"/>
				<parameters>
					<parameter name="proxy" type="FacebookProxy*"/>
					<parameter name="frob" type="char*"/>
				</parameters>
			</method>
			<method name="build_permission_url" symbol="facebook_proxy_build_permission_url">
				<return-type type="char*"/>
				<parameters>
					<parameter name="proxy" type="FacebookProxy*"/>
					<parameter name="perms" type="char*"/>
				</parameters>
			</method>
			<method name="get_api_key" symbol="facebook_proxy_get_api_key">
				<return-type type="char*"/>
				<parameters>
					<parameter name="proxy" type="FacebookProxy*"/>
				</parameters>
			</method>
			<method name="get_app_secret" symbol="facebook_proxy_get_app_secret">
				<return-type type="char*"/>
				<parameters>
					<parameter name="proxy" type="FacebookProxy*"/>
				</parameters>
			</method>
			<method name="get_session_key" symbol="facebook_proxy_get_session_key">
				<return-type type="char*"/>
				<parameters>
					<parameter name="proxy" type="FacebookProxy*"/>
				</parameters>
			</method>
			<method name="new" symbol="facebook_proxy_new">
				<return-type type="RestProxy*"/>
				<parameters>
					<parameter name="api_key" type="char*"/>
					<parameter name="app_secret" type="char*"/>
				</parameters>
			</method>
			<method name="new_with_session" symbol="facebook_proxy_new_with_session">
				<return-type type="RestProxy*"/>
				<parameters>
					<parameter name="api_key" type="char*"/>
					<parameter name="app_secret" type="char*"/>
					<parameter name="session_key" type="char*"/>
				</parameters>
			</method>
			<method name="set_app_secret" symbol="facebook_proxy_set_app_secret">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="FacebookProxy*"/>
					<parameter name="secret" type="char*"/>
				</parameters>
			</method>
			<method name="set_session_key" symbol="facebook_proxy_set_session_key">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="FacebookProxy*"/>
					<parameter name="session_key" type="char*"/>
				</parameters>
			</method>
			<method name="sign" symbol="facebook_proxy_sign">
				<return-type type="char*"/>
				<parameters>
					<parameter name="proxy" type="FacebookProxy*"/>
					<parameter name="params" type="GHashTable*"/>
				</parameters>
			</method>
			<field name="parent" type="RestProxy"/>
			<field name="priv" type="FacebookProxyPrivate*"/>
		</struct>
		<struct name="FacebookProxyCall">
			<field name="parent" type="RestProxyCall"/>
		</struct>
		<struct name="FacebookProxyCallClass">
			<field name="parent_class" type="RestProxyCallClass"/>
			<field name="_padding_dummy" type="gpointer[]"/>
		</struct>
		<struct name="FacebookProxyClass">
			<field name="parent_class" type="RestProxyClass"/>
			<field name="_padding_dummy" type="gpointer[]"/>
		</struct>
		<struct name="FlickrProxy">
			<method name="build_login_url" symbol="flickr_proxy_build_login_url">
				<return-type type="char*"/>
				<parameters>
					<parameter name="proxy" type="FlickrProxy*"/>
					<parameter name="frob" type="char*"/>
				</parameters>
			</method>
			<method name="get_api_key" symbol="flickr_proxy_get_api_key">
				<return-type type="char*"/>
				<parameters>
					<parameter name="proxy" type="FlickrProxy*"/>
				</parameters>
			</method>
			<method name="get_shared_secret" symbol="flickr_proxy_get_shared_secret">
				<return-type type="char*"/>
				<parameters>
					<parameter name="proxy" type="FlickrProxy*"/>
				</parameters>
			</method>
			<method name="get_token" symbol="flickr_proxy_get_token">
				<return-type type="char*"/>
				<parameters>
					<parameter name="proxy" type="FlickrProxy*"/>
				</parameters>
			</method>
			<method name="is_successful" symbol="flickr_proxy_is_successful">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="root" type="RestXmlNode*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="new" symbol="flickr_proxy_new">
				<return-type type="RestProxy*"/>
				<parameters>
					<parameter name="api_key" type="char*"/>
					<parameter name="shared_secret" type="char*"/>
				</parameters>
			</method>
			<method name="new_with_token" symbol="flickr_proxy_new_with_token">
				<return-type type="RestProxy*"/>
				<parameters>
					<parameter name="api_key" type="char*"/>
					<parameter name="shared_secret" type="char*"/>
					<parameter name="token" type="char*"/>
				</parameters>
			</method>
			<method name="set_token" symbol="flickr_proxy_set_token">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="FlickrProxy*"/>
					<parameter name="token" type="char*"/>
				</parameters>
			</method>
			<method name="sign" symbol="flickr_proxy_sign">
				<return-type type="char*"/>
				<parameters>
					<parameter name="proxy" type="FlickrProxy*"/>
					<parameter name="params" type="GHashTable*"/>
				</parameters>
			</method>
			<field name="parent" type="RestProxy"/>
			<field name="priv" type="FlickrProxyPrivate*"/>
		</struct>
		<struct name="FlickrProxyCall">
			<field name="parent" type="RestProxyCall"/>
		</struct>
		<struct name="FlickrProxyCallClass">
			<field name="parent_class" type="RestProxyCallClass"/>
			<field name="_padding_dummy" type="gpointer[]"/>
		</struct>
		<struct name="FlickrProxyClass">
			<field name="parent_class" type="RestProxyClass"/>
			<field name="_padding_dummy" type="gpointer[]"/>
		</struct>
	</namespace>
</api>
