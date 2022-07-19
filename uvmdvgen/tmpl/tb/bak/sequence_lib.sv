`ifndef chnl_master_sequence_lib
`define chnl_master_sequence_lib
    class chnl_master_base_sequence extends uvm_sequence#(chnl_transaction);

        `uvm_object_utils(chnl_master_base_sequence)

        function new(string name = "chnl_master_base_sequence");
            super.new(name);
        endfunction

    endclass

`endif