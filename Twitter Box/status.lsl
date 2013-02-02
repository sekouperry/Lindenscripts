integer childNumber;
string text;
string name;

default
{
    touch_start(integer total_number)
    {
        // llLoadURL(llDetectedKey(0), name, link_url);
    }

    on_rez(integer start_param) {
        llSetText("creating... ", <1,1,1>, 1.0);
        childNumber = start_param;
    }
    
    link_message(integer sender_num, integer num, string str, key id) {
        llSetText("updating... ", <1,1,1>, 1.0); 
        list resultList = llParseString2List(str,["\n"],[]);

        string statusLineWithName = llList2String(resultList, childNumber);
		list statusParts = llParseString2List(statusLineWithName, ["|"], []);
        text = llList2String(statusParts, 0);
		name = llList2String(statusParts, 1);
        llSetText(name + " is doing the following right now:\n" + text, <1,1,1>, 1.0);
    }    
}
