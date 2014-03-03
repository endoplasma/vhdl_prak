#############################################################
# vsimsa environment configuration
set dsn $curdir
log $dsn/log/vsimsa.log
@echo
@echo #################### Starting C Code Debug Session ######################
cd $dsn/src
amap prakt $dsn/prakt.lib
set worklib prakt
# simulation
asim -callbacks testbench_for_intro 
run -all
#############################################################