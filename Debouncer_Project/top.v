module top(
  input sys_clk,
  input s1,s2,
  output wire [3:0]led 
);
   wire se_in;
   wire raw_clk; 
   wire clean_clk;
   wire [3:0]in_wi;
 
   assign se_in = ~s1;
   assign raw_clk = ~s2;
    
   debouncer my_filter(
   .clk(sys_clk),
   .btn_in(raw_clk),
   .btn_out(clean_clk)
);
  dff my_mem(
   .d(se_in),
   .clk(clean_clk),
   .q(in_wi)
);
assign led=~in_wi;
endmodule