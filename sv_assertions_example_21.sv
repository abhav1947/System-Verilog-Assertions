/*Once valid is asserted by master arbiter provides grant in 2 to 5 clk cycles*/

module tb;
  
  bit valid;
  bit grnt;
  bit clk;
  
  always #10 clk = ~clk;
  
  initial begin
    valid = 0;
    grnt = 0;
    #10;
    repeat(10) begin
      @(posedge clk);
      valid = $urandom;	
      grnt = $urandom;	
    end
    $finish();
  end
  
  a1: assert property(
    @(posedge clk)
    $rose(valid) |-> ##[2:5] grnt
  );
endmodule
