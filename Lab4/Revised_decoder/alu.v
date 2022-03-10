/***************************************************
Student Name:曾維浩
Student ID:0511226
***************************************************/
`timescale 1ns/1ps

module alu(
	input	       rst_n,         // Reset                     (input)
	input	[31:0] src1,          // 32 bits source 1          (input)
	input	[31:0] src2,          // 32 bits source 2          (input)
	input 	[ 3:0] ALU_control,   // 4 bits ALU control input  (input)
	output reg[31:0] result,        // 32 bits result            (output)
	output reg       zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg       cout,          // 1 bit carry out           (output)
	output reg       overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */
always@(*)begin
  case (ALU_control)
    4'b0000: begin result = src1 & src2; end  //1h'0, and

    4'b0001: begin result = src1 | src2; end  //1h'1, or

    4'b0010: begin  result = src1 + src2; end //1'h2, add

    4'b0011: begin  result = (src1 != src2) ? 1 : 0; end //bne
	
    4'b0100: begin  result = (src1 < src2) ? 1 : 0; end //blt
	
    4'b0101: begin  result = (src1 >= src2) ? 1 : 0; end //bge

    4'b0110: begin  result = src1 - src2; end  //1'h6, sub, beq

    4'b0111: begin  result = (src1 < src2) ? 1 : 0; end //1'h7, SLT

    4'b1100: begin  result = ~src1 & ~src2; end  //1'hc, NOR 

    4'b1101: begin  result = ~src1 | ~src2; end  //1'hd, NAND

    4'b1110: begin  result = src1 ^ src2; end   //1'he,  XOR

    4'b1111: begin  result = src1 << src2; end  //1'hf,  shift left n-bit

    4'b1001: begin  result = src1 >>> src2; end //1'h9,  shift right arithmetic
    
    default: begin  result = 32'b0; end
  endcase
end

always@ (*)begin
  if(result==0)
	if(ALU_control==4'b0011) zero = 0; //bne
	else if(ALU_control==4'b0100) zero = 0;  //blt
	else if(ALU_control==4'b0101) zero = 0;  //bge
	else zero = 1;
  else 
	if(ALU_control==4'b0011) zero = 1; //bne
	else if(ALU_control==4'b0100) zero = 1;  //blt
	else if(ALU_control==4'b0101) zero = 1;  //bge
	else zero = 0;

  case (ALU_control)
    4'b0010: begin //add 
      if(src1[31]==0 && src2[31]==0 && result[31]==1) overflow = 1;
      else if(src1[31]==1 && src2[31]==1 &&result[31]==0) overflow = 1;
      else overflow = 0;
      end

    4'b0110: begin //sub
      if(src1[31]==0 && src2[31]==1 && result[31]==1) overflow = 1;
      else if(src1[31]==1 && src2[31]==0 && result[31]==0) overflow = 1;
      else overflow = 0; 
      end

    default: begin overflow = 0; end
  endcase
end



endmodule
