default
{
    state_entry()
    {
        llTargetOmega(<0,0,1>,TWO_PI,1.0);
        llSetText("Display external XML-Resources directly\non objects in Second Life!\nRuby on Rails & LSL", <1,1,1>, 1.0);
        //llSetTimerEvent(5);
    }

    touch_start(integer total_number)
    {
        llLoadURL(llDetectedKey(0), "Read the whole story...", "http://www.semanticpool.de/display-external-xml-resources-on-objects-in-second-life/");
    }
    
}
