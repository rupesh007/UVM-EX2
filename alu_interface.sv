interface alu_if(input clk);
	//logic clk; 
	//logic reset; 
	logic [3:0] op_code ;	
	logic [7:0] operand_1 ; 
	logic [7:0] operand_2 ;
	logic [2:0] shift_rotate ;
	logic [7:0] result ; 
	logic carry;
	
	//clocking drive @ (negedge clk); // just wanted to see what difference it makes
	clocking drive @ (posedge clk);
	  output op_code;
	  output operand_1;
	  output operand_2;
	  output shift_rotate;
	  input result;
	  input carry;
	endclocking
	
	//modport alu8(); // this is the DUT
	//modport alu_top()); // this is the top module
	
					
endinterface: alu_if
