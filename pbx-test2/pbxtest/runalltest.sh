cd 01_dial2group && sh starttest.sh && sleep 2 && cat result.log && cd .. 
cd 02_ivr && sh starttest.sh && sleep 15 && cat result.log && cd .. 
cd 03_attended_transfer_sendpid && sh starttest.sh && sleep 0 && cat result.log && cd .. 
