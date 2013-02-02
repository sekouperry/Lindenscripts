key requestId;
list resultList;
string rawList;
integer firstRun;
float refreshTime = 30.0;

default
{
    state_entry()
    {
        integer i;
        rawList = "";
        firstRun = 1;
        // llRequestPermissions(llGetOwner(), PERMISSION_CHANGE_LINKS);
        llSetTimerEvent(refreshTime);
        llListen(998, "", llGetOwner(), "" );
    }

   listen(integer channel, string name, key id, string message) {
        if(message == "#stop#") {
            // stops the automatic refresh of the tweets
            llSetTimerEvent(0.0);
            llOwnerSay("The automatic refresh has been stopped. Reactivate using #start#");
        } else if(message == "#start#") {
            llSetTimerEvent(refreshTime);
            llOwnerSay("Refresh will taking place every " + (string)refreshTime + " seconds. Stop using #stop#");
        } else {
            llOwnerSay("trying to send your status message: " + message);
            llHTTPRequest("http://myserver:3000/twitter/post_message",[HTTP_METHOD,"POST", HTTP_MIMETYPE, "application/x-www-form-urlencoded"],"msg="+message);
            llOwnerSay("ok, status has been sent.");
        }
    }

    timer() {
        llOwnerSay("loading tweets...");
        requestId = llHTTPRequest("http://myserver:3000/twitter/get_messages?type=public",[HTTP_METHOD,"GET"],"");
    }

    http_response(key request_id, integer status, list metadata, string body) {
        integer i;
        
        if (request_id == requestId) {
            rawList = body;

            // create the boxes from the list information
            resultList = llParseString2List(body,["\n"],[]);
            integer listlength = llGetListLength(resultList);
            float boxPosition = 1;
            
            for(i=0;i<listlength;i+=1) {

                string statusLineWithName = llList2String(resultList, i);
                list statusParts = llParseString2List(statusLineWithName, ["|"], []);
                string text = llList2String(statusParts, 0);
                string name = llList2String(statusParts, 1);
                llOwnerSay(name + ": " + text);
               }     
            firstRun = 0;
        
        } else {
            // llSay(0,(string)status+" error");
        }
    }    
}
