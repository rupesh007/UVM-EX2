import uvm_pkg::*;
import alu_pkg::*;
`include"uvm_macros.svh"

class alu_driver extends uvm_driver # (alu_transaction);
//declaration macros 
//this provides factory automation for the driver
//also enables methods for automatically for copy,compare,print,pack and unpack
`uvm_component_utils(alu_driver)
//virtual interface
virtual alu_if a_vif;
//alu_transaction request;
//alu_transaction req;
function new (string name, uvm_component parent); // new function constructor
super.new(name,parent);
endfunction: new

function void build_phase (uvm_phase phase); // build phase for uvm_component
	if (!uvm_config_db # (virtual alu_if)::get(this,"","top_alu",a_vif)) // reads through virtual interface
		`uvm_fatal("NOVIF",{"virtual interface must be set for:", get_full_name(),".vif"});
endfunction: build_phase

virtual task run_phase (uvm_phase phase); // run phase for UVM
phase.raise_objection(this, "run phase commenced"); // raise the objection for the task if busy
	seq4dut;
phase.drop_objection(this, "run phase dropped"); // drops the objection once the task is completed
endtask: run_phase

task seq4dut(); // task implementation
   repeat(10) begin 
      @(a_vif.drive); // sensitive to drive
      
     	seq_item_port.try_next_item (req); // tries the next //item possible, returns null if not
     	
      if(req==null)
       	 drive_idle();
      else begin
         drive_dut();
         seq_item_port.item_done();
      end
   end
endtask: seq4dut
//these processes do nothing but just prints report
task drive_idle();
  
  $display ("Process Driven to idle"); // just print the msg
  
endtask: drive_idle

task drive_dut();
  $display("%0d: Driving Instruction",$time); 
  // the signals being bound to the vritual interface
  a_vif.op_code = req.op_code;
  a_vif.shift_rotate = req.shift_rotate;
  a_vif.operand_1 = req.operand_1;
  a_vif.operand_2 = req.operand_2;
  
  $display("Driver @ %0t operand_1=%b operand_2=%b op_code=%b shift_rotate=%b",$time,req.operand_1, req.operand_2, req.op_code, req.shift_rotate);
  
  //$display ("Process Driven to dut-drive"); // just print the msg

endtask: drive_dut

/*task reset_dut();  
  $display ("Process Driven to reset"); // just print the msg
endtask: reset_dut*/

endclass: alu_driver