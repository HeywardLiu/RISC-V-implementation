/***************************************************
Student Name: 曾維浩
Student ID: 0511226
***************************************************/

`timescale 1ns/1ps

module Adder(
    input  [31:0] src1_i,
	input  [31:0] src2_i,
	output [31:0] sum_o
	);
    
/* Write your code HERE */
assign sum_o = src1_i + src2_i;


endmodule