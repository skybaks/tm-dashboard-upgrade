
class ScreenObject
{
    private Meta::PluginSetting@ m_posSetting;
    private Meta::PluginSetting@ m_sizSetting;

    private float m_x = 0.1;
    private float m_y = 0.1;
    private vec2 m_pos;
    private vec2 m_size;

    vec2 Pos { get { return m_pos; } }
    vec2 Size { get { return m_size; } }

    ScreenObject(const string&in posSettingName, const string&in sizSettingName)
    {
        @m_posSetting = GetSetting(posSettingName);
        @m_sizSetting = GetSetting(sizSettingName);
    }

    void UpdatePosition(int dt)
    {
        vec2 screenSize = vec2(Draw::GetWidth(), Draw::GetHeight());
        vec2 scaledPos = m_posSetting.ReadVec2();

        m_size = m_sizSetting.ReadVec2();
        m_pos = scaledPos * (screenSize - m_size);

        //vec2 scaledPosModified = m_pos / (screenSize - m_size);

        float dts = float(dt) / 1000.0;

        scaledPos.x += m_x * dts;
        scaledPos.y += m_y * dts;

        m_posSetting.WriteVec2(scaledPos);
    }

    void UpdateCollision(ScreenObject@[]@ objects)
    {
        vec2 screenSize = vec2(Draw::GetWidth(), Draw::GetHeight());
        vec2 scaledPos = m_pos / (screenSize - m_size);
        bool xCollisionHandled = false;
        bool yCollisionHandled = false;

        // Collision with a boundary
        if ((scaledPos.x > 1.0 && m_x > 0.0) || (scaledPos.x < 0.0 && m_x < 0.0))
        {
            m_x *= -1.0;
        }
        if ((scaledPos.y > 1.0 && m_y > 0.0) || (scaledPos.y < 0.0 && m_y < 0.0))
        {
            m_y *= -1.0;
        }

        // Collision with another object
        for (uint i = 0; i < objects.Length; i++)
        {
            if (this is objects[i]) { continue; }
            if (xCollisionHandled && yCollisionHandled) { break; }

            vec2 oPos = objects[i].Pos;
            vec2 oSize = objects[i].Size;

            if ((m_pos.x < oPos.x && (m_pos.x + m_size.x) > oPos.x && m_x > 0.0)
                || (m_pos.x < (oPos.x + oSize.x) && (m_pos.x + m_size.x) > (oPos.x + oSize.x) && m_x < 0.0))
            {
                if ((m_pos.y < (oPos.y + oSize.y) && (m_pos.y + m_size.y) > (oPos.y + oSize.y))
                    || (m_pos.y < oPos.y && (m_pos.y + m_size.y) > oPos.y))
                {
                    m_x *= -1.0;
                }
            }
            if ((m_pos.y < (oPos.y + oSize.y) && (m_pos.y + m_size.y) > (oPos.y + oSize.y) && m_y < 0.0)
                || (m_pos.y < oPos.y && (m_pos.y + m_size.y) > oPos.y) && m_y > 0.0)
            {
                if ((m_pos.x < oPos.x && (m_pos.x + m_size.x) > oPos.x)
                    || (m_pos.x < (oPos.x + oSize.x) && (m_pos.x + m_size.x) > (oPos.x + oSize.x)))
                {
                    m_y *= -1.0;
                }
            }
        }
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
