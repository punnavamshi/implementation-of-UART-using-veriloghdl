`timescale 1ns / 1ps

module Receiver_tb;


	// Inputs
	reg clock;
	reg reset;
	reg rx;

	// Outputs
	wire [7:0] rx_out;
	wire rx_done;
    wire baudTick;

	// Instantiate the Unit Under Test (UUT)
	BaudRateGenerator uut1 (
		clock, 
		reset, 
		baudTick
	 );
	 Receiver uut2(
	     clock,
	     reset,
	     baudTick,
	     rx,
	     rx_out,
	     rx_done
	 );
	 
	 always #31 clock=~clock;
	 always #17000 rx=~rx;
	 initial begin
	    clock=0;
	    reset=1;
	    rx=1;
	 #100
	   reset=0;
	 end
endmodule
