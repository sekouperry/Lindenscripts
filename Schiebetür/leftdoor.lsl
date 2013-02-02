vector OpenPos;
vector OpenRot = <0, 0, 90>; 
vector ClosedPos;
vector ClosedRot = <0, 0, 90>;
integer doorChannel = 3022;
float scanDegree = 180;

default {
    state_entry()
    {
		ClosedPos = llGetPos();
		OpenPos = <ClosedPos.x+2,ClosedPos.y,ClosedPos.z>;
		llListen(doorChannel, "", NULL_KEY, "");
        state closed;
    }
}

state closed {
    
    touch_start(integer total_number) {
        llWhisper(doorChannel, "open");
        state open;
    }
    
    state_entry() {
		llSensorRepeat("", NULL_KEY, AGENT, 2, scanDegree*DEG_TO_RAD, 1);
        llListen(doorChannel, "", NULL_KEY, "");
        llSetPos(ClosedPos);
        llSetRot(llEuler2Rot(ClosedRot * DEG_TO_RAD));
    }

    listen(integer channel, string name, key id, string message) {
        if(channel == doorChannel) {
            if(message == "open") {
                state open;
            }
        }
    }

    sensor(integer total_number) // total_number is the number of avatars detected.
    {
		llWhisper(doorChannel, "open");
		state open;
    }
    
}

state open { 
    
    touch_start(integer N) { 
        llWhisper(doorChannel, "close");
        state closed; 
    } 
    
    state_entry() { 
        llSetTimerEvent(4.0);
        llListen(doorChannel, "", NULL_KEY, "");
        llSetPos(OpenPos); 
        llSetRot(llEuler2Rot(OpenRot * DEG_TO_RAD)); 
    } 

    listen(integer channel, string name, key id, string message) {
        if(channel == doorChannel) {
            if(message == "close") {
                state closed;
            }
        }
    }

    timer() {
        llWhisper(doorChannel, "close");
        state closed; 
    }
}