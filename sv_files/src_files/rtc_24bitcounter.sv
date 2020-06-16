/*-------------------------------------------------------------------------------
Project: Stopwatch
  Module: 4 Bit Counter Submodule
  Author: Devon Stedronsky
  Date: June,2020
  Module Description:
  24 bit counter module for stopwatch project
  Instantiates 6, 4-bit counter submodules with parameterized rollover values 
---------------------------------------------------------------------------------*/  
  
module rtc_24bitcounter 
    (   input i_reset_n,        //Low active, asynchronous reset
        input i_rtcclk,         //Mapped to o_basetick from rtc_timer
	    input i_countenb,		//enable signal mapped to o_countenb from rtc_trigger
		input i_countinit,		//mapped to o_countinit from rtc_trigger
		input i_latchcount,		//mapped to o_latchcount from rtc_trigger
		output reg[23:0] o_count	// 24-bit bcd encoded output
		
		//output reg o_maxtime,	//Unused top module rollover flag can be used for testing purposes
		);
						

//temp reg for max time flag						
reg maxflag = 1'b0;

//temp reg for rollover flags
reg rflag1 = 1'b0;
reg rflag2 = 1'b0;
reg rflag3 = 1'b0;
reg rflag4 = 1'b0;
reg rflag5 = 1'b0;

//temp reg for bcd digits
reg [3:0] bcdcount1 = 4'd0;
reg [3:0] bcdcount2 = 4'd0;
reg [3:0] bcdcount3 = 4'd0;
reg [3:0] bcdcount4 = 4'd0;
reg [3:0] bcdcount5 = 4'd0;
reg [3:0] bcdcount6 = 4'd0;
    
    //digit 1 - 10s of milliseconds - rollover at 9
    rtc_4bitcounter #(4'd9) d1 (
        .i_reset_n (i_reset_n),
        .i_rtcclk (i_rtcclk),
        .i_countenb (i_countenb),
        .i_countinit (i_countinit),
        .i_latchcount (i_latchcount),
        .o_rolloverflag (rflag1),
        .o_bcdcount (bcdcount1)
        );
    
    //digit 2 - 100s of milliseconds - rollover at 9
    rtc_4bitcounter #(4'd9) d2 (
        .i_reset_n (i_reset_n),
        .i_rtcclk (rflag1),
        .i_countenb (i_countenb),
        .i_countinit (i_countinit),
        .i_latchcount (i_latchcount),
        .o_rolloverflag (rflag2),
        .o_bcdcount (bcdcount2)
        );
    
    //digit 3 - seconds - rollover at 9
    rtc_4bitcounter #(4'd9) d3 (
        .i_reset_n (i_reset_n),
        .i_rtcclk (rflag2),
        .i_countenb (i_countenb),
        .i_countinit (i_countinit),
        .i_latchcount (i_latchcount),
        .o_rolloverflag (rflag3),
        .o_bcdcount (bcdcount3)
        );
    
    //digit 4 - 10s of seconds - rollover at 5  
    rtc_4bitcounter #(4'd5) d4 (
        .i_reset_n (i_reset_n),
        .i_rtcclk (rflag3),
        .i_countenb (i_countenb),
        .i_countinit (i_countinit),
        .i_latchcount (i_latchcount),
        .o_rolloverflag (rflag4),
        .o_bcdcount (bcdcount4)
        );

    //digit 5 - minutes - rollover at 9
    rtc_4bitcounter #(4'd9) d5 (
        .i_reset_n (i_reset_n),
        .i_rtcclk (rflag4),
        .i_countenb (i_countenb),
        .i_countinit (i_countinit),
        .i_latchcount (i_latchcount),
        .o_rolloverflag (rflag5),
        .o_bcdcount (bcdcount5)
        );
    
    //digit 6 - 10s of minutes - rollover at 5   
    rtc_4bitcounter #(4'd5) d6 (
        .i_reset_n (i_reset_n),
        .i_rtcclk (rflag5),
        .i_countenb (i_countenb),
        .i_countinit (i_countinit),
        .i_latchcount (i_latchcount),
        .o_rolloverflag (maxflag),
        .o_bcdcount (bcdcount6)
        );
	
	//assign output to bcd nibbles
	assign o_count [3:0] = bcdcount1;
	assign o_count [7:4] = bcdcount2;
	assign o_count [11:8] = bcdcount3;
	assign o_count [15:12] = bcdcount4;
	assign o_count [19:16] = bcdcount5;
	assign o_count [23:20] = bcdcount6;
	
	//UNUSED max time flag can be used for debugging
	//assign o_maxtimeflag = maxflag;
				
endmodule