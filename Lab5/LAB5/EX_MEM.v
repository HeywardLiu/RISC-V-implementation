module EX_MEM(
	input 			    clk_i,
	input 			    rst_i,
	input        	    MemtoReg_i,
	input 			    RegWrite_i,
	input 			    Branch_i,
	input 				MemWrite_i,
	input 				MemRead_i,
	input   [32-1:0]	pc_i,
	input				zero_i,
	input   [32-1:0]	ALU_result_i,
	input   [32-1:0]	RTdata_i,
	input   [32-1:0]	instr_i,
	output  reg		    MemtoReg_o,
	output 	reg		    RegWrite_o,
	output 	reg		    Branch_o,
	output 	reg		    MemWrite_o,
	output 	reg		    MemRead_o,
	output  reg[32-1:0]	pc_o,
	output 	reg	    	zero_o,
	output  reg[32-1:0]	ALU_result_o,
	output  reg[32-1:0]	RTdata_o,
	output  reg[32-1:0]	instr_o
);
	always @(posedge clk_i) begin
		if(~rst_i) begin
			MemtoReg_o <= 0;
			RegWrite_o <= 0;
			Branch_o <= 0;
			MemWrite_o <= 0;
			MemRead_o <= 0;
			pc_o <= 0;
			zero_o <= 0;
			ALU_result_o <= 0;
			RTdata_o <= 0;
			instr_o <= 0;
		end
		else begin
			MemtoReg_o <= MemtoReg_i;
			RegWrite_o <= RegWrite_i;
			Branch_o <= Branch_i;
			MemWrite_o <= MemWrite_i;
			MemRead_o <= MemRead_i;
			pc_o <= pc_i;
			zero_o <= zero_i;
			ALU_result_o <= ALU_result_i;
			RTdata_o <= RTdata_i;
			instr_o <= instr_i;
		end
	end

endmodule