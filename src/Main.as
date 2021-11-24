
void Main()
{
    ScreenObject@[] objs;
    objs.InsertLast(ScreenObject("Setting_General_PadPos"));
    objs.InsertLast(ScreenObject("Setting_General_GearboxPos"));
    objs.InsertLast(ScreenObject("Setting_General_WheelsPos"));
    objs.InsertLast(ScreenObject("Setting_General_AccelerationPos"));
    objs.InsertLast(ScreenObject("Setting_General_SpeedPos"));

    int dt = 0;
    int prevFrameTime = Time::Now;
    while (true)
    {
        sleep(10);
        dt = Time::Now - prevFrameTime;

        for (uint i = 0; i < objs.Length; i++)
        {
            objs[i].Update(dt);
        }

        prevFrameTime = Time::Now;
    }
}
