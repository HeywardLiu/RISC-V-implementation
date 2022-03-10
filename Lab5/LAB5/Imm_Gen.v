/***************************************************
Student Name: 曾維浩
Student ID: 0511226
***************************************************/

`timescale 1ns/1ps

module Imm_Gen(
	input  [31:0] instr_i,
	output [31:0] Imm_Gen_o
	);

/* Write your code HERE */
reg [31:0] Imm_Gen;
wire [1:0] Type;
integer i;
assign Type = (instr_i[6:0]==7'b0100011)? 2'b11 :  //S-type(SW)	       =>Type=3
	      (instr_i[6:0]==7'b1101111)    ? 2'b10 :  //UJ-type(JAL)      =>Type=2
	      ((instr_i[6:0]==7'b0010011) ||           //I-type(arithmetic)=>Type=1
	       (instr_i[6:0]==7'b0000011) ||	       //I-type(LW)	       =>Type=1
	       (instr_i[6:0]==7'b1100111))  ? 2'b01 :  //I-type(JALR)      =>Type=1    
				                          2'b00 ;  //B-type(1100011)   =>Type=0

always@(*)begin
  case (Type)
    0: begin //B-type
       Imm_Gen[3:0] = instr_i[11:8];  
       Imm_Gen[9:4] = instr_i[30:25];
       Imm_Gen[10]  = instr_i[7];
       Imm_Gen[11]  = instr_i[31];
       end
    1: begin //I-type, JALR, LW
       Imm_Gen[11:0] = instr_i[31:20];
       end
    2: begin  //JAL
       Imm_Gen[9:0]   = instr_i[30:21];
       Imm_Gen[10]    = instr_i[20];
       Imm_Gen[18:11] = instr_i[19:12];
       Imm_Gen[19]    = instr_i[31];
       end
    3: begin  //S-type
	   Imm_Gen[4:0]   = instr_i[11:7];
       Imm_Gen[11:5]  = instr_i[31:25];
       end
  endcase
  if(Type==0 || Type==1 || Type==3) //B-type, I-type, S-type
	for(i=12; i<32; i=i+1)
		if(instr_i[31]==0)
			Imm_Gen[i] = 0; //immd>0
		else
			Imm_Gen[i] = 1; //immd<0

  else				                //UJ-type(JAL)
	for(i=20; i<32; i=i+1)
		if(instr_i[31]==0)
			Imm_Gen[i] = 0; //immd>0
		else
			Imm_Gen[i] = 1; //immd<0	
end

assign Imm_Gen_o = Imm_Gen;

endmodule