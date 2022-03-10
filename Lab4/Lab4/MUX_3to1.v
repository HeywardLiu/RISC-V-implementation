/***************************************************
Student Name: 曾維浩
Student ID: 0511226
***************************************************/

`timescale 1ns/1ps

module MUX_3to1(
	input  [31:0] data0_i,       
	input  [31:0] data1_i,
	input  [31:0] data2_i,
	input  [ 1:0] select_i,
	output [31:0] data_o
    );		   

/* Write your code HERE */
assign data_o = (select_i==2) ? data2_i:(
				(select_i==1) ? data1_i: 
								data0_i);

endmodule      
          