//////////////////////////////////////////////////////////////////////////////////
/*--------------------------------------------------------------------------------
  Project: Stopwatch
  Module: Counter Test Bench
  Author: Waseem Orphali
  Date: 06/16/2020
---------------------------------------------------------------------------------*/
'timescale 1ns/1ns

module rtc_counter_tb;

    reg i_rtcclk = 0;
    reg i_reset_n = 0;
    reg i_countenb = 0;
    reg i_countinit = 1;
    reg i_latchcount = 0;
    wire [23:0] o_count;

    integer i = 0;
    
    rtc_counter DUT (
        .i_rtcclk       (i_rtcclk),
        .i_reset_n      (i_reset_n),
        .i_countenb     (i_countenb),
        .i_countinit    (i_countinit),
        .i_latchcount   (i_latchcount),
        .o_count        (o_count)
        );

    always
        #5 i_rtcclk = !i_rtcclk;    // input clk, this clk is supposed to be of period 10ms but it is set to a much faster clk for the sake of simulation
        
    initial     // stimulus
    begin
    
        
// --------------------- COUNTER_TC_01 ----------------------------
    // observe waveform and check if 'o_bcdcount' is initialized to 0
    // reset the system
    
        i_reset_n = 0;
        # 10;

// --------------------- End of COUNTER_TC_01 --------------------------



// --------------------- COUNTER_TC_02 ----------------------------
    // set 'i_reset_n' to 1
    // enable the counter by setting 'i_countenb' and 'i_latchcount' to 1 for 1 clk cycle
    // set 'i_reset_n' to 0
    // observe waveform and check if the internal signal 'o_bcdcount' got set to 0
    
        i_reset_n = 1;
        i_countinit = 0;
        #10;
        
        i_countenb = 1;
        i_latchcount = 1;
        @(posedge i_rtcclk);
        @(negedge i_rtcclk);
        i_countenb = 0;
        i_latchcount = 0;
        #20;
        
        i_reset_n = 0;
        #10;
// --------------------- End of COUNTER_TC_02 --------------------------


        
// --------------------- COUNTER_TC_03 ----------------------------
    // set 'i_reset_n' to 0
    // set 'i_reset_n' to 1
    // enable the counter by setting 'i_countenb' and 'i_latchcount' to 1 for 1 clk cycle
    // wait until 'o_bcdcount' = ROLLOVER_COUNT
    // observe waveform and check that 'o_bcdcount' is set to 0 after one clk cycle
    
        i_reset_n = 0;
        i_countinit = 1;
        i_countenb = 0;
        i_latchcount = 0;
        #10;
        
        i_reset_n = 1;
        i_countinit = 0;
        #10;
        
        i_countinit = 0;
        i_countenb = 1;
        i_latchcount = 1;
        @(posedge i_rtcclk);
        @(negedge i_rtcclk);
        i_countenb = 0;
        i_latchcount = 0;
        for (i = 0; i < 10; i = i+1) begin      // waiting for 10 clk cycles
            @(posedge i_rtcclk);
            @(negedge i_rtcclk);
        end;
// --------------------- End of COUNTER_TC_03 --------------------------



// --------------------- COUNTER_TC_04 ----------------------------
    // set 'i_reset_n' to 0
    // set 'i_reset_n' to 1
    // enable the counter by setting 'i_countenb' and 'i_latchcount' to 1 for 1 clk cycle
    // wait until 'o_bcdcount' = ROLLOVER_COUNT
    // observe waveform and check that 'o_rolloverflag' is set to 1 after one clk cycle for 1 clk cycle
    
        i_reset_n = 0;
        i_countinit = 1;
        i_countenb = 0;
        i_latchcount = 0;
        #10;
        
        i_reset_n = 1;
        i_countinit = 0;
        #10;
        
        i_countinit = 0;
        i_countenb = 1;
        i_latchcount = 1;
        @(posedge i_rtcclk);
        @(negedge i_rtcclk);
        i_countenb = 0;
        i_latchcount = 0;
        for (i = 0; i < 10; i = i+1) begin      // waiting for 10 clk cycles
            @(posedge i_rtcclk);
            @(negedge i_rtcclk);
        end;
        @(posedge i_rtcclk);
        @(negedge i_rtcclk);
// --------------------- End of COUNTER_TC_04 --------------------------



// --------------------- COUNTER_TC_05 ----------------------------
    // set 'i_reset_n' to 0
    // set 'i_reset_n' to 1
    // enable the counter by setting 'i_countenb' and 'i_latchcount' to 1 for 1 clk cycle
    // wait for rising edge of clk
    // observe waveform and check if 'o_bcdcount' gets incremented on rising edge of clk
    
        i_reset_n = 0;
        i_countinit = 1;
        i_countenb = 0;
        i_latchcount = 0;
        #10;
        
        i_reset_n = 1;
        i_countinit = 0;
        #10;
        
        i_countinit = 0;
        i_countenb = 1;
        i_latchcount = 1;
        @(posedge i_rtcclk);
        @(negedge i_rtcclk);
        i_countenb = 0;
        i_latchcount = 0;
        
        @(posedge i_rtcclk);
        @(negedge i_rtcclk);
        @(posedge i_rtcclk);
        @(negedge i_rtcclk);
        @(posedge i_rtcclk);
        @(negedge i_rtcclk);
    
