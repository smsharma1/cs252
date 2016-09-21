#!/usr/bin/expect
set timeout 20
read user;
spawn openssl s_client -crlf -connect imap.cse.iitk.ac.in:993 -CAfile certificate.crt
send "$user\r"
send "PASS mypass\r"
send "LIST\r"
expect "password"
send "tag login $user $password\r"

interact

