integer slideToDisplay;
integer firstSlideReached;
integer currentSlide;

default
{
    state_entry() {
        firstSlideReached = 1;
        slideToDisplay = 1;
        currentSlide = 1;
        llSetTexture("da79968e-b8b7-8a0a-cc66-2a717e9c3d41", 4);
        llRotateTexture(PI, 4);
    }
    
    touch_start(integer total_number)
    {
        if(firstSlideReached == 0) {
            slideToDisplay = currentSlide - 1;
            //llSay(0, "Trying to get slide number " + (string)slideToDisplay);
            llMessageLinked(LINK_SET,slideToDisplay,"slideToDisplay",NULL_KEY);
        } else {
            llSay(0, "First slide reached.");
        }
    }

    link_message(integer sender_num, integer num, string str, key id) {
        
        if(str == "currentSlide") {
            //llSay(0, "current slide is " + (string) num);
            currentSlide = num;
            if(currentSlide == 1) {
                firstSlideReached = 1;
            } else {
                firstSlideReached = 0;
            }
         }
    }
}