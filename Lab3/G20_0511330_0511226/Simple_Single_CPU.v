/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps
module Simple_Single_CPU(
	input clk_i,
	input rst_i
	);

//Internal Signles
wire [31:0] pc_i;
wire [31:0] pc_o;
wire [31:0] pc_4;
wire [31:0] instr;
wire [31:0] ALUresult;
wire RegWrite;
wire [31:0] RSdata_o;
wire [31:0] RTdata_o;
wire ALUSrc;
wire Branch;
wire PCSrc;
wire [1:0] ALUOp;
wire [31:0] Imm_o;
wire [31:0] SL1_o;
wire [31:0] Adder2_o;
wire [31:0] ALU_Src2;
wire [3:0] ALU_Ctrl_o;
wire [3:0] ALU_Ctrl_i;
wire Zero;
wire Cout;
wire Overflow;

assign ALU_Ctrl_i[3] = instr[30];
assign ALU_Ctrl_i[2:0] = instr[14:12];
and Beq_AND(PCSrc, Branch, Zero);

ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_i(pc_i) ,   
	    .pc_o(pc_o) 
	    );

Instr_Memory IM(
        .addr_i(pc_o),  
	    .instr_o(instr)    
	    );
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instr[19:15]) ,  
        .RTaddr_i(instr[24:20]) ,  
        .RDaddr_i(instr[11:7]) ,  
        .RDdata_i(ALUresult)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(RSdata_o) ,  //rs1
        .RTdata_o(RTdata_o)    //rs2  
        );
		
Decoder Decoder(
        .instr_i(instr), 
		.ALUSrc(ALUSrc),
	    .RegWrite(RegWrite),
	    .Branch(Branch),
		.ALUOp(ALUOp)      
	    );	

Adder Adder1(
            .src1_i(pc_o),     
	    .src2_i(32'h00000004),     
	    .sum_o(pc_4)    
	    );
		
Imm_Gen ImmGen(
		.instr_i(instr[31:0]),
		.Imm_Gen_o(Imm_o)
		);
	
Shift_Left_1 SL1(
		.data_i(Imm_o),
		.data_o(SL1_o)
		);
	
MUX_2to1 Mux_ALUSrc(
		.data0_i(RTdata_o),       
		.data1_i(Imm_o),
		.select_i(ALUSrc),
		.data_o(ALU_Src2)
		);
			
ALU_Ctrl ALU_Ctrl(
		.instr(ALU_Ctrl_i),
		.ALUOp(ALUOp),
		.ALU_Ctrl_o(ALU_Ctrl_o)
		);
		
Adder Adder2(
            .src1_i(pc_o),     
	    .src2_i(SL1_o),     
	    .sum_o(Adder2_o)    
	    );
		
alu alu(
		.rst_n(rst_i),
		.src1(RSdata_o),
		.src2(ALU_Src2),
		.ALU_control(ALU_Ctrl_o),
		.zero(Zero),
		.result(ALUresult),
		.cout(Cout),
		.overflow(Overflow)
		);
	
MUX_2to1 Mux_PCSrc(
		.data0_i(pc_4),       
		.data1_i(Adder2_o),
		.select_i(PCSrc),
		.data_o(pc_i)
		);


endmodule
		  


