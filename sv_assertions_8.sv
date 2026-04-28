module tb;
  
  bit a, b, c, d;
  bit clk;
  
  always #10 clk = ~clk;
  
  initial begin
    repeat(30) begin
      @(posedge clk);
      a = $urandom;
      b = $urandom;
      c = $urandom;
      d = $urandom;
    end
    $finish;
  end
  
  initial begin
  $dumpfile("dump.vcd"); // Name of the waveform file
  $dumpvars(1);          // 1 = dump variables in the current module only
  // Use $dumpvars(0, top_module_name); to dump all signals in the hierarchy
end
  
  sequence a_rl_b(bit a, bit b);
    a ##1 b;
  endsequence
  
  sequence c_rl_d(bit c, bit d);
    c ##2 d;
  endsequence
  
  property md();
    @(posedge clk)
    a_rl_b(a,b) ##1 c_rl_d(c,d);
  endproperty
  
  assert property(
  md);
  
endmodule
