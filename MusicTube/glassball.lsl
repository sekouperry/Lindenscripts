string streamUrl = "http://64.236.34.97:80/stream/1009";
string streamName = "Lounge";
string streamUrl = "http://64.236.98.51:80/stream/1010";
string streamName = "Jazz";
string streamUrl = "http://64.236.34.97:80/stream/1013";
string streamName = "80s";
string streamUrl = "http://64.236.34.97:80/stream/1014";
string streamName = "Current Hits";
string streamUrl = "http://64.236.126.42:80/stream/1017";
string streamName = "Reggae";

// float currentColor =
 
default {
    state_entry() {
        llSetText(streamName, <1,1,1>,1.0);
		llSetColor(<1,1,1>, ALL_SIDES);
		llSetAlpha(0.3, ALL_SIDES);
    }

    touch_start(integer total_number) {
        llSetParcelMusicURL(streamUrl);
		llMessageLinked(LINK_SET,0,llGetObjectName(),NULL_KEY);
    }

	link_message(integer sender_num, integer num, string str, key id) {
		if(str == llGetObjectName()) {
			llSetColor(<0.80784313725,0.17254901961,0.82745098039>, ALL_SIDES);
			llSetAlpha(0.6, ALL_SIDES);
			//llSetTimerEvent(0.1);
		} else {
			// llSetTimerEvent(0);
			llSetColor(<1,1,1>, ALL_SIDES);
			llSetAlpha(0.3, ALL_SIDES);
		}
	}
	
	timer() {
		// llSetColor(<llFrand(1.0),llFrand(1.0),llFrand(1.0)>,ALL_SIDES); 
	}

}
