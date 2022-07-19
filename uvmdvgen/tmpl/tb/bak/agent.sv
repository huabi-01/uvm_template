`ifndef <$ name $>_master_agent
`define <$ name $>_master_agent
    class <$ name $>_master_agent extends uvm_agent;
        `uvm_component_utils(<$ name $>_master_agent)

        <$ name $>_master_driver drv;
        <$ name $>_master_monitor mon;
        <$ name $>_master_sequencer sqr;

        function new(string name = "<$ name $>_master_agent",uvm_component parent);
            super.new(name,parent);
        endfunction 

        virtual function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if(is_active == UVM_ACTIVE) begin
                sqr = <$ name $>_master_sequencer::type_id::create("sqr",this);
                drv = <$ name $>_master_driver::type_id::create("drv",this);
            end
            
            mon = <$ name $>_master_monitor::type_id::create("mon",this);
        endfunction 

        virtual function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            if(is_active == UVM_ACTIVE) begin
                drv.seq_item_port.connect(sqr.seq_item_export);
            end
        endfunction 
    endclass
`endif
