/***************************************************
Student Name: 曾維浩
Student ID: 0511226
***************************************************/

`timescale 1ns/1ps

module ALU_Ctrl(
	input		[3:0]	instr,
	input		[1:0]	ALUOp,
	output wire	[3:0] ALU_Ctrl_o
	);
	
/* Write your code HERE */
assign ALU_Ctrl_o = (ALUOp==2'b00)                   ? 4'b0010 : //load/store -> ALU = add
		   ((ALUOp==2'b01) && (instr[2:0]==3'b000))  ? 4'b0110 : //beq     -> ALU = sub
		   ((ALUOp==2'b01) && (instr[2:0]==3'b001))  ? 4'b0011 : //bne
		   ((ALUOp==2'b01) && (instr[2:0]==3'b100))  ? 4'b0100 : //blt
		   ((ALUOp==2'b01) && (instr[2:0]==3'b101))  ? 4'b0101 : //bge
		   ((ALUOp==2'b10) && (instr==4'b1000))     ? 4'b0110 : //ALU = -
		   ((ALUOp==2'b10) && (instr[2:0]==3'b000)) ? 4'b0010 : //ALU = + 
		   ((ALUOp==2'b10) && (instr[2:0]==3'b111)) ? 4'b0000 : //ALU = and
		   ((ALUOp==2'b10) && (instr[2:0]==3'b110)) ? 4'b0001 : //ALU = or
		   ((ALUOp==2'b10) && (instr[2:0]==3'b010)) ? 4'b0111 : //ALU = SLT
		   ((ALUOp==2'b10) && (instr[2:0]==3'b001)) ? 4'b1111 : //ALU = shift left logical (sll)
		   ((ALUOp==2'b10) && (instr[2:0]==3'b100)) ? 4'b1110 : //ALU = xor
		   ((ALUOp==2'b10) && (instr[2:0]==3'b101)) ? 4'b1001 : //ALU = shift right arithmetic (sra)
													  4'b0011;  //ALU = Error detect

 
endmodule