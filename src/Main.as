
void Main()
{
    ScreenObject@[] objs;
    objs.InsertLast(ScreenObject("Setting_General_PadPos", "Setting_General_PadSize"));
    objs.InsertLast(ScreenObject("Setting_General_GearboxPos", "Setting_General_GearboxSize"));
    objs.InsertLast(ScreenObject("Setting_General_WheelsPos", "Setting_General_WheelsSize"));
    objs.InsertLast(ScreenObject("Setting_General_AccelerationPos", "Setting_General_AccelerationSize"));
    objs.InsertLast(ScreenObject("Setting_General_SpeedPos", "Setting_General_SpeedSize"));

    int dt = 0;
    int prevFrameTime = Time::Now;
    while (true)
    {
        sleep(10);
        dt = Time::Now - prevFrameTime;

        for (uint i = 0; i < objs.Length; i++)
        {
            objs[i].UpdatePosition(dt);
            objs[i].UpdateCollision(objs);
        }

        for (uint i = 0; i < objs.Length; i++)
        {
        }

        prevFrameTime = Time::Now;
    }
}
