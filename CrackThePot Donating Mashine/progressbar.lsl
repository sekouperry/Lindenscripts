vector currentScale;
vector currentPosition;
float sizeOfTube = 2.0;
integer maxPotSize = 250;

default {

	state_entry() {
		currentScale = llGetScale();
		currentPosition = llGetPos();
		llSetPrimitiveParams([ PRIM_SIZE, <currentScale.x,currentScale.y,0.01>]);
 	}

	link_message(integer sender_num, integer num, string str, key id) {
		
		if(str != "") {
			// process messages
			if(str == "reset") {
				maxPotSize = 250;
				currentScale = llGetScale();
				currentPosition = llGetPos();
				llSetPrimitiveParams([ PRIM_SIZE, <currentScale.x,currentScale.y,0.01>]);
				float newZPos = (sizeOfTube/2.0);
				vector newPosition = <newZPos,0,0>;
				llSetPos(newPosition);
			} else if(str == "setmaxpot") {
				maxPotSize = num;
			} else if(str == "restart") {
				currentScale = llGetScale();
				currentPosition = llGetPos();
				llSetPrimitiveParams([ PRIM_SIZE, <currentScale.x,currentScale.y,0.01>]);
				float newZPos = (sizeOfTube/2.0);
				vector newPosition = <newZPos,0,0>;
				llSetPos(newPosition);
			}
			
		} else {
				currentScale = llGetScale();
				currentPosition = llGetLocalPos();
		 		float delta = (float)num * (sizeOfTube / (float)maxPotSize);

				float currentHeight = currentScale.z;
				float currentZPos = currentPosition.z;
			//		llSay(0, "current height =" + (string)currentScale.z);
				float newHeight =  currentScale.z + delta;

//				if(newHeight >= 2.0) {
//					llSay(0, "Ooooh Wheeee!! You have cracked the 200 L$ in the tube. Thanks a lot, pal. I love you so much!");
//					newHeight = 0.01;
//				}

			//		llSay(0, "new height =" + (string)newHeight);

				llSetPrimitiveParams([ PRIM_SIZE, <currentScale.x,currentScale.y,newHeight>]);

			//		llSay(0, "current z-pos = " + (string)currentZPos);

				float newZPos = ((sizeOfTube/2.0) - (newHeight/2.0));
				vector newPosition = <newZPos,0,0>;
				llSetPos(newPosition);
		}
	}

}

