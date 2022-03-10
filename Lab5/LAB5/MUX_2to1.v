/***************************************************
Student Name: 曾維浩
Student ID: 0511226
***************************************************/

`timescale 1ns/1ps

module MUX_2to1(
	input  [31:0] data0_i,       
	input  [31:0] data1_i,
	input         select_i,
	output [31:0] data_o
    );			   

/* Write your code HERE */
assign data_o = (select_i==1) ? data1_i : data0_i;

endmodule      
          