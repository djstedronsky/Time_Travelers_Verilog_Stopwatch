/*-------------------------------------------------------------------------------
Project: Stopwatch
  Module: 4 Bit Counter Submodule
  Author: Devon Stedronsky
  Date: June,2020
  Module Description:
  4 bit counter submodule to be instantiated for 24 bit counter module.
  Receives basetick from 10ms timer and enable signals from trigger detection.
  Parameterizable, instance based, rollover value.
  Rollover flag to pass to next digit enable in wrapper.  
---------------------------------------------------------------------------------*/  
  
module rtc_4bitcounter 
#(parameter reg [3:0] ROLLOVER_COUNT = 4'd9)
    (   input i_reset_n,        //Low active, asynchronous reset
        input i_rtcclk,         //Mapped to o_basetick from rtc_timer
	    input i_countenb,		//enable signal
		input i_countinit,		//mapped to o_countinit from rtc_trigger
		input i_latchcount,		//mapped to o_latchcount from rtc_trigger
		output reg o_rolloverflag,	//flag pulsed to indicate rollover to initial value
		output reg[3:0] o_bcdcount	// 4-bit bcd encoded output
		);
						
							
reg [3:0] counter = 4'd0;
reg rflag = 1'b0;

always_ff @ (posedge i_rtcclk or negedge i_reset_n) begin
	if (~i_reset_n)
		begin:reset_condition
			counter <= 4'd0;
			rflag <= 0;
		end:reset_condition
	
    else 
		begin:count_enable
			if (i_countenb == 1'b1 & i_latchcount == 1'b1)
				begin:rollover
					if (counter == ROLLOVER_COUNT)
						begin
						counter <= 4'd0;
						rflag <= 1'b1;
						end
					else
						begin
						counter <= counter + 1;
						rflag <= 1'b0;
						end
				end:rollover
		end:count_enable
	
	assign o_bcdcount = counter;
	assign o_rolloverflag = rflag;
					
  end
endmodule