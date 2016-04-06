import uvm_pkg::*;
import alu_pkg::*;
`include"uvm_macros.svh"

class alu_env extends uvm_env;
// declaration macros
  `uvm_component_utils (alu_env)
//internal components
   alu_driver m_driver;
   alu_sequencer m_sequencer;
   alu_sequence seq;

   function new (string name, uvm_component parent = null); // parent is //null because uvm_env is top level component
	   super.new(name,parent);
   endfunction: new

   function void build_phase (uvm_phase phase);	
	   super.build_phase(phase);
	   m_driver = alu_driver::type_id::create ("m_driver", this);//creates //m_driver with factory
	   m_sequencer= alu_sequencer::type_id::create("m_sequencer", this); //creates m_sequencer with factory
   endfunction: build_phase

//connect phase in uvm to connect driver and sequncer
   function void connect_phase (uvm_phase phase);
    	m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
   endfunction: connect_phase

// at end_of_elaboration, print topology 
   virtual function void end_of_elaboration_phase(uvm_phase phase);
     uvm_top.print_topology();
   endfunction

   task run_phase (uvm_phase phase);
	   seq = alu_sequence::type_id::create("seq"); //creates seq with //factory
	   phase.raise_objection(this);
	   seq.start(m_sequencer);  
	   phase.drop_objection(this);
   endtask

endclass: alu_env
