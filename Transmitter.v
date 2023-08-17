`timescale 1ns / 1ps

module Transmitter(

input clock,
input reset,
input baudTick,
input [7:0] tx_in,
input tx_start,
output reg tx,
output reg tx_done
    );  


//reg [1:0] state;
reg [4:0] s;
reg [4:0] n;
reg [7:0] b;
reg [1:0] state;

parameter idle = 2'b00;
parameter start = 2'b01;
parameter data = 2'b10;
parameter stop = 2'b11;

always @(posedge clock) begin
    
    if(reset) begin
        state = idle;
        tx_done=1'b0;
        tx=1'b0;
        s=4'd0;
        n=4'd0;
    end
    else begin    
        case(state)
            idle: begin
                tx_done=1'b0;   
                tx=1'b0;                            
                if(tx_start==1) begin
                    b=tx_in;
                    state=start;
                    s=0;
                end
                else begin
                    state=idle;  
                end
              end
              
            start: begin
                if(baudTick==1) begin
                    if(s==15) begin
                        s=4'd0;
                        n=4'd0;
                        state = data;
                  end            
                  else begin
                        s=s+1;
                        tx=0;                
                   end
                 end
            end                     
            data : begin              
               if(baudTick==1) begin                
                    if(s==15) begin
                        if(n==7) begin
                            state = stop;
                            n=4'd0;
                            s=4'd0;
                        end
                        else begin 
                            b=b>>1;                    
                            n=n+1;
                            s=4'd0;
                            tx=b[0];
                        end                        
                   end
                   else s=s+1;                                                                                             
               end
               else    tx=b[0];                             
            end 
            stop: begin
                 if(baudTick==1) begin
                    if(n==15) begin
                        n=4'd0;
                        s=4'd0;
                        tx=1'b0;
                        state=idle;
                        tx_done=1'b1;
                    end
                    else begin
                        tx=1'b1;                        
                        n=n+1;
                    end
                 end                                    
            end               
         endcase                                                  
    end
end



endmodule
