class fifo_driver extends uvm_driver #(fifo_seq_item);
  
  virtual fifo_if fifo_vif;
  fifo_seq_item item;
  
 function new(string name, uvm_component parent);
  super.new(name, parent);
 endfunction 
  
  `uvm_component_utils_begin(fifo_driver)
  `uvm_field_object(item, UVM_ALL_ON)
 `uvm_component_utils_end
  
 extern virtual task reset_phase(uvm_phase phase);
 extern virtual task main_phase(uvm_phase phase);
 extern virtual task fifo_main(input fifo_seq_item item);
 extern virtual task fifo_reset(input [3:0] no_of_rst);     
 extern virtual task fifo_push(input [DATA_WIDTH-1:0] data);
 extern virtual task fifo_pop(); 
  
  
endclass : fifo_driver
   
   task fifo_driver::reset_phase(uvm_phase phase);
          
          `uvm_info(get_name(),"Reset_phase is running... \n ",UVM_HIGH)
           begin
           phase.raise_objection(this);
           this.fifo_reset(5);
           phase.drop_objection(this);
           end
   endtask : reset_phase 
   
   
   task fifo_driver::main_phase(uvm_phase phase);
           
           `uvm_info(get_name(),"Main_phase is running...\n ",UVM_HIGH);
           forever 
             begin
               seq_item_port.get_next_item(this.item);
               `uvm_info(get_name(),$sformatf(" Item recieved : \n %s", item.sprint()), UVM_HIGH)
             phase.raise_objection(this);
               this.fifo_main(this.item);
                seq_item_port.item_done();
             phase.drop_objection(this);
             end
     
   endtask :main_phase 
   
   
   task fifo_driver::fifo_reset(input [3:0] no_of_rst);
     begin
       @(this.fifo_vif.driver_cb);
         this.fifo_vif.driver_cb.rst<=1'b0;
         this.fifo_vif.driver_cb.push<=1'b0;
         this.fifo_vif.driver_cb.pop<=1'b0;
         this.fifo_vif.driver_cb.data_in<='b0;
         repeat(no_of_rst) @(this.fifo_vif.driver_cb);
         this.fifo_vif.driver_cb.rst<=1'b1;
         repeat(2) @(this.fifo_vif.driver_cb);
     end
   endtask : fifo_reset
   
   task fifo_driver::fifo_push(input [DATA_WIDTH-1:0] data);
     begin
       @(this.fifo_vif.driver_cb);
         this.fifo_vif.driver_cb.push<=1'b1;
         this.fifo_vif.driver_cb.data_in<=data;
       @(this.fifo_vif.driver_cb);
         this.fifo_vif.driver_cb.push<=1'b0;
     end
   endtask : fifo_push
     
     task fifo_driver::fifo_pop();
     begin
       @(this.fifo_vif.driver_cb);
         this.fifo_vif.driver_cb.pop<=1'b1;
       @(this.fifo_vif.driver_cb);
         this.fifo_vif.driver_cb.pop<=1'b0;
     end
     endtask : fifo_pop
     
   task fifo_driver::fifo_main(input fifo_seq_item item);  
     case(item.kind)
       POP : this.fifo_pop();
       PUSH : this.fifo_push(item.wr_data);
       RST : this.fifo_reset(item.no_of_rst);
     endcase
     
   endtask : fifo_main
   
   
   
