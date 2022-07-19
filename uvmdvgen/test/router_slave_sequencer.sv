`ifndef router_slave_sequencer
`define router_slave_sequencer
    class router_slave_sequencer extends uvm_sequencer#(router_slave_sequencer);

        `uvm_component_utils(router_slave_sequencer)

        function new(string name = router_slave_sequencer,uvm_component parent);
            super.new(name,parent);
        endfunction

    endclass
`endif