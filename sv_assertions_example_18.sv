/*For a sync FIFO of depth 16 
clock signal clk, wr_en and rd_En, full_Flag and word counter
a) If word count is > 15, FIFO full flag set
b) If word count is 15 and a new write operation happens without simultaneous read, then FIFO full flag is set*/

module tb;
  
  bit [5:0] word_count;
  bit wr_en, rd_en, flag_set;
  bit rst, clk;
  
  always #10 clk = ~clk;
  
  initial begin
    word_count = 0;
    wr_en = 0;
    rd_en = 0;
    flag_set = 0;
    rst = 1;
    #60;
    repeat(20) begin
      @(posedge clk);
      rst = $urandom;
      word_count = $urandom;
      wr_en = $urandom;
      rd_en = $urandom;
      flag_set = $urandom;
    end
    $finish;
  end
  
  initial begin
  	$dumpfile("dump.vcd"); // Creates the waveform database file
    $dumpvars(0, tb); // Dumps all variables in the module (0 = all levels)
end
   
    a: assert property(
      @(posedge clk)
      disable iff(rst)
      (word_count > 15)|-> flag_set) $display("PASS"); else $display("FAIL");
    
    b: assert property(
      @(posedge clk)
      disable iff(rst)
      ((word_count == 15) && wr_en && !(rd_en)) |-> flag_set) $display("PASS"); else $display("FAIL");
		      
endmodule
  
  