// --------------------- End of COUNTER_TC_05 --------------------------



// --------------------- COUNTER_TC_06 ----------------------------
    // observe port mapping in the code and check that every input enable signal 
    // of the subcounter modules is connected to the output rollover flag of the 
    // previous subcounter, except for the first subcounter input which is connected 
    // to 'i_countenb' coming from the trigger detection circuit

// --------------------- End of COUNTER_TC_06 --------------------------



// --------------------- COUNTER_TC_07 ----------------------------
    // observe port mapping in the code and check that 'o_count'[3:0] = 'o_bcdcount0'
    
// --------------------- End of COUNTER_TC_07 --------------------------



// --------------------- COUNTER_TC_08 ----------------------------
    // observe port mapping in the code and check that 'o_count'[7:4] = 'o_bcdcount1'
    
// --------------------- End of COUNTER_TC_08 --------------------------



// --------------------- COUNTER_TC_09 ----------------------------
    // observe port mapping in the code and check that 'o_count'[11:8] = 'o_bcdcount2'
    
// --------------------- End of COUNTER_TC_09 --------------------------



// --------------------- COUNTER_TC_10 ----------------------------
    // observe port mapping in the code and check that 'o_count'[15:12] = 'o_bcdcount3'
    
// --------------------- End of COUNTER_TC_10 --------------------------



// --------------------- COUNTER_TC_11 ----------------------------
    // observe port mapping in the code and check that 'o_count'[19:16] = 'o_bcdcount4'
    
// --------------------- End of COUNTER_TC_11 --------------------------



// --------------------- COUNTER_TC_12 ----------------------------
    // observe port mapping in the code and check that 'o_count'[23:20] = 'o_bcdcount5'
    
// --------------------- End of COUNTER_TC_12 --------------------------



// --------------------- COUNTER_TC_13 ----------------------------
    // set 'i_reset_n' to 0
    // set 'i_reset_n' to 1
    // enable the counter by setting 'i_countenb' and 'i_latchcount' to 1 for 1 clk cycle
    // wait for 20 clk cycles
    // observe waveform and check if 'o_count' gets incremented on rising edge of clk
    
        i_reset_n = 0;
        i_countinit = 1;
        i_countenb = 0;
        i_latchcount = 0;
        #10;
        
        i_reset_n = 1;
        i_countinit = 0;
        #10;
        
        i_countinit = 0;
        i_countenb = 1;
        i_latchcount = 1;
        @(posedge i_rtcclk);
        @(negedge i_rtcclk);
        i_countenb = 0;
        i_latchcount = 0;
        for (i = 0; i < 20; i = i+1) begin      // waiting for 10 clk cycles
            @(posedge i_rtcclk);
            @(negedge i_rtcclk);
        end;
        
// --------------------- End of COUNTER_TC_13 --------------------------



// --------------------- COUNTER_TC_14 ----------------------------
    // set 'i_reset_n' to 0
    // set 'i_reset_n' to 1
    // enable the counter by setting 'i_countenb' and 'i_latchcount' to 1 for 1 clk cycle
    // wait until 'o_count' is set to 'h595999
    // wait for one more clk cycle
    // check if 'o_count' is set to 0
    
        i_reset_n = 0;
        i_countinit = 1;
        i_countenb = 0;
        i_latchcount = 0;
        #10;
        
        i_reset_n = 1;
        i_countinit = 0;
        #10;
        
        i_countinit = 0;
        i_countenb = 1;
        i_latchcount = 1;
        @(posedge i_rtcclk);
        @(negedge i_rtcclk);
        i_countenb = 0;
        i_latchcount = 0;
        
        wait (o_count == 'h595999);
        @(posedge i_rtcclk);
        @(negedge i_rtcclk);
        if (o_count == 0)
            $display ("Test case COUNTER_TC_14 passed");
        else
            $display ("Test case COUNTER_TC_14 failed");
    
// --------------------- End of COUNTER_TC_14 --------------------------



// --------------------- COUNTER_TC_15 ----------------------------
    // set 'i_reset_n' to 1
    // enable the counter by setting 'i_countenb' and 'i_latchcount' to 1 for 1 clk cycle
    // wait for 5 clk cycles
    // set 'i_reset_n' to 0
    // check if 'o_count' is set to 0
        i_reset_n = 0;
        i_countinit = 1;
        i_countenb = 0;
        i_latchcount = 0;
        #10;
        
        i_reset_n = 1;
        i_countinit = 0;
        #10;
        
        i_countinit = 0;
        i_countenb = 1;
        i_latchcount = 1;
        @(posedge i_rtcclk);
        @(negedge i_rtcclk);
        i_countenb = 0;
        i_latchcount = 0;
        
        for (i = 0; i < 5; i = i+1) begin
            @(posedge i_rtcclk);
            @(negedge i_rtcclk);
        end;
        
        i_reset_n = 0;
        #10;
        
        if (o_count == 0)
            $display ("Test case COUNTER_TC_15 passed");
        else
            $display ("Test case COUNTER_TC_15 failed");
// --------------------- End of COUNTER_TC_15 --------------------------


endmodule