/*Write an assertion to make sure that a 5 bit grant signal has only 1 bit set any given time*/

module tb;
  
  bit [4:0] out;
  bit clk;
  
  always #10 clk = ~clk;
  
  initial begin
    out= 0;
    #10;
    out = $urandom;
    @(posedge clk);
    out = 1;
    #40;
    $finish;
  end
  
  initial begin
  	$dumpfile("dump.vcd"); // Creates the waveform database file
    $dumpvars(0, tb); // Dumps all variables in the module (0 = all levels)
end
  
 /*a: assert property(
    @(posedge clk)
    $onehot(out)); */
  
  a2: assert property(
    @(posedge clk)
    ((out[4]+out[3]+out[2]+out[1]+out[0]) == 1)
  ); 
endmodule
