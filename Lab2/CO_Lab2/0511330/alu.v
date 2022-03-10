/***************************************************
Student Name:  ???
Student ID:    0511330
***************************************************/
`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input	     [32-1:0]	src1,          // 32 bits source 1          (input)
	input	     [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */
wire	CarryOut_wire[31:0];
wire	result_wire[31:0];
integer i;

/* module  ALU_1bit (src1, scr2, Ainvert, Binvert, Cin, operation, result, cout) */
ALU_1bit A0(.src1(src1[0]), .src2(src2[0]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(ALU_control[2]), .operation(ALU_control[1:0]), .result(result_wire[0]), .cout(CarryOut_wire[0]));
ALU_1bit A1(.src1(src1[1]), .src2(src2[1]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[0]), .operation(ALU_control[1:0]), .result(result_wire[1]), .cout(CarryOut_wire[1]));
ALU_1bit A2(.src1(src1[2]), .src2(src2[2]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[1]), .operation(ALU_control[1:0]), .result(result_wire[2]), .cout(CarryOut_wire[2]));
ALU_1bit A3(.src1(src1[3]), .src2(src2[3]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[2]), .operation(ALU_control[1:0]), .result(result_wire[3]), .cout(CarryOut_wire[3]));
ALU_1bit A4(.src1(src1[4]), .src2(src2[4]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[3]), .operation(ALU_control[1:0]), .result(result_wire[4]), .cout(CarryOut_wire[4]));
ALU_1bit A5(.src1(src1[5]), .src2(src2[5]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[4]), .operation(ALU_control[1:0]), .result(result_wire[5]), .cout(CarryOut_wire[5]));
ALU_1bit A6(.src1(src1[6]), .src2(src2[6]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[5]), .operation(ALU_control[1:0]), .result(result_wire[6]), .cout(CarryOut_wire[6]));
ALU_1bit A7(.src1(src1[7]), .src2(src2[7]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[6]), .operation(ALU_control[1:0]), .result(result_wire[7]), .cout(CarryOut_wire[7]));
ALU_1bit A8(.src1(src1[8]), .src2(src2[8]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[7]), .operation(ALU_control[1:0]), .result(result_wire[8]), .cout(CarryOut_wire[8]));
ALU_1bit A9(.src1(src1[9]), .src2(src2[9]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[8]), .operation(ALU_control[1:0]), .result(result_wire[9]), .cout(CarryOut_wire[9]));
ALU_1bit A10(.src1(src1[10]), .src2(src2[10]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[9]), .operation(ALU_control[1:0]), .result(result_wire[10]), .cout(CarryOut_wire[10]));
ALU_1bit A11(.src1(src1[11]), .src2(src2[11]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[10]), .operation(ALU_control[1:0]), .result(result_wire[11]), .cout(CarryOut_wire[11]));
ALU_1bit A12(.src1(src1[12]), .src2(src2[12]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[11]), .operation(ALU_control[1:0]), .result(result_wire[12]), .cout(CarryOut_wire[12]));
ALU_1bit A13(.src1(src1[13]), .src2(src2[13]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[12]), .operation(ALU_control[1:0]), .result(result_wire[13]), .cout(CarryOut_wire[13]));
ALU_1bit A14(.src1(src1[14]), .src2(src2[14]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[13]), .operation(ALU_control[1:0]), .result(result_wire[14]), .cout(CarryOut_wire[14]));
ALU_1bit A15(.src1(src1[15]), .src2(src2[15]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[14]), .operation(ALU_control[1:0]), .result(result_wire[15]), .cout(CarryOut_wire[15]));
ALU_1bit A16(.src1(src1[16]), .src2(src2[16]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[15]), .operation(ALU_control[1:0]), .result(result_wire[16]), .cout(CarryOut_wire[16]));
ALU_1bit A17(.src1(src1[17]), .src2(src2[17]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[16]), .operation(ALU_control[1:0]), .result(result_wire[17]), .cout(CarryOut_wire[17]));
ALU_1bit A18(.src1(src1[18]), .src2(src2[18]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[17]), .operation(ALU_control[1:0]), .result(result_wire[18]), .cout(CarryOut_wire[18]));
ALU_1bit A19(.src1(src1[19]), .src2(src2[19]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[18]), .operation(ALU_control[1:0]), .result(result_wire[19]), .cout(CarryOut_wire[19]));
ALU_1bit A20(.src1(src1[20]), .src2(src2[20]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[19]), .operation(ALU_control[1:0]), .result(result_wire[20]), .cout(CarryOut_wire[20]));
ALU_1bit A21(.src1(src1[21]), .src2(src2[21]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[20]), .operation(ALU_control[1:0]), .result(result_wire[21]), .cout(CarryOut_wire[21]));
ALU_1bit A22(.src1(src1[22]), .src2(src2[22]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[21]), .operation(ALU_control[1:0]), .result(result_wire[22]), .cout(CarryOut_wire[22]));
ALU_1bit A23(.src1(src1[23]), .src2(src2[23]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[22]), .operation(ALU_control[1:0]), .result(result_wire[23]), .cout(CarryOut_wire[23]));
ALU_1bit A24(.src1(src1[24]), .src2(src2[24]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[23]), .operation(ALU_control[1:0]), .result(result_wire[24]), .cout(CarryOut_wire[24]));
ALU_1bit A25(.src1(src1[25]), .src2(src2[25]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[24]), .operation(ALU_control[1:0]), .result(result_wire[25]), .cout(CarryOut_wire[25]));
ALU_1bit A26(.src1(src1[26]), .src2(src2[26]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[25]), .operation(ALU_control[1:0]), .result(result_wire[26]), .cout(CarryOut_wire[26]));
ALU_1bit A27(.src1(src1[27]), .src2(src2[27]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[26]), .operation(ALU_control[1:0]), .result(result_wire[27]), .cout(CarryOut_wire[27]));
ALU_1bit A28(.src1(src1[28]), .src2(src2[28]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[27]), .operation(ALU_control[1:0]), .result(result_wire[28]), .cout(CarryOut_wire[28]));
ALU_1bit A29(.src1(src1[29]), .src2(src2[29]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[28]), .operation(ALU_control[1:0]), .result(result_wire[29]), .cout(CarryOut_wire[29]));
ALU_1bit A30(.src1(src1[30]), .src2(src2[30]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[29]), .operation(ALU_control[1:0]), .result(result_wire[30]), .cout(CarryOut_wire[30]));
ALU_1bit A31(.src1(src1[31]), .src2(src2[31]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(CarryOut_wire[30]), .operation(ALU_control[1:0]), .result(result_wire[31]), .cout(CarryOut_wire[31]));

always @* begin 
    zero <= ~(result_wire[0] | result_wire[1] | result_wire[2] | result_wire[3] | result_wire[4] | result_wire[5] | result_wire[6] | result_wire[7] | result_wire[8] | result_wire[9] | result_wire[10] | result_wire[11] | result_wire[12] | result_wire[13] | result_wire[14] | result_wire[15] | result_wire[16] | result_wire[17] | result_wire[18] | result_wire[19] | result_wire[20] | result_wire[21] | result_wire[22] | result_wire[23] | result_wire[24] | result_wire[25] | result_wire[26] | result_wire[27] | result_wire[28] | result_wire[29] | result_wire[30] | result_wire[31]);
// Arithmetic: Add(0010), Sub(0110) & Conditional: SLT(0111)
    if(ALU_control[3:0] == 4'b0010 || ALU_control[3:0] == 4'b0110 || ALU_control[3:0] == 4'b0111) begin
        cout = CarryOut_wire[31];
	overflow <= CarryOut_wire[30]^CarryOut_wire[31];

    end
// Logical operation: AND, OR, NAND, NOR
    else begin
	cout = 0;
	overflow = 0;
    end


//SLT: if(src1<src2) result=1;  else result=0
    if(ALU_control[3:0] == 4'b0111) begin 
	result[0] = result_wire[31];
        for(i=1; i<32; i=i+1) result[i] = 0;
    end

//other funcion: add, sub, AND, OR, NOR, NAND
    else begin
        for(i = 0; i<32; i=i+1) result[i] = result_wire[i];
    end

end

endmodule
