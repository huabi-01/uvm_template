#!/bin/csh -f 

#set list = (agent.sv driver.sv monitor.sv sequence_lib.sv sequencer.sv transaction.sv)

foreach file (`ls *sv`)
echo $file
sed -i 's#chnl_master#<$ name $>#g' $file
end
