`ifndef <$ name $>_sequencer
`define <$ name $>_sequencer
    class <$ name $>_sequencer extends uvm_sequencer#(<$ name $>_transaction);

        `uvm_component_utils(<$ name $>_sequencer)

        function new(string name = "<$ name $>_sequencer",uvm_component parent);
            super.new(name,parent);
        endfunction

    endclass
`endif
