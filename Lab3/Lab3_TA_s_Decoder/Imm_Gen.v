/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module Imm_Gen(
	input  [31:0] instr_i,
	output [31:0] Imm_Gen_o
	);

/* Write your code HERE */
reg [31:0] Imm_Gen;
wire Type;
integer i;
assign Type =( instr_i[6:0]==7'b0010011) ? 1 : 0; //I-type: opcode = 0010011 => Type=1 
					          //B-type: opcode = 1100011 => Type=0

always@(*)begin
  case (Type)
    0: begin //B-type
       Imm_Gen[3:0] = instr_i[11:8];  
       Imm_Gen[9:4] = instr_i[30:25];
       Imm_Gen[10]  = instr_i[7];
       Imm_Gen[11]  = instr_i[31];
       end
    1: begin //I-type
       Imm_Gen[11:0] = instr_i[31:20];
       end
  endcase
  for(i=12; i<32; i=i+1)
    if(instr_i[31]==0)
      Imm_Gen[i] = 0; //immd>0
    else
      Imm_Gen[i] = 1; //immd<0
end

assign Imm_Gen_o = Imm_Gen;

endmodule