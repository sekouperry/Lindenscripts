key requestId;
list resultList;
string rawList;

default
{
    state_entry()
    {
        llRequestPermissions(llGetOwner(), PERMISSION_CHANGE_LINKS);
    }

    touch_start(integer total_number) {
        integer i;
        
        requestId = llHTTPRequest("http://www.mydomain.de/delicious.txt",[HTTP_METHOD,"GET"],"");
    }
    

    http_response(key request_id, integer status, list metadata, string body) {
        integer i;
        if (request_id == requestId)
        {
			rawList = body;
			
			// create the boxes from the list information
            resultList = llParseString2List(body,["|"],[]);
            integer listlength = llGetListLength(resultList);
            integer boxPositionStart = 2;
			
            for(i=0;i<listlength;i+=2) {
                llRezObject("box", llGetPos() + <0, 0, boxPositionStart>, ZERO_VECTOR, ZERO_ROTATION, i);
                boxPositionStart++;
            }     
        
        } else {
            llSay(0,(string)status+" error");
		}
    }    

    object_rez(key id) {
		llSay(0, "linking...");
        llCreateLink(id, 1);
        llSay(0, "[ok]");
		llMessageLinked(LINK_ALL_CHILDREN, 0, rawList, NULL_KEY);    
	}
    
}
