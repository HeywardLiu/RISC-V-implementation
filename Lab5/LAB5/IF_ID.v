module IF_ID(
	input 			    clk_i,
	input 			    rst_i,
	input     [32-1:0]	pc_i,
	input     [32-1:0]	instr_i,
	output reg[32-1:0]	pc_o,
	output reg[32-1:0]	instr_o
);

always @(posedge clk_i) begin
	if(~rst_i) begin
		pc_o <= 0;
		instr_o <= 0;
	end
	else begin
		pc_o <= pc_i;
		instr_o <= instr_i;
	end
end

endmodule