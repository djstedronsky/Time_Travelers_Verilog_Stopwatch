`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*--------------------------------------------------------------------------------
  Project: Stopwatch
  Module: 10ms Timer Testbench
  Author:Devon Stedronsky
  Date:June/2020
  Module Description:
  Tesbench for 10ms timer module
  Each test case is tested individually with 10ns resets between each procedure
  Total simulation time for verification ~100ms.
---------------------------------------------------------------------------------*/

module rtc_timer_tb;

reg i_sclk = 0;
reg i_reset_n = 0;
reg i_timerenb = 0;
reg o_basetick = 0;

rtc_timer DUT (
    .i_sclk (i_sclk),
    .i_reset_n (i_reset_n),
    .i_timerenb (i_timerenb),
    .o_basetick (o_basetick)
    );

//error counter for TC_06 and TC_09
integer errorcount_tc_06 = 0;
integer errorcount_tc_09 = 0;

//clock generation 100Mhz
always
#5 i_sclk = !i_sclk;

initial
begin

//assert (A == B) $display ("OK. A equals B");
//    else $error("It's gone wrong");
i_reset_n = 0;
i_timerenb = 0;
#10;    
    
//----------------TIMER_TC_01-----------------//
//Initialization of internal counter to 1
assert (DUT.counter == 1) $display ("TIMER_TC_01: PASS");
    else $error ("TIMER_TC_01: FAIL");
#10;

//----------------TIMER_TC_02-----------------//
//Output o_basetick initialization to value of 0
assert (o_basetick == 0) $display ("TIMER_TC_02: PASS");
    else $error ("TIMER_TC_02: FAIL");
#10;

//----------------TIMER_TC_03-----------------//
//MAX_COUNT parameter set to 500000
assert (DUT.MAX_COUNT == 500000) $display ("TIMER_TC_03: PASS");
    else $error ("TIMER_TC_03: FAIL");
#10;

//----------------TIMER_TC_04-----------------//
//Internal signal counter increments on rising edge of sys_clk when enabled
//i_timerenb set to 1 -- i_reset_n set to 1
//wait for one clock cycle and check that internal counter is incremented
i_reset_n = 1;
#10;

i_timerenb = 1;

@(posedge i_sclk);
@(negedge i_sclk);

assert (DUT.counter == 2) $display ("TIMER_TC_04: PASS");
    else $error ("TIMER_TC_04: FAIL");
    
i_reset_n = 0;
#10;

//----------------TIMER_TC_05-----------------//
//Internal signal counter is reset to 1 when it reaches MAX_COUNT
//wait for internal counter to reach max value
//wait one clock cycle and check counter reset to 1
i_reset_n = 1;
i_timerenb = 1;

wait (DUT.counter == 500000);
@(posedge i_sclk);
@(negedge i_sclk);

assert (DUT.counter == 1) $display ("TIMER_TC_05: PASS");
    else $error ("TIMER_TC_05: FAIL");

i_reset_n = 0;
#10;

//----------------TIMER_TC_06-----------------//
//o_basetick is toggled when counter reaches max_count
//set enable signal and allow counter to rollover 2x
//check that o_basetick toggled on at rollover 1
//check that o_basetick toggles off at rollover 2
i_reset_n = 1;
i_timerenb = 1;

//Toggling from 0 to 1
wait (DUT.counter == 500000);
@(posedge i_sclk);
@(negedge i_sclk);

if (o_basetick != 1)
    begin    
    $display ("TIMER_TC_06: o_basetick toggle from 0 to 1 failure");
    errorcount_tc_06 ++;
    end

//Toggling from 1 to 0
wait (DUT.counter == 500000);
@(posedge i_sclk);
@(negedge i_sclk);

//assert (o_basetick == 0) $display ("TIMER_TC_06: o_basetick toggle from 1 to 0 success");
//    else $error ("TIMER_TC_06: o_basetick toggle from 1 to 0 failure");
if (o_basetick != 0)
    begin
    $display ("TIMER_TC_06: o_basetick toggle from 1 to 0 failure");
    errorcount_tc_06 ++;
    end

assert (errorcount_tc_06 == 0) $display ("TIMER_TC_06: PASS");
    else $error ("TIMER_TC_06: FAIL");

i_reset_n = 0;
#10;

//----------------TIMER_TC_07-----------------//
//internal counter is set to 1 when i_reset_n is set to 0
//set enable signal and reset_n allowing counter to increment a few times
//set reset_n to 0 and check value of internal counter
i_reset_n = 1;
i_timerenb = 1;
#40;

i_reset_n = 0;
@(posedge i_sclk);
assert (DUT.counter == 1) $display ("TIMER_TC_07: PASS");
    else $error ("TIMER_TC_07: FAIL");

i_reset_n = 0;
#10;

//----------------TIMER_TC_08-----------------//
//o_basetick is set to 0 when i_reset_n is set to 0
//set enable signal and wait for o_basetick to toggle to 1
//set reset_n to 0 and check value of o_basetick
i_reset_n = 1;
i_timerenb = 1;

wait (o_basetick == 1);
#100;

i_reset_n = 0;
@(posedge i_sclk);
@(negedge i_sclk);
assert (o_basetick == 0) $display ("TIMER_TC_08: PASS");
    else $error ("TIMER_TC_08: FAIL");

i_reset_n = 0;
#10;

//----------------TIMER_TC_09-----------------//
//set timer enable and reset_n to 1
//Observe waveform for 10ms o_basetick period

i_reset_n = 1;
i_timerenb = 1;
$display ("TIMER_TC_09:"); 
$display ("Start time: %0t", $time);
$display ("VERIFY TIMER_TC_09 BY OBSERVATION.");
$display ("o_basetick should show a 10ms period after start time.");
#100ms;


end
endmodule