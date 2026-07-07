module dff(
input d,clk,
output reg [3:0]q=4'b0000);
 
 always@(posedge clk)begin
 q <= {q[2:0], d};
end 
endmodule