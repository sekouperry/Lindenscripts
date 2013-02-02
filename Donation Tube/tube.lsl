integer currentPotSize;
integer maxPotDefaultSize = 300;
integer maxPotSize = 300;
integer amountToWin;
integer amountUntilCrack;
integer listen_channel = 6001;

updateAmountText() {
    amountUntilCrack = maxPotSize-currentPotSize;
    llSetText("Here you can support with some L$!\nWith the money i try to pay the rent for this place.\nJust donate some money!\nNice people have donated L$ "+ (string)currentPotSize + " so far.\nOnly L$ " + (string)amountUntilCrack + " missing to reach the weekly rent of L$ " + (string)maxPotSize+".", <1,1,1>, 1.0);
}


integer checkPermission(key id) {

   integer hasPermission = FALSE;
   if (llGetOwnerKey(id) == llGetOwner()) {
       hasPermission = TRUE;
   }
   return hasPermission;
}

default {

    state_entry() {
//        llRequestPermissions(llGetOwner(),PERMISSION_DEBIT);
        llListen(listen_channel, "", llGetOwner(), "" );
        amountToWin = (maxPotSize/2);
        currentPotSize = 0;    
        updateAmountText();      
    }

    touch_start(integer total_number) {
        //llSay(0, "To donate, right-click the tube and select 'Pay...'.");
    }
    
    money(key giver, integer amount){
        currentPotSize = currentPotSize + amount;    
        amountUntilCrack = maxPotSize-currentPotSize;
        
        string donor = llKey2Name(giver);
        llMessageLinked(LINK_SET,amount,"",NULL_KEY);
        updateAmountText();

        if(currentPotSize < maxPotSize) {
            llInstantMessage(giver,"Thanks a lot " + donor + " for your donation! I appreciate it. :) All the best to you.");
//            llInstantMessage(giver,"Sorry that you could not crack the POT. But come again later, there are only L$ " + (string)amountUntilCrack + " missing to Crack the POT!");
//            llInstantMessage(giver,"Enjoy your cool t-shirt and all the best to you!");
        } else if(currentPotSize >= maxPotSize) {
            
            // calculate the half-jackpot-size and reset the potsize to 0
            integer halfPotSize = (currentPotSize/2);
            currentPotSize = 0;
            updateAmountText();      
            
            // reset the progressbar
            llMessageLinked(LINK_SET,0,"restart",NULL_KEY);
            
            // say it loud to other people
//            llSay(0, donor + " JUST CRACKED THE POT AND GOT L$ " + (string)halfPotSize);
            
            // give the winner the money
//            llGiveMoney(giver, halfPotSize);
            
            // message to me
//            llInstantMessage(llGetOwner(),donor + " has cracked the POT and got " + (string)halfPotSize + " from you.");
            
            // message to the winner
            llInstantMessage(giver,"WHOW!!! You give the last part for the rent. Thanks a lot.");
 //           llInstantMessage(giver,"And thanks a lot " + donor + " for your donation!");
 //           llInstantMessage(giver,"Enjoy your cool t-shirt and all the best to you!");
        }

//        llGiveInventory(giver, "Crack the POT shirt");
//        llSay(0, donor + " just got a cool t-shirt!");
        
        llInstantMessage(llGetOwner(),donor + " has donated $" + (string)amount + " to you.");
    }
    

    listen(integer channel, string name, key id, string message) {
    
        string msg = llToLower(message);
        
        if(checkPermission(id) == TRUE) {
            if(msg == "reset") {
                maxPotSize = maxPotDefaultSize;                
                amountToWin = (maxPotSize/2);
                currentPotSize = 0;    
                updateAmountText();      
                llMessageLinked(LINK_SET,0,"reset",NULL_KEY);
            } else if(llSubStringIndex(msg, "setmaxpot") != -1) {
                integer strEnd = llStringLength(msg)-(1);
                string newSizeSubStr = llGetSubString(msg, 9,strEnd);
                llSay(0,newSizeSubStr);
                integer newMaxPotSize = (integer)newSizeSubStr;
                maxPotSize = newMaxPotSize;
                amountToWin = (maxPotSize/2);
                currentPotSize = 0;    
                updateAmountText();
                 llMessageLinked(LINK_SET,maxPotSize,"setmaxpot",NULL_KEY);
             }
        }
    }
}