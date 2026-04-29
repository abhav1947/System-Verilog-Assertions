// Code your testbench here
// or browse Examples
module tb;
  
  bit a;
  bit b;
  bit rst, clk;
  
  always #10 clk = ~clk;
  
  initial begin
    a = 1;
    b = 1;
    rst = 1;
    #100;
    rst = 0;
    a = 1;
    #10;
    b = 1;
    #40;
    repeat(30) begin
      @(posedge clk);
      a = $urandom;
      b = $urandom;
    end
    
    $finish;
  end
  
  initial begin
  	$dumpfile("dump.vcd"); // Creates the dump file
    $dumpvars(0, tb); // Dumps all variables in the specified module
  end
  
  assert property(
    @(posedge clk)
    disable iff(rst)
    a |-> b);
    
endmodule
