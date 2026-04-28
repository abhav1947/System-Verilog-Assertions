/*
Building Blocks of Assertions 

Sequence: A sequence of multiple logical events typically form the functionality of any design. 

Syntax:

sequence <name_of_sequence>

endsequence

assert property(<name_of_sequence>);
*/

module tb;
  
  bit a,b;
  bit clk;
  
  always #10 clk = ~clk;
  
  initial begin 
    repeat(10) begin
      @(posedge clk);
      a = $urandom;
      b = $urandom;
    end
    $finish;
  end
  
  sequence a_and_b(bit a, bit b);
    a && b;
  endsequence
  
  property a_alw();
    @(posedge clk)
    a_and_b(a, b);
  endproperty
  
  assert property(
    a_alw );
endmodule
