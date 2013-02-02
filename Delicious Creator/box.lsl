integer childNumber;
string name;
string link_url;

default
{
    touch_start(integer total_number)
    {
		llLoadURL(llDetectedKey(0), name, link_url);
    }

    on_rez(integer start_param) {
        llSetText("waiting... ", <0,0,.5>, 1.0);
		childNumber = start_param;
    }
    
    link_message(integer sender_num, integer num, string str, key id) {
		list resultList = llParseString2List(str,["|"],[]);
		link_url = llList2String(resultList, childNumber);
		name = llList2String(resultList, childNumber+1);
		llSetText(name, <0,0,.5>, 1.0);
    }    
}
