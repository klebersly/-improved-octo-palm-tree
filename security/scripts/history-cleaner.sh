#!/bin/bash

#VARS

DATE=`date +%m/%d/%Y`
BASELOG="/var/log"
BASESPOOL="/var/spool"
BASEMAIL="/var/spool/mail"
BASESA="/var/log/sa"
ROOT="/root"
MLOG="mail/statistics"
ALOG="audit/audit.log"

# Clear Log and Mail files.

echo "---: no logs no crime - $DATE :---" > $BASELOG/$ALOG
echo "---: no logs no crime - $DATE :---" > $BASELOG/$MLOG
echo "---: no logs no crime - $DATE :---" > $BASELOG/boot.log
echo "---: no logs no crime - $DATE :---" > $BASELOG/btmp
echo "---: no logs no crime - $DATE :---" > $BASELOG/cron
echo "---: no logs no crime - $DATE :---" > $BASELOG/dmesg
echo "---: no logs no crime - $DATE :---" > $BASELOG/dracut
echo "---: no logs no crime - $DATE :---" > $BASELOG/kernel
echo "---: no logs no crime - $DATE :---" > $BASELOG/lastlog
echo "---: no logs no crime - $DATE :---" > $BASELOG/maillog
echo "---: no logs no crime - $DATE :---" > $BASELOG/messages
echo "---: no logs no crime - $DATE :---" > $BASELOG/monitorix
echo "---: no logs no crime - $DATE :---" > $BASELOG/secure
echo "---: no logs no crime - $DATE :---" > $BASELOG/spooler
echo "---: no logs no crime - $DATE :---" > $BASELOG/tallylog
echo "---: no logs no crime - $DATE :---" > $BASELOG/wtmp
echo "---: no logs no crime - $DATE :---" > $BASELOG/yum.log

echo "---: no logs no crime - $DATE :---" > $BASESA/sa30
echo "---: no logs no crime - $DATE :---" > $BASESA/sa31
echo "---: no logs no crime - $DATE :---" > $BASESA/sar30

echo "---: no logs no crime - $DATE :---" > $BASEMAIL/root
echo "---: no logs no crime - $DATE :---" > $BASEMAIL/monitorix
echo "---: no logs no crime - $DATE :---" > $BASEMAIL/rpc

# Deletion 

rm -rf $BASELOG/*-*			# Removes all rotated logs that have name-date format.
rm -rf $BASELOG/*.old			# Removes all logs ending in .old.
rm -rf $BASESPOOL/clientmqueue/*	# Empty client Mail Queue.
rm -rf $BASESPOOL/mqueue/*		# Empty Mail Queue.
history -c
rm -rf $ROOT/.bash_history		# Removes history file. (It will recreate its self.)
history -c

# EOF
