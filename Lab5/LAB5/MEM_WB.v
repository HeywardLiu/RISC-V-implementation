module MEM_WB(
	input 			clk_i,
	input 			rst_i,
	input 			RegWrite_i, 
	input       	MemtoReg_i,
	input [32-1:0]	ReadData_i,
	input [32-1:0]  ALU_result_i,
	input [32-1:0]  instr_i,
	output reg			RegWrite_o, 
	output reg      	MemtoReg_o,
	output reg[32-1:0]	ReadData_o,
	output reg[32-1:0]  ALU_result_o,
	output reg[32-1:0]  instr_o
);

always @(posedge clk_i) begin
	if(~rst_i) begin
		RegWrite_o <= 0;
		MemtoReg_o <= 0;
		ReadData_o <= 0;
		ALU_result_o <= 0;
		instr_o <= 0;
	end
	else begin
		RegWrite_o <= RegWrite_i;
		MemtoReg_o <= MemtoReg_i;
		ReadData_o <= ReadData_i;
		ALU_result_o <= ALU_result_i;
		instr_o <= instr_i;
	end
end

endmodule