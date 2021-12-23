<h1 id="objective-13-fpga-programming">Objective 13: FPGA Programming</h1>
<p><strong>Location: Frost Tower Rooftop, Frost Tower</strong><br>
<strong>Troll: Crunchy Squishter</strong><br>
<strong>Hints provided by Grody Goiterson after completion of <a href="https://github.com/joergschwarzwaelder/hhc2021/blob/master/Additional/Frostavator.md">Frostavator</a></strong></p>
<p>The below Verilog FPGA code creates the requested square wave at the required frequencies:</p>
<pre><code>`timescale 1ns/1ns
module tone_generator (
    input clk,
    input rst,
    input [31:0] freq,
    output wave_out
);
    // ---- DO NOT CHANGE THE CODE ABOVE THIS LINE ---- 
    // ---- IT IS NECESSARY FOR AUTOMATED ANALYSIS ----
    reg [31:0] tenth=freq/10;
    reg [31:0] clkdivider=625000000/tenth;
    reg [32:0] counter;
	reg t;
    assign wave_out = t;
	
	always @(posedge clk or posedge rst)
	begin
	  if(rst==1)
	  begin
      t&lt;=0;
      counter&lt;=0;
	  end
	  else
	  begin
	    if(counter==0) begin
	      t &lt;= ~t;
	      counter &lt;= clkdivider-1;
	    end
	    else counter &lt;=counter-1; 
      end
	end
endmodule
</code></pre>
<p><strong>Item: FPGA</strong><br>
<strong>Achievement: FPGA Programming</strong></p>
<p>After the FPGA is inserted into the device, the spaceship lands and opens the door.</p>
<p><strong>Achievement: Open Spaceship’s Door</strong></p>

