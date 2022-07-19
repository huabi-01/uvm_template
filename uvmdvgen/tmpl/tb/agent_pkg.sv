package <$ name $>_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

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

    class <$ name $>_driver extends uvm_driver#(chnl_transaction);
        `uvm_component_utils(<$ name $>_driver)
        
        virtual <$ intf_name $>_if vif;

        function new(string name = "<$ name $>_driver",uvm_component parent);
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
            //TODO
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

    class <$ name $>_monitor extends uvm_monitor#(<$ name $>_transaction);
        `uvm_component_utils(<$ name $>_monitor)
        
        uvm_analysis_port#(<$ name $>_transaction) mon_ap;
        virtual <$ intf_name $>_if vif;
        
        function new(string name = "<$ name $>_monitor",uvm_component parent);
            super.new(name,parent);
        endfunction 

        virtual function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if(!uvm_config_db#(virtual )::get(this,"","vif",vif))
                `uvm_fatal(get_type_name(),"Interface is not set for monitor")
            mon_ap = new("mon_ap",this);
        endfunction 

        virtual task run_phase(uvm_phase phase);
            super.run_phase(phase);
        endtask

        virtual task collect_trans();
            forever begin
                // TODO
            end
        endtask 

    endclass

    class <$ name $>_sequencer extends uvm_sequencer#(<$ name $>_transaction);

        `uvm_component_utils(<$ name $>_sequencer)

        function new(string name = "<$ name $>_sequencer",uvm_component parent);
            super.new(name,parent);
        endfunction

    endclass

    class <$ name $>_agent extends uvm_agent;
        `uvm_component_utils(<$ name $>_agent)

        <$ name $>_driver drv;
        <$ name $>_monitor mon;
        <$ name $>_sequencer sqr;

        function new(string name = "<$ name $>_agent",uvm_component parent);
            super.new(name,parent);
        endfunction 

        virtual function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if(is_active == UVM_ACTIVE) begin
                sqr = <$ name $>_sequencer::type_id::create("sqr",this);
                drv = <$ name $>_driver::type_id::create("drv",this);
            end
            mon = <$ name $>_monitor::type_id::create("mon",this);
        endfunction 

        virtual function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            if(is_active == UVM_ACTIVE) begin
                drv.seq_item_port.connect(sqr.seq_item_export);
            end
        endfunction 
    endclass

endpackage
