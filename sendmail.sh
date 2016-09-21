#!/bin/bash

awk  'BEGIN{FS=",";i=1}
    {

        NAME_OF_USER[i]=$1;
        DONATION_OF_USER[i]=$4;
        EMAIL_OF_USER[i]=$2;
        PAN_OF_USER[i]=$3;
        i=i+1;
    }
    END{
	    for(x=1;x<i;x++) {
            system("m4 -D NAME_OF_USER=\""NAME_OF_USER[x]"\" -D DONATION_OF_USER=\""DONATION_OF_USER[x] "\" -D EMAIL_OF_USER=\""EMAIL_OF_USER[x]"\" -D PAN_OF_USER=\""PAN_OF_USER[x]"\" mail-template.m4 > temp.txt" );
            system("echo  " "\"From:smsharma\r\nSubject: Thanking You\r\n\r\n`cat temp.txt` \" " "	|msmtp --debug --from=smsharma@cse.iitk.ac.in -t" EMAIL_OF_USER[x])}
    }
    ' $1;

