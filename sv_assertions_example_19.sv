/*Write an assertion to make sure that the output signal never goes to X*/

module tb;
  
  logic [3:0] out;
  bit clk;
  
  always #10 clk = ~clk;
  
  initial begin
    out= 0;
    #10;
    out = 'hX;
    #40;
    $finish;
  end
  
  initial begin
  	$dumpfile("dump.vcd"); // Creates the waveform database file
    $dumpvars(0, tb); // Dumps all variables in the module (0 = all levels)
end
  
  a: assert property(
    @(posedge clk)
    !($isunknown(out)));
  
endmodule
