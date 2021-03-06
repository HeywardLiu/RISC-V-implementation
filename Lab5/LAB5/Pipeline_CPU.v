/***************************************************
Student Name: 曾維浩
Student ID: 0511226
***************************************************/

`timescale 1ns/1ps
module Pipeline_CPU(
	input clk_i,
	input rst_i
	);
// Data Path //
wire [31:0] pc_i;
wire [31:0] pc_o, pc_ID, pc_EX, pc_MEM;
wire [31:0] pc_4, pc_Branch;

wire [31:0] instr_IF, instr_ID, instr_EX, instr_MEM, instr_WB;

wire [31:0] immd_ID, immd_EX;
wire [31:0] RSdata, RSdata_ID, RSdata_EX;
wire [31:0] RTdata, RTdata_ID, RTdata_EX, RTdata_MEM;
wire [31:0] RDdata;

wire [31:0] ALUresult_EX, ALUresult_MEM, ALUresult_WB;
wire [31:0] ReadData_MEM, ReadData_WB;

wire [31:0] Mux_0;

// Control Siganls //
wire MemtoReg_ID, MemtoReg_EX, MemtoReg_MEM, MemtoReg_WB;
wire RegWrite_ID, RegWrite_EX, RegWrite_MEM, RegWrite_WB;
wire Branch_ID, Branch_EX, Branch_MEM;
wire MemRead_ID, MemRead_EX, MemRead_MEM;
wire MemWrite_ID, MemWrite_EX, MemWrite_MEM;
wire ALUSrc_ID, ALUSrc_EX;
wire [1:0] ALUOp_ID, ALUOp_EX;
wire Zero_EX, Zero_MEM;
wire Cout;
wire Overflow;
wire PCSrc;

wire [1:0] Jump;
wire [31:0] SL1_o;
wire [31:0] ALU_Src1, ALU_Src2;
wire [3:0] ALU_Ctrl_o, ALU_Ctrl_i;

wire [1:0] forwardA, forwardB;
wire RS_select, RT_select;
// IF-stage //

MUX_2to1 Mux_PCSrc(
		.data0_i(pc_4),       
		.data1_i(pc_MEM),
		.select_i(PCSrc),
		.data_o(pc_i)
		);

ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_i(pc_i) ,   
	    .pc_o(pc_o) 
	    );

Adder Adder_pc4(
        .src1_i(pc_o),     
	    .src2_i(32'h00000004),     
	    .sum_o(pc_4)
	    );

Instr_Memory IM(
        .addr_i(pc_o),  
	    .instr_o(instr_IF)    
	    );		
		
// IF/ID Pipeline-Register //

IF_ID IFID(
		.clk_i(clk_i),
		.rst_i(rst_i), 
		.pc_i(pc_o), 
		.instr_i(instr_IF), 
		.pc_o(pc_ID), 
		.instr_o(instr_ID) 
		);
		
// ID-stage //

assign RS_select = (instr_WB[11:7]==instr_ID[19:15]) ? 1 : 0;

assign RT_select = (instr_WB[11:7]==instr_ID[24:20]) ? 1 : 0;

MUX_2to1 WB_forward_RS(
		.data0_i(RSdata),       
		.data1_i(RDdata),
		.select_i(RS_select),
		.data_o(RSdata_ID)
		);
		
MUX_2to1 WB_forward_RT(
		.data0_i(RTdata),       
		.data1_i(RDdata),
		.select_i(RT_select),
		.data_o(RTdata_ID)
		);
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instr_ID[19:15]) ,  
        .RTaddr_i(instr_ID[24:20]) ,  
        .RDaddr_i(instr_WB[11:7]) ,  
        .RDdata_i(RDdata)  , 
        .RegWrite_i (RegWrite_WB),
        .RSdata_o(RSdata) ,  
        .RTdata_o(RTdata)   
        );		
		
Imm_Gen ImmGen(
		.instr_i(instr_ID[31:0]),
		.Imm_Gen_o(immd_ID)
		);
		
Decoder Decoder(
        .instr_i(instr_ID), 
		.ALUSrc(ALUSrc_ID),
		.MemtoReg(MemtoReg_ID),
	    .RegWrite(RegWrite_ID),
		.MemRead(MemRead_ID),
		.MemWrite(MemWrite_ID),
	    .Branch(Branch_ID),
		.ALUOp(ALUOp_ID)
	    );
		
// ID/EX Pipeline-Register //

ID_EX IDEX(
		.clk_i(clk_i), 
		.rst_i(rst_i), 
		.RegWrite_i(RegWrite_ID),
		.MemtoReg_i(MemtoReg_ID),			
		.Branch_i(Branch_ID),
		.MemRead_i(MemRead_ID),  
		.MemWrite_i(MemWrite_ID), 
		.ALUOp_i(ALUOp_ID), 
		.ALUSrc_i(ALUSrc_ID), 
		.pc_i(pc_ID), 
		.RSdata_i(RSdata_ID),
		.RTdata_i(RTdata_ID), 
		.immd_i(immd_ID), 
		.instr_i(instr_ID),
		.RegWrite_o(RegWrite_EX),
		.MemtoReg_o(MemtoReg_EX),
		.Branch_o(Branch_EX), 
		.MemRead_o(MemRead_EX), 
		.MemWrite_o(MemWrite_EX), 
		.ALUOp_o(ALUOp_EX), 
		.ALUSrc_o(ALUSrc_EX), 
		.pc_o(pc_EX), 
		.RSdata_o(RSdata_EX), 
		.RTdata_o(RTdata_EX), 
		.immd_o(immd_EX), 
		.instr_o(instr_EX)
		);
	
// EX-stage //

forwarding_unit FU(
	.instr_IDEX(instr_EX),
	.instr_EXMEM(instr_MEM),
	.instr_MEMWB(instr_WB),
	.RegWrite_EXMEM(RegWrite_MEM),
	.RegWrite_MEMWB(RegWrite_WB),
	.forwardA(forwardA),
	.forwardB(forwardB)
);

MUX_3to1 Mux_ALU_Src1(
	.data0_i(RSdata_EX),       
	.data1_i(RDdata),
	.data2_i(ALUresult_MEM),
	.select_i(forwardA),
	.data_o(ALU_Src1)
    );

MUX_3to1 Mux_ALU_Src2(
	.data0_i(Mux_0),       
	.data1_i(RDdata),
	.data2_i(ALUresult_MEM),
	.select_i(forwardB),
	.data_o(ALU_Src2)
    );

MUX_2to1 Mux_RT_imd(
		.data0_i(RTdata_EX),       
		.data1_i(immd_EX),
		.select_i(ALUSrc_EX),
		.data_o(Mux_0)
		);	
		
Adder Adder_pcBranch(
        .src1_i(pc_EX),     
	    .src2_i(SL1_o),     
	    .sum_o(pc_MEM)    
	    );

Shift_Left_1 SL1(
		.data_i(immd_EX),
		.data_o(SL1_o)
		);

alu alu(
		.rst_n(rst_i),
		.src1(ALU_Src1),
		.src2(ALU_Src2),
		.ALU_control(ALU_Ctrl_o),
		.zero(Zero_EX),
		.result(ALUresult_EX),
		.cout(Cout),
		.overflow(Overflow)
		);

assign ALU_Ctrl_i[3] = instr_EX[30];
assign ALU_Ctrl_i[2:0] = instr_EX[14:12];

ALU_Ctrl ALU_Ctrl(
		.instr(ALU_Ctrl_i),
		.ALUOp(ALUOp_EX),
		.ALU_Ctrl_o(ALU_Ctrl_o)
		);
		
// EX/MEM Pipeline-Register //

EX_MEM EXMEM(
		.clk_i(clk_i),
		.rst_i(rst_i),
		.MemtoReg_i(MemtoReg_EX),
		.RegWrite_i(RegWrite_EX),
		.Branch_i(Branch_EX),
		.MemWrite_i(MemWrite_EX),
		.MemRead_i(MemRead_EX),
		.pc_i(pc_Branch),
		.zero_i(zero_EX),
		.ALU_result_i(ALUresult_EX),
		.RTdata_i(RTdata_EX),
		.instr_i(instr_EX),
		.MemtoReg_o(MemtoReg_MEM),
		.RegWrite_o(RegWrite_MEM),
		.Branch_o(Branch_MEM),
		.MemWrite_o(MemWrite_MEM),
		.MemRead_o(MemRead_MEM),
		.pc_o(pc_MEM),
		.zero_o(zero_MEM),
		.ALU_result_o(ALUresult_MEM),
		.RTdata_o(RTdata_MEM),
		.instr_o(instr_MEM)
);

// MEM-stage //

and Beq_AND(PCSrc, Branch_MEM, Zero_MEM);

Data_Memory Data_Memory(
		.clk_i(clk_i),
		.addr_i(ALUresult_MEM),
		.data_i(RTdata_MEM),
		.MemRead_i(MemRead_MEM),
		.MemWrite_i(MemWrite_MEM),
		.data_o(ReadData_MEM)
		);

// MEM/WB Pipeline-Register //

MEM_WB MEMWB(
		.clk_i(clk_i),
		.rst_i(rst_i),
		.RegWrite_i(RegWrite_MEM),
       	.MemtoReg_i(MemtoReg_MEM),
		.ReadData_i(ReadData_MEM),
		.ALU_result_i(ALUresult_MEM),
		.instr_i(instr_MEM),
		.RegWrite_o(RegWrite_WB),
	   	.MemtoReg_o(MemtoReg_WB),
		.ReadData_o(ReadData_WB),
		.ALU_result_o(ALUresult_WB),
		.instr_o(instr_WB)
);

// WB-stage //

MUX_2to1 Mux_MemtoReg(
		.data0_i(ALUresult_WB),       
		.data1_i(ReadData_WB),
		.select_i(MemtoReg_WB),
		.data_o(RDdata)
		);

//

		



endmodule
		  


