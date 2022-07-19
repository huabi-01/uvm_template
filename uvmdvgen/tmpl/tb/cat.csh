#!/bin/csh -f 

set list = (transaction.sv driver.sv monitor.sv sequencer.sv agent.sv)

foreach file ($list)
echo $file
cat $file >> agent_pkg.sv
end
