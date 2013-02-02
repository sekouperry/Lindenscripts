integer slideToDisplay;
integer lastSlideReached;
integer currentSlide;
integer maxSlide;

default
{
    state_entry() {
        lastSlideReached = 0;
        slideToDisplay = 1;
        currentSlide = 1;
        maxSlide = 1000;
        llSetTexture("da79968e-b8b7-8a0a-cc66-2a717e9c3d41", 4);
    }
    
    touch_start(integer total_number)
    {
        if(lastSlideReached == 0) {
            slideToDisplay = currentSlide + 1;
            //llSay(0, "Trying to get slide number " + (string)slideToDisplay);
            llMessageLinked(LINK_SET,slideToDisplay,"slideToDisplay",NULL_KEY);
        } else {
            llSay(0, "Last slide reached.");
        }
    }

    link_message(integer sender_num, integer num, string str, key id) {

        if(str == "currentSlide") {
            currentSlide = num;
            if(currentSlide < maxSlide) {
                lastSlideReached = 0;
            }
//            llSay(0, "current slide is " + (string) num);
//            llSay(0, "max slide is " + (string) maxSlide);
         } 

        if(str == "lastSlideReached" && num == 1) {
            lastSlideReached = 1;
            maxSlide = currentSlide;
			//llSay(0, "maxslide = " + (string) maxSlide);
    	}
	}

}