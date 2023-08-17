`timescale 1ns / 1ps

module UART_tb;

    // Inputs
    reg clock;
    reg reset;
    reg rx;
    reg [7:0] tx_in;
    reg tx_start;

	// Outputs
	wire tx;
    wire [7:0] rx_out;
    wire rx_done;
    wire tx_done;

	// Instantiate the Unit Under Test (UUT)
	UART uut (
		clock, 
		reset,
		rx,
		tx_in,
		tx_start,
		tx,
		rx_out,
		rx_done,
		tx_done
		);

	 always #31 clock=~clock;
	 always #17000 rx=~rx;
	 initial begin
	    clock=0;
	    reset=1;
	    rx=1;
	    tx_start=0;

	 #100
	   tx_start=1;
	   reset=0;
	   tx_in[7:0]=8'b01110101;
	 end
endmodule

