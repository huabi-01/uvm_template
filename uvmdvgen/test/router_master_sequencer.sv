`ifndef router_master_sequencer
`define router_master_sequencer
    class router_master_sequencer extends uvm_sequencer#(router_master_sequencer);

        `uvm_component_utils(router_master_sequencer)

        function new(string name = router_master_sequencer,uvm_component parent);
            super.new(name,parent);
        endfunction

    endclass
`endif