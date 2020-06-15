//-------------------------------------------
//Author: Waseem Orphali
//-------------------------------------------
// Date: 06/14/2020
//-------------------------------------------
// Purpose: This code takes 24 bit BCD input
// and outputs six 7-segment display outputs 
//-------------------------------------------

module rtc_seg_disp (
    input   wire [23:0] i_count,    // input from rtc_counter: 24 bit BCD
    output  reg  [7:0]  o_segout1,  // output for first digit
    output  reg  [7:0]  o_segout2,  // output for second digit
    output  reg  [7:0]  o_segout3,  // output for third digit
    output  reg  [7:0]  o_segout4,  // output for fourth digit
    output  reg  [7:0]  o_segout5,  // output for fifth digit
    output  reg  [7:0]  o_segout6   // output for sixth digit
    );
    
    localparam [7:0] MEM [9:0] = {0,1,2,3,4,5,6,7,8,9}; // 7-seg code to display numbers 0 - 9 according to Nexys A7 datasheet
    
    assign o_segout1 = MEM[i_count[3:0]];
    assign o_segout2 = MEM[i_count[7:4]];
    assign o_segout3 = MEM[i_count[11:8]];
    assign o_segout4 = MEM[i_count[15:12]];
    assign o_segout5 = MEM[i_count[19:16]];
    assign o_segout6 = MEM[i_count[23:20]];
    
endmodule