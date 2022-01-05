# Objective 13: FPGA Programming
**Location: Frost Tower Rooftop, Frost Tower**  
**Troll: Crunchy Squishter**  
**Hints provided by Grody Goiterson after completion of [Frostavator](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Additional/Frostavator.md)**

The objective is to create Verilog FPGA code which is able to create a square wave wich 500 Hz, 1 kHz, 2 kHz and a random frequency. the frequency is defined using a 32 bit input signal.

The below Verilog FPGA code creates the requested square wave at the required frequencies.
The rounding mentioned in the hints does not seem to be an issue.

```verilog
`timescale 1ns/1ns
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
    reg [31:0] counter;
    reg t;
    assign wave_out = t;
	
  always @(posedge clk or posedge rst)
  begin
    if(rst==1)
    begin
      t<=0;
      counter<=0;
    end
    else
    begin
      if(counter==0) begin
        t <= ~t;
        counter <= clkdivider-1;
      end
      else counter <=counter-1; 
    end
  end
endmodule
```

**Item: FPGA**

**Achievement: FPGA Programming**

After the FPGA is inserted into the Speak&Spell device, the spaceship lands and opens the door.

**Achievement: Open Spaceship's Door**
