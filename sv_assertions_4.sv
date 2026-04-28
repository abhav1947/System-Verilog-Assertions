/*Unlike concurrent Assertions Immediate assertions are intended to be used in procedural block*/

module tb;
  
  bit fifo_full;
  bit clk;
  
  always #5 clk = ~clk;
  
  initial begin
    repeat(10) begin
      @(posedge clk);
      fifo_full = $urandom;
      assert(!fifo_full) begin
        $display("FIFO is still empty, ASSERTION PASSED");
      end else begin
        $display("FIFO is FULL, ASSERTION FAILED!!!!");
      end
    end
  end
  
  initial begin
  $dumpfile("dump.vcd"); // Name of the waveform file
  $dumpvars(1);          // 1 = dump variables in the current module only
  // Use $dumpvars(0, top_module_name); to dump all signals in the hierarchy
end
  
endmodule
