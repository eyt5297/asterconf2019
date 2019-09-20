#!/bin/bash
ASTETCDIR="/etc/asterisk"
PATHSTARTFILE=`pwd`/$0
PATHTEST=`dirname $PATHSTARTFILE`
AST="$PATHTEST/cfg/asterisk"

echo PATHTEST=$PATHTEST >${AST}/extensions_globals_testenv.conf
rm -f ${PATHTEST}/result.log

cp -f ${AST}/*.conf ${ASTETCDIR}/

asterisk -rx "sip reload"
asterisk -rx "dialplan reload" > /dev/null
asterisk -rx "originate Local/test1@test extension test2@test"
