`ifndef <$ name $>_name_agent
`define <$ name $>_name_agent
    class <$ name $>_name_agent extends uvm_agent;
        `uvm_component_utils(<$ name $>_name_agent)

        <$ name $>_name_driver drv;
        <$ name $>_name_monitor mon;
        <$ name $>_name_sequencer sqr;

        function new(string name = "<$ name $>_name_agent",uvm_component parent);
            super.new(name,parent);
        endfunction 

        virtual function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if(is_active == UVM_ACTIVE) begin
                sqr = <$ name $>_name_sequencer::type_id::create("sqr",this);
                drv = <$ name $>_name_driver::type_id::create("drv",this);
            end
            
            mon = <$ name $>_name_monitor::type_id::create("mon",this);
        endfunction 

        virtual function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            if(is_active == UVM_ACTIVE) begin
                drv.seq_item_port.connect(sqr.seq_item_export);
            end
        endfunction 
    endclass
`endif
