/* Wrie a SVA to make sure a signal is high for a min of 2 clk cycles and mxximum of 6 clk cycles*/

module tb;
  
  bit a, b;
  bit clk, rst;
  
  always #10 clk = ~clk;
  
  initial begin
    a = 1'b0;
    b = 1'b0;
    rst = 1'b1;
    #80;
    rst = 1'b0;
    a = 1'b1;
    #80
    a = 1'b0;
    #10;
    a = 1'b1;
    #60;
    $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd"); // Creates the waveform database file
    $dumpvars(0, tb); // Dumps all variables in the module (0 = all levels)
end
  
  assert property(
    @(posedge clk)
    disable iff(rst)
    a [*2:6]) $display("Assertiion Pass t = %0t", $time); else $display("Assertiion Fail t = %0t", $time);
    
endmodule
