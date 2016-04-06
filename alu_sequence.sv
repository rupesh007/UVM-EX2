import uvm_pkg::*;
import alu_pkg::*;
`include"uvm_macros.svh"

class alu_sequence extends uvm_sequence #(alu_transaction);
  `uvm_object_utils(alu_sequence) // registers with factory

  function new (string name="alu_operation"); // new function constructor
   	super.new(name);
  endfunction
 
 task body();
   alu_transaction req;
   // prevents the test from finishing while the sequence is in progress
   uvm_test_done.raise_objection(this);
   repeat(10) begin
  	req = alu_transaction::type_id::create ("req"); //creates transaction with factory   	 	
 	 start_item(req); //blocks untill driver accesses transaction 	  	
 	 assert(req.randomize()); //randomizes the new values to variables in req object 
 	 $display ("Following Set of Sequence item will be: operand_1=%b operand_2=%b op_code=%b shift_rotate=%b",req.operand_1, req.operand_2, req.op_code, req.shift_rotate);	 
 	 finish_item(req);  //blocks untill driver has completed operation for current transaction
   //get_response is optional
   
 end
 uvm_test_done.drop_objection(this);
 endtask
 endclass: alu_sequence