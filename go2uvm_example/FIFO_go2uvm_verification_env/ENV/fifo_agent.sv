class fifo_agent extends uvm_agent;
  
  uvm_active_passive_enum is_active;
  
  fifo_sequencer fifo_sequencer1;
  fifo_driver fifo_driver1;
  fifo_monitor fifo_monitor1;
  fifo_scoreboard fifo_scoreboard1;
  fifo_fcov fifo_fcov1;
  
  virtual fifo_if if_1;
  
  `uvm_component_utils_begin(fifo_agent)
  `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
  `uvm_component_utils_end
   
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction : new
  
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
      
  
endclass : fifo_agent
    
    function void fifo_agent::build_phase(uvm_phase phase);
       
    super.build_phase(phase);
    if (!uvm_config_db#(uvm_active_passive_enum)::get(this,
    					    "",
    					    "is_active",
    					    is_active)) begin : def_val_for_is_active
             `uvm_warning(get_name,$sformatf("No override for is_active: Using default is_active as:%s",
                                         this.is_active.name));
       end : def_val_for_is_active
      
      
      `uvm_info(get_name(),$sformatf("is_active is set to %s",this.is_active.name),UVM_MEDIUM);   
      
      fifo_monitor1=fifo_monitor::type_id::create("fifo_monitor1",this);
      fifo_scoreboard1= fifo_scoreboard::type_id::create("fifo_scoreboard1",this);
      fifo_fcov1 = fifo_fcov::type_id::create("fifo_fcov1",this); 
      
      if(is_active== UVM_ACTIVE)
        begin
          fifo_sequencer1= fifo_sequencer::type_id::create("fifo_sequencer1",this);
          fifo_driver1= fifo_driver::type_id::create("fifo_driver1",this);
        end
      
    endfunction : build_phase
    
    
    
    function void fifo_agent::connect_phase(uvm_phase phase);

    if(!uvm_config_db#(virtual fifo_if)::get(this,
          				  "",
          				  "if_1",
          				  if_1))
       begin:no_vif
      	`uvm_fatal("get_interface","no virtual interface available");
       end:no_vif
     else
       begin:vi_assigned
               `uvm_info("get_interface",$sformatf("virtual interface connected"),UVM_HIGH)
               this.if_1 = if_1;
       end:vi_assigned

      
    fifo_monitor1.vif1 = this.if_1;

    if (is_active == UVM_ACTIVE)
      begin
        this.fifo_driver1.seq_item_port.connect(fifo_sequencer1.seq_item_export);
        this.fifo_driver1.fifo_vif = this.if_1;
      end

      this.fifo_monitor1.push_m_aport.connect(this.fifo_scoreboard1.push_m_fifo.analysis_export);
      this.fifo_monitor1.pop_m_aport.connect(this.fifo_scoreboard1.pop_m_fifo.analysis_export);
      this.fifo_monitor1.push_m_aport.connect(this.fifo_fcov1.analysis_export);
endfunction : connect_phase
