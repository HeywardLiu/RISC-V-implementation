/***************************************************
Student Name: ???
Student ID:   0511330
***************************************************/
`timescale 1ns/1ps

module ALU_1bit(
	input				src1,       //1 bit source 1  (input)
	input				src2,       //1 bit source 2  (input)
	input 				Ainvert,    //1 bit A_invert  (input)
	input				Binvert,    //1 bit B_invert  (input)
	input				Cin,        //1 bit carry in  (input)
	input 	    [2-1:0] operation,  //2 bit operation (input)
	output reg          result,     //1 bit result    (output)
	output reg          cout        //1 bit carry out (output)
	);	

/* Write your code HERE */

wire ca, cb;
assign ca = src1 ^ Ainvert;
assign cb = src2 ^ Binvert;

wire And, Or, Sum, cout_wire;
and A1(And, ca, cb);
or O1(Or, ca, cb);

Full_Adder F1(.Sum(Sum), .CarryOut(cout_wire), .Input1(ca), .Input2(cb), .CarryIn(Cin));

always @* begin
  case(operation)
    2'b00: result = And;  
    2'b01: result = Or;  
    2'b10: result = Sum;  
    2'b11: result = Sum;  
  endcase

  cout <= cout_wire;
end

endmodule
