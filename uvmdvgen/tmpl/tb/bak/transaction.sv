`ifndef chnl_transaction
`define chnl_transaction
    class chnl_master_transaction extends uvm_sequence_item;

        function new(string name = "chnl_master_transaction");
            super.new(name);
        endfunction 

        `uvm_object_utils_begin(chnl_master_transaction)
            `uvm_field_int(,UVM_ALL_ON)
            `uvm_field_enum(,UVM_ALL_ON)
            `uvm_field_array_int(,UVM_ALL_ON)
            `uvm_field_queue_int(,UVM_ALL_ON)
        `uvm_object_utils_end

    endclass
`endif