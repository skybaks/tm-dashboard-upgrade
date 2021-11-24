
class ScreenObject
{
    private Meta::PluginSetting@ m_posSetting;

    private float m_x = 0.1;
    private float m_y = 0.1;

    ScreenObject(const string&in posSettingName)
    {
        @m_posSetting = GetSetting(posSettingName);
    }

    void Update(int dt)
    {
        vec2 pos = m_posSetting.ReadVec2();

        /*
        float dts = float(dt) / 1000.0;

        pos.x += m_x * dts;
        pos.y += m_y * dts;

        if (pos.x > 1.0 || pos.x < 0.0)
        {
            m_x *= -1.0;
        }
        if (pos.y > 1.0 || pos.y < 0.0)
        {
            m_y *= -1.0;
        }

        m_posSetting.WriteVec2(pos);
        */
    }

    private Meta::PluginSetting@ GetSetting(const string&in settingName)
    {
        Meta::PluginSetting@ setting = null;
        Meta::Plugin@ plugin = Meta::GetPluginFromSiteID(103);
        Meta::PluginSetting@[]@ settings = plugin.GetSettings();
        for (uint i = 0; i < settings.Length; i++)
        {
            if (settings[i].VarName == settingName)
            {
                @setting = settings[i];
                break;
            }
        }
        return setting;
    }
}
