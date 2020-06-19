//-------------------------------------------
//Author: Waseem Orphali
//-------------------------------------------
// Date: 06/14/2020
//-------------------------------------------
// Purpose: This code takes six 7-segment display
// inputs and cycles through connecting them 
// to the output 'o_segments' and enabling the correct
// digit for 1ms, assuming the clk freq is 100 Mhz 
//-------------------------------------------


module rtc_seg_adap (
    input   wire        i_sys_clk,  // system clk
    input   wire        i_reset_n,  // system active low reset
    input   wire [7:0]  i_segout1,  // input from rtc_seg_disp
    input   wire [7:0]  i_segout2,  // input from rtc_seg_disp
    input   wire [7:0]  i_segout3,  // input from rtc_seg_disp
    input   wire [7:0]  i_segout4,  // input from rtc_seg_disp
    input   wire [7:0]  i_segout5,  // input from rtc_seg_disp
    input   wire [7:0]  i_segout6,  // input from rtc_seg_disp
    output  reg  [7:0]  o_segments, // segment code output to be displayed
    output  reg  [7:0]  o_digits    // enables the display digits
    );
    
    localparam CYCLES_PER_DIGIT = 100000;    // 1 ms if the clk freq is 100 Mhz
    localparam NUM_OF_DIGITS = 6;
    localparam TOTAL_CYCLES = NUM_OF_DIGITS * CYCLES_PER_DIGIT;
    
    integer counter = 0;            // initiales counter used to slow down clk, 100 Mhz is too fast to run display
    
    always @(posedge (i_sys_clk) or negedge(i_reset_n))
    begin
        if (~i_reset_n)             // reset condition
        begin
            o_digits <= 8'b00000000;
            o_segments <= 8'b00000000;
            counter <= 0;
        end
        else if (i_sys_clk)
        begin
            case (counter) inside   // cycling through the digits
                [0:CYCLES_PER_DIGIT-1]: begin
                    counter <= counter + 1;
                    o_segments <= i_segout1;
                    o_digits <= 8'b11111110;
                    end
                [CYCLES_PER_DIGIT:CYCLES_PER_DIGIT*2 -1]: begin
                    counter <= counter + 1;
                    o_segments <= i_segout2;
                    o_digits <= 8'b11111101;
                    end
                [CYCLES_PER_DIGIT*2:CYCLES_PER_DIGIT*3 -1]: begin
                    counter <= counter + 1;
                    o_segments <= i_segout3;
                    o_digits <= 8'b11111011;
                    end
                [CYCLES_PER_DIGIT*3:CYCLES_PER_DIGIT*4 -1]: begin
                    counter <= counter + 1;
                    o_segments <= i_segout4;
                    o_digits <= 8'b11110111;
                    end
                [CYCLES_PER_DIGIT*4:CYCLES_PER_DIGIT*5 -1]: begin
                    counter <= counter + 1;
                    o_segments <= i_segout5;
                    o_digits <= 8'b11101111;
                    end
                [CYCLES_PER_DIGIT*5:CYCLES_PER_DIGIT*6 -1]: begin
                    counter <= counter + 1;
                    o_segments <= i_segout6;
                    o_digits <= 8'b11011111;
                    end
                default:
                    counter <= 0;
            endcase
    
        end
    end
endmodule