`ifndef  chnl_master_driver
`define chnl_master_driver
    class chnl_master_driver extends uvm_driver#(chnl_transaction);
        `uvm_component_utils(chnl_master_driver)
        
        virtual  vif;

        function new(string name = "chnl_master_driver",uvm_component parent);
            super.new(name,parent);
        endfunction 

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if(!uvm_config_db#(virtual )::get(this,"","vif",vif))
                `uvm_fatal(get_type_name(),"Interface is not set for driver")
        endfunction
        
        virtual task run_phase(uvm_phase phase);
            super.run_phase(phase);
            fork 
                reset_signals();
                get_and_drive();
            join_none
        endtask 

        // Used to initial value of the vif signals
        virtual task reset_signals();
            forever begin 
            
            end
        endtask
        
        // Used to get the next item from sequencer, apply it to interface
        // and return the response back
        virtual task get_and_drive();
            forever begin 
                seq_item_port.get_next_item(req);
                $cast(rsp,req.clone());
                `uvm_info(get_type_name(),$sformatf("rcvd item:\n%0s",req.sprint()),UVM_HIGH)
                // TODO: drive singal to dut
                seq_item_port.item_done();
                `uvm_info(get_type_name(),"item sent",UVM_HIGH)
            end
        endtask

    endclass
`endif