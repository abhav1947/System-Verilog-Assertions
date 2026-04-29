/*
When intr goes high in the next clock cycle we must see the iack transition from 0 1o 1;
*/
module tb;
  
  bit intr, iack;
  bit rst, clk;
  
  always #10 clk = ~clk;
  
  initial begin
    intr = 0;
    iack = 0;
    rst = 0;
    #100;
    rst = 1;
    #15;
    intr = 1;
    #5;
    iack = 1;
    #40;
    repeat(20) begin
      @(posedge clk) 
        intr = $urandom;
        iack = $urandom;
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
    $rose(intr) |=> $rose(iack)) $display("[PASS] | time  = %0t", $time); else 
    $display("[FAIL] | time  = %0t", $time);
  
endmodule
