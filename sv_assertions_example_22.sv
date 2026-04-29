/* As long as signal_a is up signal_b should not be asserted*/

module tb;
  bit signal_a, signal_b;
  bit clk, rst;
  
  always #10 clk = ~clk;
  
  initial begin
    signal_a = 1'b0;
    signal_b = 1'b0;
    rst = 1'b0;
    #20;
    rst = 1'b1;
    repeat(15) begin
      @(posedge clk);
      signal_a = $urandom;
      signal_b = $urandom;
    end
    $finish();
  end
  
  a1: assert property(
    @(posedge clk)
    disable iff(!rst)
    signal_a |-> !(signal_b)
  );
endmodule
