//////////////////////////////////////////////////////////////////////////////////
// Company: SIU Education 
// Engineer: Michael Tjemmes
// 
// Create Date: 11/19/2021
// Design Name: Multiplier Accumulator Accumulator
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

module ipWrap(
input [0:21] sigIn,
output[0:7] sigOut
);

wire ovf;
wire sign;
wire [0:8]addr;
wire [0:7]data_out;

assign sign = (sigIn[21]);
assign addr = sigIn[5:13];


assign ovf= (sigIn[21]==0)? (sigIn[20] | sigIn[19] | sigIn[18] | sigIn[17] | sigIn[16] | sigIn[15] | sigIn[14]): (~( sigIn[20] & sigIn[19] & sigIn[18] & sigIn[17] & sigIn[16] & sigIn[15] & sigIn[14] ) | ~( sigIn[13] | sigIn[12] | sigIn[11] | sigIn[10] | sigIn[9] | sigIn[8] | sigIn[7] | sigIn[6] | sigIn[5] | sigIn[4] | sigIn[3] | sigIn[2] | sigIn[1] | sigIn[0] ));


sigmoid_0 inst01(addr, sign, ovf, data_out);

assign sigOut=data_out;

endmodule