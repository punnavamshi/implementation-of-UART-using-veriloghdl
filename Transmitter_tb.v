`timescale 1ns / 1ps

module Transmitter_tb;

	// Inputs
	reg clock;
	reg reset;
	reg [7:0] tx_in;
	reg tx_start;

	// Outputs
	wire tx;
	wire tx_done;
    wire baudTick;
    wire [1:0] static;
	// Instantiate the Unit Under Test (UUT)
	BaudRateGenerator uut1 (
		clock, 
		reset, 
		baudTick
	 );
	 Transmitter uut2(
	     clock,
	     reset,
	     baudTick,
	     tx_in,
	     tx_start,
	     tx,
	     tx_done,
	     static
	 );
	 
	 always #31 clock=~clock;
     initial begin
        clock=0;
        reset=1;
        tx_start=0;
        
        #100
        tx_start=1;
        reset=0;
        tx_in[7:0]=8'b01110101;
     end
endmodule
