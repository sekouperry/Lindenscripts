key requestId;
string custid;

default
{
    state_entry()
    {
        llListen( 0, "", NULL_KEY, "" );
        custid = "";
    }

    touch_start(integer total_number)
    {
        llWhisper(0, "Talk to me on Chat-Channel 0.");
    }
    
    listen(integer channel, string name, key id, string message)
    {
        requestId = llHTTPRequest("http://myserver/bot/ask_question",[HTTP_METHOD,"POST", HTTP_MIMETYPE, "application/x-www-form-urlencoded"],"q="+message+"&cid="+custid);
    }    
    
     http_response(key request_id, integer status, list metadata, string body) {
        
        if (request_id == requestId) {
            
            if(body == "erro") {
                llWhisper(0, "An error occurred. Please try again later");
            } else {
    
                list parts = llParseString2List(body,["||"],[]);

                string that = llList2String(parts, 0);
                custid = llList2String(parts, 1);
                llWhisper(0, that);
            } 
    
        } else {
            llWhisper(0, "An error occurred. Please try again later");
        }
    }       


}
