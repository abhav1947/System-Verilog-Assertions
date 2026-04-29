/*
$fell check if there is a transition from 1 to 0 occuring. It samples the signal at 1st clock edge prepone region and for the 2nd clock edge it samples the same signal in prepone region, if there is a transition of signal from 1 to 0, then only it procedes to the consequent.
*/

module tb;
  
  bit a, b;
  bit rst, clk;
  
  always #10 clk = ~clk;
  
  initial begin
    a = 0;
    b = 0;
    rst = 0;
    #100;
    rst = 1;
    #40;
    repeat(15) begin
      @(posedge clk) 
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
    disable iff(!rst) 
    $fell(a) |-> b) $display("[PASS] | time  = %0t", $time); else 
    $display("[FAIL] | time  = %0t", $time);
  
endmodule
