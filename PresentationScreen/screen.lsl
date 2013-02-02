integer lastSlideReached;
integer firstSlideReached;
integer currentSlide;

default {
    
    state_entry() {
        // check for first slide and set it when available
        if(llGetInventoryKey("1") != NULL_KEY) {
            llSetTexture("1", 4);
        } else {
            llSetTexture("b13e131e-13a4-37ad-e137-4b6f81a0a3fa", 4);
        }
    }

    link_message(integer sender_num, integer num, string str, key id) {

        if(str == "slideToDisplay") {
            string slideToDisplayStr = (string) num;

            if(llGetInventoryKey(slideToDisplayStr) != NULL_KEY) {
                llSetTexture((string)num, 4);
                llMessageLinked(LINK_SET,num,"currentSlide",NULL_KEY);
                
                // check if next slide exists
                integer nextSlideNr = num+1;
                string nextSlideStr = (string) nextSlideNr;
                //llSay(0, "check for next slide nr " + nextSlideStr);
                if(llGetInventoryKey(nextSlideStr) == NULL_KEY) {
                    lastSlideReached = 1;
                    llMessageLinked(LINK_SET,1,"lastSlideReached",NULL_KEY);
                } else {
                    lastSlideReached = 0;
                }
             } else {
                llSay(0, "Slide not available");
            }
        }
    }
}
