#!/bin/sh

echo "Enter username :"
read user
echo "Enter password:"
stty -echo
read pass
stty echo

imapscript () {
echo "01 login $user $pass"
echo '02 SELECT INBOX'
echo '03 SEARCH HEADER content-type multipart since 1-Aug-2016'
while sleep 1; do
  echo "04 logout"
done
}

imapscript | openssl s_client -crlf -connect imap.cse.iitk.ac.in:993 -CAfile certificate.crt
