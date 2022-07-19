`ifndef router_slave_monitor
`define router_slave_monitor
    class router_slave_monitor extends uvm_monitor#(router_transaction);
        `uvm_component_utils(router_slave_monitor)
        
        uvm_analysis_port#(router_transaction) mst_mon_ap;
         vif;
        
        function new(string name = "router_slave_monitor",uvm_component parent);
            super.new(name,parent);
        endfunction 

        virtual function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if(!uvm_config_db#(virtual )::get(this,"","vif",vif))
                `uvm_fatal(get_type_name(),"Interface is not set for monitor")
            mst_mon_ap = new("mst_mon_ap",this);
        endfunction 

        virtual task run_phase(uvm_phase phase);
            super.run_phase(phase);
        endtask

        virtual task collect_trans();
            forever begin
                // TODO: detect event
                // TODO: sample the interface
                // TODO: sample the covergroups
                // TODO: write trans to analysis_port
            end
        endtask 

    endclass
`endif