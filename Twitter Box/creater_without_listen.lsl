key requestId;
list resultList;
string rawList;
integer firstRun;

default
{
    state_entry()
    {
        integer i;
        rawList = "";
        firstRun = 1;
        llRequestPermissions(llGetOwner(), PERMISSION_CHANGE_LINKS);
        llSetTimerEvent(30.0);
    }

    timer() {
        requestId = llHTTPRequest("http://myserver:3000/twitter/get_messages?type=public",[HTTP_METHOD,"GET"],"");
    }

    http_response(key request_id, integer status, list metadata, string body) {
        integer i;
        
        if (request_id == requestId) {

            if(body != "error") {
                rawList = body;
    
                // create the boxes from the list information
                resultList = llParseString2List(body,["\n"],[]);
                integer listlength = llGetListLength(resultList);
                float boxPosition = 1;
                
                for(i=0;i<10;i+=1) {
                    if(firstRun == 1) {
                        // rez objects only in the first run
                        //llWhisper(0, "rez object "+(string)i);
                        llRezObject("status", llGetPos() + <0, 0, boxPosition>, ZERO_VECTOR, ZERO_ROTATION, i);
                        boxPosition+= 0.7;
                    } else {
                        // after that only update with link messages
                        llMessageLinked(LINK_ALL_CHILDREN, 0, rawList, NULL_KEY);    
                    }
                }     
                firstRun = 0;
            }   
        }
    }    

    object_rez(key id) {
        llCreateLink(id, 1);
        llMessageLinked(LINK_ALL_CHILDREN, 0, rawList, NULL_KEY);    
    }
    
}
