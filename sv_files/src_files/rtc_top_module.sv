/*-------------------------------------------------------------------------------
Project: Stopwatch
Module: Top Module
Author: Waseem Orphali
Date: 06/17/2020
Module Description:
Top module that instantiates all the system submodules and connect them together  
---------------------------------------------------------------------------------*/  

module rtc_top_module(
    input           i_sys_clk,
    input           i_reset_n,
    input           i_trigger_in,
    output  [7:0]   o_digits,
    output  [7:0]   o_segments
    );
    
    
//------------------ Intermediate wires -------------------

    wire            o_countinit;
    wire            o_countenb;
    wire            o_latchcount;
    wire            o_basetick;
    wire    [23:0]  o_count;
    wire    [7:0]   o_segout1;
    wire    [7:0]   o_segout2;
    wire    [7:0]   o_segout3;
    wire    [7:0]   o_segout4;
    wire    [7:0]   o_segout5;
    wire    [7:0]   o_segout6;


//------------------ Port mapping -------------------

    rtc_trigger_detection trigger (
        .i_sclk         (i_sys_clk),
        .i_reset_n      (i_reset_n),
        .i_trigger      (i_trigger_in),
        .o_countinit    (o_countinit),
        .o_countenb     (o_countenb),
        .o_latchcount   (o_latchcount));
        
    rtc_timer timer (
        .i_sclk         (i_sys_clk),
        .i_timerenb     (o_countenb),
        .i_reset_n      (i_reset_n),
        .o_basetick     (o_basetick));
        
    rtc_24bitcounter counter(
        .i_reset_n      (i_reset_n),
        .i_rtcclk       (o_basetick),
        .i_countenb     (o_countenb),
        .i_countinit    (o_countinit),
        .i_latchcount   (o_latchcount),
        .o_count        (o_count));
        
    rtc_seg_disp display(
        .i_count        (o_count),
        .o_segout1      (o_segout1),
        .o_segout2      (o_segout2),
        .o_segout3      (o_segout3),
        .o_segout4      (o_segout4),
        .o_segout5      (o_segout5),
        .o_segout6      (o_segout6));
        
    rtc_seg_adap adapter(
        .i_sys_clk      (i_sys_clk),
        .i_reset_n      (i_reset_n),
        .i_segout1      (o_segout1),
        .i_segout2      (o_segout2),
        .i_segout3      (o_segout3),
        .i_segout4      (o_segout4),
        .i_segout5      (o_segout5),
        .i_segout6      (o_segout6),
        .o_segments     (o_segments),
        .o_digits       (o_digits));
        
endmodule
