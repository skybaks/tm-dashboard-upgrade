
namespace MetaUtil
{
    Meta::PluginSetting@ GetSettingFromPluginSiteID(const string&in settingName, int siteId)
    {
        Meta::PluginSetting@ setting = null;
        Meta::Plugin@ plugin = Meta::GetPluginFromSiteID(siteId);
        if (plugin !is null)
        {
            Meta::PluginSetting@[]@ settings = plugin.GetSettings();
            for (uint i = 0; i < settings.Length; i++)
            {
                if (settings[i].VarName == settingName)
                {
                    @setting = settings[i];
                    break;
                }
            }
        }
        return setting;
    }
}
