#!/bin/bash
awk '
BEGIN{FS=",";i=1}
{
    NAME_OF_USER[i]=$1;
    DONATION_OF_USER[i]=$4;
    EMAIL_OF_USER[i]=$2;
    PAN_OF_USER[i]=$3;
    i=i+1;
}
END{
    for(x=1;x<i;x++) {
	system("m4 -D NAME_OF_USER=\""NAME_OF_USER[x]"\" -D DONATION_OF_USER=\""DONATION_OF_USER[x] "\" -D EMAIL_OF_USER=\""EMAIL_OF_USER[x]"\" -D PAN_OF_USER=\""PAN_OF_USER[x]"\" 80g.tex.m4 > mail_temp.tex" );
	system("pdflatex mail_temp.tex");
	system("m4 -D NAME_OF_USER=\""NAME_OF_USER[x]"\" -D DONATION_OF_USER=\""DONATION_OF_USER[x] "\" -D EMAIL_OF_USER=\""EMAIL_OF_USER[x]"\" -D PAN_OF_USER=\""PAN_OF_USER[x]"\" mail-template.m4 > mail_temp.txt" );
	system("echo  " "\"From:smsharma@cse.iitk.ac.in\r\nSubject: Thanking You\r\n\r\n`cat mail_temp.txt` \" " " | mutt -a mail_temp.pdf -- " EMAIL_OF_USER[x])
    }
}
' $1;
