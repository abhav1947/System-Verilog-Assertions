/* Clock Delay Operator ##*/
module tb;
  
  bit a, b;
  bit rst, clk;
  
  always #10 clk = ~clk;
  
  initial begin
    a = 0;
    b = 0;
    rst = 1;
    #180;
    rst = 0;
    repeat(20) begin
      @(posedge clk);
      a = $urandom;
      b = $urandom;
    end
    $finish();
  end
  
  initial begin
  	$dumpfile("dump.vcd"); // Creates the dump file
    $dumpvars(0, tb); // Dumps all variables in the specified module
  end
  
  assert property(
    @(posedge clk)
    disable iff(rst)
    ## 2 a) $display("PASS at t = %0t", $time); else $display("FAIL at t = %0t", $time);
    
endmodule
