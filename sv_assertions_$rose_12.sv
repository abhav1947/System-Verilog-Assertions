/*$rose Returns true if the LSB of the expression chnaged to "1" from the previous tick of the clocking event otherwise returns False
NOTE THAT THIS IS NOT AN EDGE DETECTOR


TO REMEMBER
If the $rose doesnot see any 0 to 1 transition and only sees 0 to 0, it will keep looking for "a" to go high. For 1 to 1 tansition then it will consider them to be vaccous pass.
*/

module tb;
  
  bit a;
  bit b;
  bit rst;
  bit clk;
  
  always #10 clk = ~clk;
  
  initial begin
    a = 0;
    b = 1;
    rst = 1;
    #100;
    rst = 0;
    #40;
    repeat(15) begin
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
    $rose(a) |-> b) $display("ASSR PASS time = %0t", $time); else $display("ASSR FAIL time = %0t", $time);
  
endmodule
