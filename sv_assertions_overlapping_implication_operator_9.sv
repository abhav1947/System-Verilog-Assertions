module tb;
  
  bit a,b;
  bit clk;
  
  always #10 clk = ~clk;
  
  initial begin 
    repeat(30)begin
      @(posedge clk);
      a = $urandom;
      b = $urandom;
    end
    $finish();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);
  end
  
  property p1(bit a, bit b);
    @(posedge clk)
    a |-> b;
  endproperty
  
  assert property(p1(a, b));
  
endmodule
