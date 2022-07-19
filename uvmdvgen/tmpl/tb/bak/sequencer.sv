`ifndef chnl_master_sequencer
`define chnl_master_sequencer
    class chnl_master_sequencer extends uvm_sequencer#(chnl_transaction);

        `uvm_component_utils(chnl_master_sequencer)

        function new(string name = "chnl_master_sequencer",uvm_component parent);
            super.new(name,parent);
        endfunction

    endclass
`endif