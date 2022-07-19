`ifndef <$ name $>_agent
`define <$ name $>_agent
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
`endif
