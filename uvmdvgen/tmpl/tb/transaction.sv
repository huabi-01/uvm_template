`ifndef <$ name $>_transaction
`define <$ name $>_transaction
    class <$ name $>_transaction extends uvm_sequence_item;

        function new(string name = "<$ name $>_transaction");
            super.new(name);
        endfunction 

        `uvm_object_utils_begin(<$ name $>_transaction)
            `uvm_field_int( ,UVM_ALL_ON)
            `uvm_field_enum( ,UVM_ALL_ON)
            `uvm_field_array_int( ,UVM_ALL_ON)
            `uvm_field_queue_int( ,UVM_ALL_ON)
        `uvm_object_utils_end

    endclass
`endif
