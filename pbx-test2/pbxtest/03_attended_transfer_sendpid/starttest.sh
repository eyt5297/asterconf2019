#!/bin/bash
ASTETCDIR="/etc/asterisk"
PATHSTARTFILE=`pwd`/$0
PATHTEST=`dirname $PATHSTARTFILE`
AST="$PATHTEST/cfg/asterisk"
PJS="$PATHTEST/cfg/pjsua"

echo PATHTEST=$PATHTEST >${AST}/extensions_globals_testenv.conf
rm -f ${PATHTEST}/result.log

cp -f ${AST}/*.conf ${ASTETCDIR}/

asterisk -rx "sip reload"
asterisk -rx "dialplan reload" > /dev/null
asterisk -rx "originate Local/test1@test extension test2@test"
#pjsua --config-file ${PJS}/209.cfg < ${PJS}/209.input >/dev/null
/usr/sbin/pjsua --config-file ${PJS}/209.cfg < ${PJS}/209.input >/dev/null
