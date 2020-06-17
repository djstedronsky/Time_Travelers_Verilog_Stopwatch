//////////////////////////////////////////////////////////////////////////////////
/*--------------------------------------------------------------------------------
  Project: Stopwatch
  Module: Counter Test Bench
  Author: Waseem Orphali
  Date: 06/16/2020
---------------------------------------------------------------------------------*/
`timescale 1ns/1ns

module rtc_counter_tb;

    reg i_rtcclk = 0;
    reg i_reset_n = 0;
    reg i_countenb = 0;
    reg i_countinit = 1;
    reg i_latchcount = 0;
    wire [23:0] o_count;

    integer i = 0;
    
    rtc_24bitcounter dut (
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
        
        assert (dut.d1.o_bcdcount == 4'h0)
            $display("Test case COUNTER_TC_01 passed\n");
        else
            $display("Test case COUNTER_TC_01 failed, Expected = 0000\tActual = %b\n", dut.d1.o_bcdcount);
        i_reset_n = 0;
        # 10;

// --------------------- End of COUNTER_TC_01 --------------------------



// --------------------- COUNTER_TC_02 ----------------------------
    // set 'i_reset_n' to 1
    // enable the counter by setting 'i_countenb' and 'i_latchcount' to 1
    // set 'i_reset_n' to 0
    // observe waveform and check if the internal signal 'o_bcdcount' got set to 0
    
        i_reset_n = 1;
        i_countinit = 0;
        #10;
        
        i_countenb = 1;
        i_latchcount = 1;
        @(posedge i_rtcclk);
        @(negedge i_rtcclk);
        #20;
        
        i_reset_n = 0;
        #10;
        assert (dut.d1.o_bcdcount == 4'h0)
            $display("Test case COUNTER_TC_02 passed\n");
        else
            $display("Test case COUNTER_TC_02 failed, Expected = 0000\tActual = %b\n", dut.d1.o_bcdcount);
// --------------------- End of COUNTER_TC_02 --------------------------


        
// --------------------- COUNTER_TC_03 ----------------------------
    // set 'i_reset_n' to 0
    // set 'i_reset_n' to 1
    // enable the counter by setting 'i_countenb' and 'i_latchcount' to 1
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
        wait (dut.d1.o_bcdcount == 4'h9);
        @(posedge i_rtcclk);
        @(negedge i_rtcclk);
        assert (dut.d1.o_bcdcount == 4'h0)
            $display("Test case COUNTER_TC_03 passed\n");
        else
            $display("Test case COUNTER_TC_03 failed, Expected = 0000\tActual = %b\n", dut.d1.o_bcdcount);
// --------------------- End of COUNTER_TC_03 --------------------------



// --------------------- COUNTER_TC_04 ----------------------------
    // set 'i_reset_n' to 0
    // set 'i_reset_n' to 1
    // enable the counter by setting 'i_countenb' and 'i_latchcount' to 1
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
        wait (dut.d1.o_bcdcount == 4'h9);
        @(posedge i_rtcclk);
        @(negedge i_rtcclk);
        if (dut.d1.o_rolloverflag == 1) begin
            @(posedge i_rtcclk);
            @(negedge i_rtcclk);
            if (dut.d1.o_rolloverflag == 0)
                $display("Test case COUNTER_TC_04 passed\n");
            else
                $display("Test case COUNTER_TC_04 failed, o_rolloverflag didn't pulse for 1 clk cycle");
        end else
            $display("Test case COUNTER_TC_04 failed, o_rolloverflag didn't pulse for 1 clk cycle");
// --------------------- End of COUNTER_TC_04 --------------------------



// --------------------- COUNTER_TC_05 ----------------------------
    // set 'i_reset_n' to 0
    // set 'i_reset_n' to 1
    // enable the counter by setting 'i_countenb' and 'i_latchcount' to 1
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
        wait (dut.d1.o_bcdcount == 4'h5);
        @(posedge i_rtcclk);
        @(negedge i_rtcclk);
        assert (dut.d1.o_bcdcount == 4'h6)
            $display("Test case COUNTER_TC_05 passed\n");
        else
            $display("Test case COUNTER_TC_05 failed, o_bcdcount didn't increment on the rising edge of the clk");
    
// --------------------- End of COUNTER_TC_05 --------------------------



// --------------------- COUNTER_TC_06 ----------------------------
    // observe port mapping in the code and check that every input enable signal 
    // of the subcounter modules is connected to the output rollover flag of the 
    // previous subcounter, except for the first subcounter input which is connected 
    // to 'i_countenb' coming from the trigger detection circuit

// --------------------- End of COUNTER_TC_06 --------------------------



// --------------------- COUNTER_TC_07 ----------------------------
    // observe port mapping in the code and check that 'o_count'[3:0] = 'o_bcdcount0'
        assert (dut.d1.o_bcdcount == o_count[3:0])
            $display("Test case COUNTER_TC_07 passed\n");
        else
            $display("Test case COUNTER_TC_07 failed, o_bcdcount0 != o_count[3:0]\n");
    
// --------------------- End of COUNTER_TC_07 --------------------------



// --------------------- COUNTER_TC_08 ----------------------------
    // observe port mapping in the code and check that 'o_count'[7:4] = 'o_bcdcount1'
        assert (dut.d2.o_bcdcount == o_count[7:4])
            $display("Test case COUNTER_TC_08 passed\n");
        else
            $display("Test case COUNTER_TC_08 failed, o_bcdcount1 != o_count[7:4]\n");
            
// --------------------- End of COUNTER_TC_08 --------------------------



// --------------------- COUNTER_TC_09 ----------------------------
    // observe port mapping in the code and check that 'o_count'[11:8] = 'o_bcdcount2'
        assert (dut.d3.o_bcdcount == o_count[11:8])
            $display("Test case COUNTER_TC_09 passed\n");
        else
            $display("Test case COUNTER_TC_09 failed, o_bcdcount2 != o_count[11:8]\n");
            
// --------------------- End of COUNTER_TC_09 --------------------------



// --------------------- COUNTER_TC_10 ----------------------------
    // observe port mapping in the code and check that 'o_count'[15:12] = 'o_bcdcount3'
        assert (dut.d4.o_bcdcount == o_count[15:12])
            $display("Test case COUNTER_TC_10 passed\n");
        else
            $display("Test case COUNTER_TC_10 failed, o_bcdcount3 != o_count[15:12]\n");
            
// --------------------- End of COUNTER_TC_10 --------------------------



// --------------------- COUNTER_TC_11 ----------------------------
    // observe port mapping in the code and check that 'o_count'[19:16] = 'o_bcdcount4'
        assert (dut.d5.o_bcdcount == o_count[19:16])
            $display("Test case COUNTER_TC_11 passed\n");
        else
            $display("Test case COUNTER_TC_11 failed, o_bcdcount4 != o_count[19:16]\n");
            
// --------------------- End of COUNTER_TC_11 --------------------------



// --------------------- COUNTER_TC_12 ----------------------------
    // observe port mapping in the code and check that 'o_count'[23:20] = 'o_bcdcount5'
        assert (dut.d6.o_bcdcount == o_count[23:20])
            $display("Test case COUNTER_TC_12 passed\n");
        else
            $display("Test case COUNTER_TC_12 failed, o_bcdcount5 != o_count[23:20]\n");
            
// --------------------- End of COUNTER_TC_12 --------------------------



// --------------------- COUNTER_TC_13 ----------------------------
    // set 'i_reset_n' to 0
    // set 'i_reset_n' to 1
    // enable the counter by setting 'i_countenb' and 'i_latchcount' to 1
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
        
        wait (o_count == 4'h5);
        @(posedge i_rtcclk);
        @(negedge i_rtcclk);
        assert (dut.d1.o_bcdcount == 4'h6)
            $display("Test case COUNTER_TC_13 passed\n");
        else
            $display("Test case COUNTER_TC_13 failed, o_count didn't increment on the rising edge of the clk");
        
// --------------------- End of COUNTER_TC_13 --------------------------



// --------------------- COUNTER_TC_14 ----------------------------
    // set 'i_reset_n' to 0
    // set 'i_reset_n' to 1
    // enable the counter by setting 'i_countenb' and 'i_latchcount' to 1
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
        
        wait (o_count == 'h595999);
        @(posedge i_rtcclk);
        @(negedge i_rtcclk);
        if (o_count == 0)
            $display ("Test case COUNTER_TC_14 passed at time %0t", $time);
        else
            $display ("Test case COUNTER_TC_14 failed");
    
// --------------------- End of COUNTER_TC_14 --------------------------



// --------------------- COUNTER_TC_15 ----------------------------
    // set 'i_reset_n' to 1
    // enable the counter by setting 'i_countenb' and 'i_latchcount' to 1
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
        
        for (i = 0; i < 5; i = i+1) begin
            @(posedge i_rtcclk);
            @(negedge i_rtcclk);
        end;
        
        i_reset_n = 0;
        #10;
        
        if (o_count == 0)
            $display ("Test case COUNTER_TC_15 passed at time %0t", $time);
        else
            $display ("Test case COUNTER_TC_15 failed");
// --------------------- End of COUNTER_TC_15 --------------------------
    end;

endmodule