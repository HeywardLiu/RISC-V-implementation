module ID_EX(
input 			clk_i,
input 			rst_i,
input        	MemtoReg_i,
input 			RegWrite_i,
input 			Branch_i, 
input			MemWrite_i,
input			MemRead_i,
input [32-1:0]	pc_i,
input [2-1:0]	ALUOp_i,
input 			ALUSrc_i,
input [32-1:0]  RSdata_i,
input [32-1:0]	RTdata_i,
input [32-1:0]	immd_i,
input [32-1:0]  instr_i,
output 	reg			RegWrite_o,
output  reg 		MemtoReg_o,
output 	reg			Branch_o,
output 	reg			MemWrite_o,
output 	reg			MemRead_o,
output  reg[32-1:0]	pc_o,
output 	reg[2-1:0]	ALUOp_o,
output	reg			ALUSrc_o,
output  reg[32-1:0] RSdata_o,
output  reg[32-1:0]	RTdata_o,
output  reg[32-1:0]	immd_o,
output  reg[32-1:0] instr_o
);

	always @(posedge clk_i) begin
		if(~rst_i) begin
			MemtoReg_o <= 0;
			RegWrite_o <= 0;
			Branch_o <= 0;
			MemWrite_o <= 0;
			MemRead_o <= 0;
			pc_o <= 0;
			ALUOp_o <= 0;
			ALUSrc_o <= 0;
			RSdata_o <= 0;
			RTdata_o <= 0;
			immd_o <= 0;
			instr_o <= 0;

		end
		else begin
			MemtoReg_o <= MemtoReg_i;
			RegWrite_o <= RegWrite_i;
			Branch_o <= Branch_i;
			MemWrite_o <= MemWrite_i;
			MemRead_o <= MemRead_i;
			pc_o <= pc_i;
			ALUOp_o <= ALUOp_i;
			ALUSrc_o <= ALUSrc_i;
			RSdata_o <= RSdata_i;
			RTdata_o <= RTdata_i;
			immd_o <= immd_i;
			instr_o <= instr_i;

		end
	end

endmodule