module tb;
  
  bit a, b;
  bit clk;
  
  always #10 clk = ~clk;
  
  initial begin
    repeat(10) begin
      @(posedge clk);
      $monitor("clk = %0d", clk);
      $monitor("a = %0d", a);
      $monitor("b = %0d", b);
      a = $urandom;
      b = $urandom;
    end
      $finish();
  end
  
initial begin
  $dumpfile("dump.vcd"); // Name of the waveform file
  $dumpvars(1);          // 1 = dump variables in the current module only
  // Use $dumpvars(0, top_module_name); to dump all signals in the hierarchy
end
  assert property(
    @(posedge clk)
  	 a & b);
    
endmodule
