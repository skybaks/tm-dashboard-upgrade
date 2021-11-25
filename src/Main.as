
ScreenObject@[] g_objs;


void Main()
{
    g_objs.InsertLast(ScreenObject("Setting_General_PadPos", "Setting_General_PadSize", "Setting_General_ShowPad"));
    g_objs.InsertLast(ScreenObject("Setting_General_GearboxPos", "Setting_General_GearboxSize", "Setting_General_ShowGearbox"));
    g_objs.InsertLast(ScreenObject("Setting_General_WheelsPos", "Setting_General_WheelsSize", "Setting_General_ShowWheels"));
    g_objs.InsertLast(ScreenObject("Setting_General_AccelerationPos", "Setting_General_AccelerationSize", "Setting_General_ShowAcceleration"));
    g_objs.InsertLast(ScreenObject("Setting_General_SpeedPos", "Setting_General_SpeedSize", "Setting_General_ShowSpeed"));

    int dt = 0;
    int prevFrameTime = Time::Now;
    while (true)
    {
        sleep(10);
        dt = Time::Now - prevFrameTime;

        for (uint i = 0; i < g_objs.Length; i++)
        {
            g_objs[i].UpdateState();
            g_objs[i].UpdatePosition(dt);
            g_objs[i].UpdateCollision(g_objs);
        }

        prevFrameTime = Time::Now;
    }
}
