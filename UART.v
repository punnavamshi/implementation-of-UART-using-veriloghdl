`timescale 1ns / 1ps

module UART(
input clock,
input reset,
input rx,
input [7:0] tx_in,
input tx_start,
output tx,
output [7:0] rx_out,
output rx_done,
output tx_done
    );
 
 wire baudTick;
 
 BaudRateGenerator bgen(clock,reset,baudTick);
 Receiver rcvr(clock,reset,baudTick,rx,rx_out,rx_done);
 Transmitter tmtr(clock,reset,baudTick,tx_in,tx_start,tx,tx_done);   
 
endmodule
