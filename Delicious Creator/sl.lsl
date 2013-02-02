default
{
    state_entry() {
        rotation z_90 = llEuler2Rot( <0, 0, 180 * DEG_TO_RAD> );
        llSitTarget(<0.0, 0.0, .5>, z_90);
    }
    
    touch_start(integer total_number)
    {
        vector displacement;
        vector currentPosition;
        vector newPosition;
        integer i; 
       
        currentPosition = llGetPos();
        
        if(currentPosition.z > 40) {
            // move down
            displacement = <0,0,-5>;
        } else {
            // move up 
            displacement = <0,0,5>;
        } 
        
        if((llAvatarOnSitTarget() != NULL_KEY) && (llDetectedName(0) == "Mbulu Oh")) {        
            llSay(0, "Here we go...");
            for(i=0;i<80;i++) {
                currentPosition = llGetPos();
                newPosition = currentPosition + displacement;
                llSetPos(newPosition);
            }
        } else {
            llSay(0, "Sorry."); 
        }
    }
    
}
