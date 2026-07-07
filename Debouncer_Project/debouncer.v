
module debouncer(
 input clk,
 input btn_in,
 output reg btn_out=0);

reg[19:0]timer=20'd0;

always@(posedge clk)begin
  if(btn_in!=btn_out)begin
    timer<=timer + 1;
    
     if(timer>=20'd540_000)begin
       btn_out<=btn_in;
       timer<=0;
     end
  end
    else begin
     timer<=0;
    end
end
endmodule
