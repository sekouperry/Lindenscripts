float minHeight = 32.9;
float maxHeight = 35.0;
default
{
    
    on_rez(integer startparam) {
        
    }
    
    state_entry()
    {
    llSetVehicleType(VEHICLE_TYPE_BALLOON);
    llSetVehicleFlags( VEHICLE_FLAG_HOVER_GLOBAL_HEIGHT  );

    // more like a baloon
    llSetVehicleFloatParam(VEHICLE_VERTICAL_ATTRACTION_TIMESCALE, 1.0);
    //llSetVehicleFloatParam(VEHICLE_VERTICAL_ATTRACTION_TIMESCALE, 3.0);
    llSetVehicleFloatParam(VEHICLE_VERTICAL_ATTRACTION_EFFICIENCY, 0.8);

    llSetVehicleFloatParam(VEHICLE_HOVER_TIMESCALE, 1.0);
    //llSetVehicleFloatParam(VEHICLE_HOVER_TIMESCALE, 3.0);
    llSetVehicleFloatParam(VEHICLE_HOVER_EFFICIENCY, 0.8);

    // more like a plane
    llSetVehicleFloatParam(VEHICLE_BANKING_EFFICIENCY, 0.5);
    llSetVehicleFloatParam(VEHICLE_BANKING_MIX, 0.5);
    llSetStatus(STATUS_PHYSICS, TRUE);
    llSetVehicleFloatParam( VEHICLE_HOVER_HEIGHT, minHeight );
    
    llSensorRepeat("", NULL_KEY, AGENT, 7.0, PI, 2);
    }
    
 
     sensor(integer total_number) // total_number is the number of avatars detected.
    {
        //llOwnerSay("ein agent da");
        
        llSetVehicleFloatParam( VEHICLE_HOVER_HEIGHT, maxHeight );
        llApplyImpulse(llGetMass()*<0,0,0.5>,FALSE);
        llSetTimerEvent(6.0); 
    }

 
    timer() {
        llSetVehicleFloatParam( VEHICLE_HOVER_HEIGHT, minHeight );
        llApplyImpulse(llGetMass()*<0,0,0.5>,FALSE);
 //       llOwnerSay("keiner da");
        llSetTimerEvent(0.0);
    } 
}
