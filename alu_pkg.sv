package alu_pkg;

//standard UVM import & include

import uvm_pkg::*;
`include "uvm_macros.svh"
//includes drivers and environment 
//check what is mandatory to include or import
`include "transaction_item.sv"
`include "alu_driver.sv"
`include "alu_sequence.sv"
`include "alu_sequencer.sv"
`include "alu_env.sv"

endpackage: alu_pkg
