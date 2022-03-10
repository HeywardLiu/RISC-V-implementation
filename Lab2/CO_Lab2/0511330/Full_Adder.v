/***************************************************
Student Name:  ???
Student ID:    0511330
***************************************************/
module Full_Adder (Sum, CarryOut, Input1, Input2, CarryIn);

  input Input1, Input2, CarryIn;
  output Sum, CarryOut;

  wire w1, w2, w3;
  xor x1(w1, Input1, Input2);
  xor x2(Sum, w1, CarryIn);
  and a1(w2, Input1, Input2);
  and a2(w3, w1, CarryIn);
  or o1(CarryOut, w2, w3);

endmodule