`timescale 1ns / 1ps

module Receiver(

input clock,
input reset,
input baudTick,
input rx,
output reg [7:0] rx_out,
output reg rx_done

    );

reg [1:0] state;
reg [4:0] s;
reg [4:0] n;

parameter idle = 2'b00;
parameter start = 2'b01;
parameter data = 2'b10;
parameter stop = 2'b11;

always @(negedge clock) begin
    
    if(reset) begin
        state = idle;
        rx_done=0;
        rx_out=8'd0;
        s=4'd0;
        n=4'd0;
    end
    else begin    
        case(state)
            idle: begin
                rx_done=0;   
                rx_out=8'd0;                            
                if(rx==0) begin
                    state=start;
                    s=0;
                end
                else begin
                    state=idle;  
                end
              end
              
            start: begin
                if(baudTick==1) begin
                    if(s==7) begin
                        s=4'd0;
                        n=4'd0;
                        state = data;
                  end            
                  else begin
                        s=s+1;                
                   end
                 end
            end                     
            data : begin              
               if(baudTick==1) begin                
                   if(s==15) begin
                         rx_out=(rx<<n)|(rx_out);  
                         s=4'd0;                      
                         if(n==7) begin 
                            state = stop;
                            n=4'd0;
                         end                         
                         else n=n+1;                                                                          
                   end 
                   else begin 
                        s=s+1;
                   end                                      
                end
            end 
            stop: begin
                 if(baudTick==1) begin
                    if(n==15) begin
                        n=4'd0;
                        s=4'd0;
                        state=idle;
                        rx_done=1'b1;
                    end
                    else begin
                        n=n+1;
                    end
                 end                                    
            end               
         endcase                                                  
    end
end


endmodule
