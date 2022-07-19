`ifndef <$ name $>_monitor
`define <$ name $>_monitor
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
`endif
