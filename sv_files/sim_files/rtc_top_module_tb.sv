`timescale 1ns / 1ps


module rtc_top_module_tb;
    reg           i_sys_clk;
    reg           i_reset_n;
    reg           i_trigger_in;
    wire  [7:0]   o_digits;
    wire  [7:0]   o_segments;
    
rtc_top_module UUT(
           .i_sys_clk     (i_sys_clk),
           .i_reset_n     (i_reset_n),
           .i_trigger_in  (i_trigger_in),
           .o_digits      (o_digits),
           .o_segments    (o_segments));

//--------100 Mhz System Clock Input--------//
always
#5 i_sys_clk = !i_sys_clk;

initial
begin
// Set initial value of system clock, tigger, and reset to 0
i_sys_clk=0;
i_trigger_in=0;                
i_reset_n=0;

//------------------------ RESET FUNTION TEST-------------------------//
// Test reset funtion when trigger is held high
#5
i_trigger_in=1;                
i_reset_n=0;
assert (o_digits =='h00 && o_segments=='h00 ) $display("RESET FUNTION PASSED AT TIME %0d",$time);
else $warning("RESET FUNTION FAILED AT TIME %0d",$time);


#20
i_trigger_in=0;  

#18ms
i_reset_n=0;  
@(posedge i_sys_clk);
@(negedge i_sys_clk);

assert (o_digits =='h00 && o_segments=='h00) $display("RESET FUNTION PASSED AT TIME %0d",$time);
else $warning("RESET FUNTION FAILED AT TIME %0d",$time);
//------------------------ RESET FUNTION TEST END-------------------------//
@(posedge i_sys_clk);
@(negedge i_sys_clk);
i_reset_n=1;  
i_trigger_in=1;
#15
i_reset_n=1;  
i_trigger_in=0;  
//--------------------------------------PAUSE FUNTION TEST-------------------------------------------//
// Testing stopwatch pause funtion
// Counter shall held previously value when trigger is pressed
wait (o_digits =='hfe && o_segments=='ha4);
i_trigger_in=1;  
#15
i_trigger_in=0;  
assert (o_digits =='hfe && o_segments=='ha4) $display("PAUSE FUNTION PASSED AT TIME %0d",$time);
else $warning("PAUSE FUNTION FAILED AT TIME %0d",$time);
//--------------------------------------PAUSE FUNTION TEST END-------------------------------------------//

//-------------------------------------ENABLE COUNTING--------------------------------------------------//
// Input 1 to i_trigger_in to resume stopwatch
#1ms
i_trigger_in=1;  
#15
i_trigger_in=0; 
//-------------------------------------ENABLE COUNTING END---------------------------------------------//

//-------------------------------------o_digit_0 TEST ------------------------------------------------//
wait (o_digits =='hfe && o_segments=='h90);
wait (o_digits =='hfe && o_segments=='h90);
#7ms
assert (o_digits =='hfe && o_segments=='hc0) $display(" o_digit_0 RESET TO 0 PASSED AT TIME %0d",$time);
else $warning("o_digit_0 RESET TO 0 FAILED AT TIME %0d",$time);
//-------------------------------------o_digit_0 TEST END------------------------------------------------//

//-------------------------------------o_digit_1 TEST ------------------------------------------------//
wait (o_digits =='hfd && o_segments=='h90);
wait (o_digits =='hfe && o_segments=='h90);
#8ms
assert (o_digits =='hfd && o_segments=='hc0) $display(" o_digit_1 RESET TO 0  PASSED AT TIME %0d",$time);
else $warning("o_digit_1 RESET TO 0  FAILED AT TIME %0d",$time);
//-------------------------------------o_digit_1 TEST END------------------------------------------------//


//-------------------------------------o_digit_2 TEST ------------------------------------------------//
wait (o_digits =='hfb && o_segments=='h90);
wait (o_digits =='hfd && o_segments=='h90);
wait (o_digits =='hfe && o_segments=='h90);
#9ms
assert (o_digits =='hfb && o_segments=='hc0) $display(" o_digit_2 RESET TO 0  PASSED AT TIME %0d",$time);
else $warning("o_digit_2 RESET TO 0  FAILED AT TIME %0d",$time);
//-------------------------------------o_digit_2 TEST END------------------------------------------------//


//-------------------------------------o_digit_3 TEST ------------------------------------------------//
wait (o_digits =='hf7 && o_segments=='h92);
wait (o_digits =='hfb && o_segments=='h90);
wait (o_digits =='hfd && o_segments=='h90);
wait (o_digits =='hfe && o_segments=='h90);
#10ms
assert (o_digits =='hf7 && o_segments=='hc0) $display(" o_digit_3 RESET TO 0  PASSED AT TIME %0d",$time);
else $warning("o_digit_3 RESET TO 0  FAILED AT TIME %0d",$time);
//-------------------------------------o_digit_3 TEST END------------------------------------------------//

//-------------------------------------o_digit_4 TEST ------------------------------------------------//
wait (o_digits =='hef && o_segments=='h90);
wait (o_digits =='hf7 && o_segments=='h92);
wait (o_digits =='hfb && o_segments=='h90);
wait (o_digits =='hfd && o_segments=='h90);
wait (o_digits =='hfe && o_segments=='h90);
#11ms
assert (o_digits =='hef && o_segments=='hc0) $display(" o_digit_4 RESET TO 0  PASSED AT TIME %0d",$time);
else $warning("o_digit_4 RESET TO 0  FAILED AT TIME %0d",$time);
//-------------------------------------o_digit_4 TEST END------------------------------------------------//


//-------------------------------------o_digit_5 TEST ------------------------------------------------//
wait (o_digits =='hdf && o_segments=='h92);
wait (o_digits =='hef && o_segments=='h90);
wait (o_digits =='hf7 && o_segments=='h92);
wait (o_digits =='hfb && o_segments=='h90);
wait (o_digits =='hfd && o_segments=='h90);
wait (o_digits =='hfe && o_segments=='h90);
#12ms
assert (o_digits =='hdf && o_segments=='hc0) $display(" o_digit_5 RESET TO 0  PASSED AT TIME %0d",$time);
else $warning("o_digit_5 RESET TO 0  FAILED AT TIME %0d",$time);
//-------------------------------------o_digit_5 TEST END------------------------------------------------//
#10
$finish;
$display("Simulation is Finished");
end


endmodule
