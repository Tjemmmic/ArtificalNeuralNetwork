//////////////////////////////////////////////////////////////////////////////////
// Company: SIU Education 
// Engineer: Michael Tjemmes
// 
// Create Date: 11/19/2021
// Design Name: Multiplier Accumulator Piplined Version
// Module Name: MAC
// Project Name: Final Project
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module MAC(
input [0:127] Wi,
input [0:127] Xi,
input clk,
input rst,
output[0:19] Y
);



//Input Registers
reg [0:127] pipe0;
reg [0:127] pipe1;
//Pipeline Registers
reg [0:255] pipe2;
reg [0:19] outputREG;

//Connecting Wires
wire [0:255] s0mult;
wire [0:135] s1add;
wire [0:71] s2add;
wire [0:37] s3add;
wire [0:19] s4add;

genvar i;

parameter numMult  = 16;
parameter numAdd16 = 8;
parameter numAdd17 = 4;
parameter numAdd18 = 2;
parameter numAdd19 = 1;


generate
    //Generating Multipliers Input Wi,Xi output to pipe 2
    for(i=0; i< numMult; i=i+1)
    begin
        mult8_16 multName(pipe0[(i*8):(i*8 +7)],pipe1[(i*8):(i*8 +7)],s0mult[(i*16):(i*16 +15)]);
    end

    //Output of multipliers goes into 16->17 bit adders
    for(i=0; i< numAdd16 ; i=i+1)
    begin
        adder16_17 addName16(pipe2[(i*32):(i*32 + 15)], pipe2[(i*32 + 16):(i*32 + 31)], s1add[(i*17):(i*17 + 16)]);
    end

    //Output of multipliers goes into 17->18 bit adders
    for(i=0; i< numAdd17 ; i=i+1)
    begin
        adder17_18 addName17(s1add[(i*34):(i*34 + 16)], s1add[(i*34 + 17):(i*34 + 33)],s2add[(i*18):(i*18 + 17)]);
    end

    //Output of multipliers goes into 18->19 bit adders
    for(i=0; i< numAdd18 ; i=i+1)
    begin
        adder18_19 addName18(s2add[(i*36):(i*36 + 17)], s2add[(i*36 + 18):(i*36 + 35)],s3add[(i*19):(i*19 + 18)]);
    end

    //Output of multipliers goes into 19->20 bit adders
    for(i=0; i< numAdd19 ; i=i+1)
    begin
        adder19_20 addName19(s3add[(i*38):(i*38 + 18)], s3add[(i*38 + 19):(i*38 + 37)],s4add[(i*20):(i*20 + 19)]);
    end
endgenerate

always@(posedge clk)
begin
    if(~rst)
    begin
        pipe0     <= Wi     ;
        pipe1     <= Xi     ;
        pipe2     <= s0mult ;
        outputREG <= s4add  ;
    end
    else
    begin
        pipe0     <= 0     ;
        pipe1     <= 0     ;
        pipe2     <= 0     ;
        outputREG <= 0     ;
    end 
end


assign Y=outputREG;





    
endmodule