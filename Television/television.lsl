key VIDEO_DEFAULT = "6e0f05ad-1809-4edc-df29-fae3d2a6c9b8";
string videoUrl = "";
integer CHANNEL = 42;
list MENU_MAIN = ["The Simpsons Movie", "F4: Silver Surfer", "The Number 23", "Pathfinder"]; // the main menu
// list MENU_OPTIONS = ["Cherry", "Blueberry", "Vinegar", "Slime", "Chips", "Salad", "...Back"]; // a submenu

playVideo() {

        if(llGetLandOwnerAt(llGetPos()) != llGetOwner()) {
            llSay(0,"Error: Cannot modify parcel media settings. "+llGetObjectName()+" is not owned by parcel owner.");       
        } 
        
        key video_texture = llList2Key(llParcelMediaQuery( [PARCEL_MEDIA_COMMAND_TEXTURE]), 0);
    
        if(video_texture == NULL_KEY)
        {
            llSay(0, "is null");
            video_texture = VIDEO_DEFAULT;
            llParcelMediaCommandList([PARCEL_MEDIA_COMMAND_TEXTURE, VIDEO_DEFAULT]);
        }
        llSetTexture(video_texture,4);
        llParcelMediaCommandList([PARCEL_MEDIA_COMMAND_URL,videoUrl]);
        llParcelMediaCommandList([PARCEL_MEDIA_COMMAND_PLAY]);
        llParcelMediaCommandList([PARCEL_MEDIA_COMMAND_AUTO_ALIGN,TRUE]);
}

default
{
    state_entry() {
		llListen(CHANNEL, "", NULL_KEY, "");
        llSetTexture(VIDEO_DEFAULT,4);
    }

    touch_start(integer total_number) {
        llDialog(llDetectedKey(0), "Welcome,\n\nwhich movie trailer do you want to see?", MENU_MAIN, CHANNEL); // present dialog on click
    }

    listen(integer channel, string name, key id, string message)
    {
        // if (llListFindList(MENU_MAIN + MENU_OPTIONS, [message]) != -1)  // verify dialog choice
		if (llListFindList(MENU_MAIN, [message]) != -1)  // verify dialog choice
        {
			
			if(message == "The Simpsons Movie") {
				videoUrl = "http://images.apple.com/movies/fox/the_simpsons_movie/the_simpsons_movie-tlr_h.480.mov";
			} 	else if(message=="F4: Silver Surfer") {
					videoUrl = "http://images.apple.com/movies/fox/fantastic_4-silver_surfer/fantastic4silversurfer-tlr1_h.480.mov";
			}
				else if(message=="The Number 23") 
				{
					videoUrl = "http://images.apple.com/movies/newline/the_number_23/the_number_23-tlr1_h.480.mov";
				}
				else if(message=="Pathfinder") 
				{
					videoUrl = "http://images.apple.com/movies/fox/pathfinder/pathfinder-tlrd_h.480.mov";
				}
			playVideo();
            // if (message == "Options...")
            //     llDialog(id, "Pick an option!", MENU_OPTIONS, CHANNEL); // present submenu on request
            // else if (message == "...Back")
            //     llDialog(id, "What do you want to do?", MENU_MAIN, CHANNEL); // present main menu on request to go back
            // // here you have the name and key of the user and can easily verify if they have the permission to use that option or not
            // else if (message == "Sit")
            //     llSay(0, "This is where stuff would happen if this wasn't just an example");
        } else {
            llSay(0, name + " picked invalid option '" + llToLower(message) + "'."); // not a valid dialog choice
    	}
	}

}