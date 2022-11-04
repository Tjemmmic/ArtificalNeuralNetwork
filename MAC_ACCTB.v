//////////////////////////////////////////////////////////////////////////////////
// Company: SIU Education 
// Engineer: Michael Tjemmes
// 
// Create Date: 11/19/2021
// Design Name: Piplined Version
// Module Name: MAC_ACC_TB
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

module MAC_ACCTB;

    
    reg clk;
    reg [0:127] data_a [0:39];
    reg [0:127] data_b [0:39];
    reg [0:7] data_Bias [0:9];
    reg [0:127] a, b;
    reg [0:7] bias;
    reg [0:7] count;
    reg [0:19] count2;
    reg ready; 
    reg rst; 
    
    wire clk2;
    wire [0:21] p;

    integer outfile;

    parameter half_cycle = 10;

    initial 
    begin
        $readmemh("weights_hex.txt", data_a);
        $readmemh("digits_hex.txt", data_b);
        $readmemh("b1_hex.txt", data_Bias);
        outfile = $fopen("simout.txt", "w");
        clk =0;
        count = 0;
        count2=0;
        rst =1;
        #80;
        rst =0;        
    end
    
    //Clock Generations
    always 
    begin
      clk=1;
      #half_cycle;
      clk=0;
      #half_cycle;
    end

    assign #2 clk2 = clk; // delayed clk

    MAC_ACC uut(a,b,bias,ready,clk2,rst,p);
    //MAC2 uut(a,b,p);

    always @(posedge clk)
    begin
        $fdisplay(outfile, "%d: a=%h, b=%h, p=%h", count, a, b, p);
        
    end 

    always @(posedge clk2)
    begin
        count= count+1;

        if(count>5)
        begin
            ready=1;
            a=data_a[count2];
            b=data_b[count2];
            if((count2 % 4)==0)
            begin
                bias=data_Bias[count2 / 4];
            end
            count2=count2+1;
            
            if (count2==43) 
                begin
                    $fclose(outfile);
                    $finish; 
                end
        end

    end

endmodule