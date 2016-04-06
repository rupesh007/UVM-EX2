module top;

import uvm_pkg::*;
import alu_pkg::*;

bit tclk,treset;

initial begin
    #20;
    forever begin
      #(10) tclk=~tclk;
   end
end
   

//hardware instatntiations
alu_driver driver;
alu_if alu_interface(tclk);
alu_env env;
//alu_sequence sequences;
//alu_transaction transaction;
//alu_sequencer sequencer1;
// binds DUT and interface
alu8 alu_dut(.clk(tclk),
             .reset(treset),
             .op_code(alu_interface.op_code),
             .operand_1(alu_interface.operand_1),
             .operand_2(alu_interface.operand_2),
             .shift_rotate(alu_interface.shift_rotate),
             .result(alu_interface.result),
             .carry(alu_interface.carry));


initial begin 
	env=new ("alu_environmet"); // creates new environment
	uvm_config_db # (virtual alu_if)::set(null,"*","top_alu",alu_interface); //sets a reference to virtual //interface using config;this can be done using package also
	run_test(); // this starts the test
	tclk=0;
end 

endmodule: top