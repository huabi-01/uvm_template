`ifndef router_slave_agent
    class router_slave_agent extends uvm_agent;
        `uvm_component_utils(router_slave_agent)

        router_slave_driver drv;
        router_slave_monitor mon;
        router_slave_sequencer sqr;

        function new(string name = "router_slave_agent",uvm_component parent);
            super.new(name,parent);
        endfunction 

        virtual function build_phase(uvm_phase phase);
            super.build_phase(phase);
            if(is_active == UVM_ACTIVE) begin
                sqr = router_slave_sequencer::type_id::create("sqr",this);
                drv = router_slave_driver::type_id::create("drv",this);
            end
            
            mon = router_slave_monitor::type_id::create("mon",this);
        endfunction 

        virtual function connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            if(is_active == UVM_ACTIVE) begin
                drv.seq_item_port.connect(sqr.seq_item_export);
            end
        endfunction 
    endclass
`endif