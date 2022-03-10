/***************************************************
Student Name: 曾維浩
Student ID: 0511226
***************************************************/

`timescale 1ns/1ps

module Shift_Left_1(
    input  [31:0] data_i,
    output [31:0] data_o
    );

/* Write your code HERE */
assign data_o = data_i << 1;

endmodule