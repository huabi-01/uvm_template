`ifndef <$ name $>_sequence_lib
`define <$ name $>_sequence_lib
    class <$ name $>_base_sequence extends uvm_sequence#(<$ name $>_transaction);

        `uvm_object_utils(<$ name $>_base_sequence)

        function new(string name = "<$ name $>_base_sequence");
            super.new(name);
        endfunction

    endclass

`endif
