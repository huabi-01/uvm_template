`ifndef router_master_agent
    class router_master_agent extends uvm_agent;
        `uvm_component_utils(router_master_agent)

        router_master_driver drv;
        router_master_monitor mon;
        router_master_sequencer sqr;

        function new(string name = "router_master_agent",uvm_component parent);
            super.new(name,parent);
        endfunction 

        virtual function build_phase(uvm_phase phase);
            super.build_phase(phase);
            if(is_active == UVM_ACTIVE) begin
                sqr = router_master_sequencer::type_id::create("sqr",this);
                drv = router_master_driver::type_id::create("drv",this);
            end
            
            mon = router_master_monitor::type_id::create("mon",this);
        endfunction 

        virtual function connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            if(is_active == UVM_ACTIVE) begin
                drv.seq_item_port.connect(sqr.seq_item_export);
            end
        endfunction 
    endclass
`endif