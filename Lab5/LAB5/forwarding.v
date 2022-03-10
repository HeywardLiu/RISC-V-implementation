`timescale 1ns/1ps
module forwarding_unit(
	input [31:0] instr_IDEX,
	input [31:0] instr_EXMEM,
	input [31:0] instr_MEMWB,
	input        RegWrite_EXMEM,
	input        RegWrite_MEMWB,
	output reg [1:0] forwardA,
	output reg [1:0] forwardB
);

wire [4:0] rs1_IDEX = instr_IDEX[19:15];
wire [4:0] rs2_IDEX = instr_IDEX[24:20];

wire [4:0] rd_EXMEM = instr_EXMEM[11:7];
wire [4:0] rd_MEMWB = instr_MEMWB[11:7];

always @(*) begin
	forwardA = 2'b00;
	forwardB = 2'b00;
	if(RegWrite_EXMEM 
		&& (rd_EXMEM != 0) 
		&& (rd_EXMEM == rs1_IDEX))begin
			forwardA = 2'b10;
		end
	if(RegWrite_EXMEM 
		&& (rd_EXMEM != 0) 
		&& (rd_EXMEM == rs2_IDEX))begin
			forwardB = 2'b10;
		end
	if((RegWrite_MEMWB) 
		&& (rd_MEMWB != 0) 
		&& !((RegWrite_EXMEM) && (rd_EXMEM != 0) && (rd_EXMEM == rs1_IDEX))
		&& (rd_MEMWB == rs1_IDEX)
		)begin
			forwardA = 2'b01;
		end
	if(RegWrite_MEMWB 
		&& (rd_MEMWB != 0) 
		&& !((RegWrite_EXMEM) && (rd_EXMEM != 0) && (rd_EXMEM == rs2_IDEX))
		&& (rd_MEMWB == rs2_IDEX)
		)begin
			forwardB = 2'b01;
		end
end

endmodule

