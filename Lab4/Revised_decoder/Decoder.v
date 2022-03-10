/***************************************************
Student Name:曾維浩
Student ID: 0511226
***************************************************/

`timescale 1ns/1ps

module Decoder(
	input [31:0] 	instr_i,
	output          ALUSrc,
	output          MemtoReg,
	output          RegWrite,
	output          MemRead,
	output          MemWrite,
	output          Branch,
	output [1:0]	ALUOp,
	output [1:0]	Jump
	);

wire	[7-1:0]		opcode;
wire 	[3-1:0]		funct3;
wire	[3-1:0]		Instr_field;
wire	[10-1:0]	Ctrl_o;

assign opcode = instr_i[6:0];
assign funct3 = instr_i[14:12];
	
/* Write your code HERE */
// 0:R-type, 1:I-type, 2:S-type, 3:B-type, 4:UJ-type, 5:error					 
assign Instr_field = (opcode==7'b1101111) ? 4:		//UJ-type(jal)
					 (opcode==7'b1100011) ? 3:		//B-type
					 (opcode==7'b0100011) ? 2:		//S-Type
					 (opcode==7'b0000011) ? 1:		//I-type(LW)
					 (opcode==7'b0010011) ? 1:		//I-type(arithmetic)
					 (opcode==7'b1100111) ? 1:		//I-type(jalr)
					 (opcode==7'b0110011) ? 0:		//R-type
											5;		//error			
					 
assign Ctrl_o = (Instr_field==0)					   ?10'b0000100010:( //R-type              ALUop=10
				(Instr_field==1 && opcode==7'b0000011) ?10'b0011110000:( //I-type(LW)          ALUop=00
				(Instr_field==1 && opcode==7'b1100111) ?10'b1000100000:( //I-type(jalr)	       -
				(Instr_field==1 && opcode==7'b0010011 
								&& funct3==3'b000)     ?10'b0010100000:( //I-type(addi)        ALUop=00
				(Instr_field==1)?10'b0010100010:(                        //I-type(arithmetic)  ALUop=10
				(Instr_field==2)?10'b0010001000:(                        //S-type(SW)	       ALUop=00
				(Instr_field==3)?10'b0000000101:(                        //B-type 	       ALUop=01
				(Instr_field==4)?10'b0100100000:(                        //UJ-type(jal)	       -
														0))))))));

assign Jump     = {Ctrl_o[9:8]};				
assign ALUSrc 	= Ctrl_o[7];
assign MemtoReg = Ctrl_o[6];
assign RegWrite = Ctrl_o[5];
assign MemRead  = Ctrl_o[4];
assign MemWrite = Ctrl_o[3];
assign Branch	= Ctrl_o[2];
assign ALUOp 	= {Ctrl_o[1:0]};


endmodule





                    
                    