// Author: Antonio Jimenez
// Date: 6/16/2020
// Purpose: This module executes test cases for the 7 Segment Adapter module
`timescale 1ns/1ps

module rtc_seg_adap_tb;

  logic i_sys_clk = 1'b0; 
  logic i_reset_n = 1'b1;
  logic [7:0] i_segout1;
  logic [7:0] i_segout2;
  logic [7:0] i_segout3;
  logic [7:0] i_segout4;
  logic [7:0] i_segout5;
  logic [7:0] i_segout6;
  logic [7:0] o_segments;
  logic [7:0] o_digits;

  rtc_seg_adap DUT (
    .i_sys_clk  (i_sys_clk), 
    .i_reset_n  (i_reset_n), 
    .i_segout1  (i_segout1), 
    .i_segout2  (i_segout2), 
    .i_segout3  (i_segout3), 
    .i_segout4  (i_segout4),
    .i_segout5  (i_segout5), 
    .i_segout6  (i_segout6), 
    .o_segments (o_segments),
    .o_digits   (o_digits)   
  );
  
  initial
  begin
    // Initial Start
    i_segout1 = 7'b0000_0000;
    i_segout2 = 7'b0000_0000;
    i_segout3 = 7'b0000_0000;
    i_segout4 = 7'b0000_0000;
    i_segout5 = 7'b0000_0000;
    i_segout6 = 7'b0000_0000;
    
    // SEG_ADAP_TC_01
    // Objective: Test if o_segments = 8'b0000_0000 when i_reset_n = 1'b0
    // Steps: 1. Set i_reset_n to 0
    //        2. Observe o_segments is 8'b0000_0000
    $display ("--------------------\nSEG_ADAP_TC_01 BEGIN\n--------------------\n");
    i_reset_n = 0;
    #5;
    $display ("Expected = 00000000\nActual = %b\n", o_segments);
    assert (o_segments == 8'b0000_0000) $display ("PASS\n");
      else $error("FAIL\n");
    $display ("--------------------\nSEG_ADAP_TC_01 END\n--------------------\n");
    
    // SEG_ADAP_TC_02
    // Objective: Test if o_digits = 8'b0000_0000 when i_reset_n = 1'b0
    // Steps: 1. Set i_reset_n to 0
    //        2. Observe o_digits is 8'b0000_0000
    $display ("--------------------\nSEG_ADAP_TC_02 BEGIN\n--------------------\n");
    i_reset_n = 0;
    #5;
    $display ("Expected = 00000000\nActual = %b\n", o_digits);
    assert (o_digits == 8'b0000_0000) $display ("PASS\n");
      else $error("FAIL\n");
    $display ("--------------------\nSEG_ADAP_TC_02 END\n--------------------\n");
    
    i_reset_n = 1;
    #5;
    
    // SEG_ADAP_TC_03
    // Objective: Observe if o_segments cycles through outputs i_segout1 - i_segout6 every millisecond
    // Steps: 1. Set i_segout1 - i_segout6 to different values
    //        2. Set i_reset_n to 0 for 5 ms
    //        3. Set i_reset_n to 1
    //        4. Observe that o_segments change value every millisecond for 12 milliseconds
    //           corresponding to the inputs of i_segout1 - i_segout6
    $display ("--------------------\nSEG_ADAP_TC_03 BEGIN\n--------------------\n");
    i_segout1 = 8'b1111_1001;
    i_segout2 = 8'b1010_0100;
    i_segout3 = 8'b1011_0000;
    i_segout4 = 8'b1001_1001;
    i_segout5 = 8'b1001_0010;
    i_segout6 = 8'b1000_0010;
    i_reset_n = 0;
    #5;
    i_reset_n = 1;
    #5;
    
    for (int i = 0; i < 1200000; i++)
    begin
      tick;
    end
    $display ("Observe Waveform\n");
    $display ("--------------------\nSEG_ADAP_TC_03 END\n--------------------\n");
    
    // SEG_ADAP_TC_04
    // Objective: Observe if o_segments outputs the input of i_segout1 for the 1st, 7th, and
    //            13th millisecond after reset
    // Steps: 1. Set i_segout1 to 8'b1111_1111 and the other i_segouts to 8'b0000_0000
    //        2. Set i_reset_n to 0 for 5 ns
    //        3. Set i_reset_n to 1
    //        4. Observe o_segments outputs i_segout1 three times over the duration of 18 ms
    $display ("--------------------\nSEG_ADAP_TC_04 BEGIN\n--------------------\n");
    i_segout1 = 8'b1111_1111;
    i_segout2 = 8'b0000_0000;
    i_segout3 = 8'b0000_0000;
    i_segout4 = 8'b0000_0000;
    i_segout5 = 8'b0000_0000;
    i_segout6 = 8'b0000_0000;
    i_reset_n = 0;
    #5;
    i_reset_n = 1;
    #5;
    
    for (int i = 0; i < 1800000; i++)
    begin
      tick;
    end
    $display ("Observe Waveform\n");
    $display ("--------------------\nSEG_ADAP_TC_04 END\n--------------------\n");
    
    // SEG_ADAP_TC_05
    // Objective: Observe if o_segments outputs the input of i_segout2 for the 2nd, 8th, and
    //            14th millisecond after reset
    // Steps: 1. Set i_segout2 to 8'b1111_1111 and the other i_segouts to 8'b0000_0000
    //        2. Set i_reset_n to 0 for 5 ns
    //        3. Set i_reset_n to 1
    //        4. Observe o_segments outputs i_segout2 three times over the duration of 18 ms
    $display ("--------------------\nSEG_ADAP_TC_05 BEGIN\n--------------------\n");
    i_segout1 = 8'b0000_0000;
    i_segout2 = 8'b1111_1111;
    i_segout3 = 8'b0000_0000;
    i_segout4 = 8'b0000_0000;
    i_segout5 = 8'b0000_0000;
    i_segout6 = 8'b0000_0000;
    i_reset_n = 0;
    #5;
    i_reset_n = 1;
    #5;
    
    for (int i = 0; i < 1800000; i++)
    begin
      tick;
    end
    $display ("Observe Waveform\n");
    $display ("--------------------\nSEG_ADAP_TC_05 END\n--------------------\n");
    
    // SEG_ADAP_TC_06
    // Objective: Observe if o_segments outputs the input of i_segout3 for the 3rd, 9th, and
    //            15th millisecond after reset
    // Steps: 1. Set i_segout3 to 8'b1111_1111 and the other i_segouts to 8'b0000_0000
    //        2. Set i_reset_n to 0 for 5 ns
    //        3. Set i_reset_n to 1
    //        4. Observe o_segments outputs i_segout3 three times over the duration of 18 ms
    $display ("--------------------\nSEG_ADAP_TC_06 BEGIN\n--------------------\n");
    i_segout1 = 8'b0000_0000;
    i_segout2 = 8'b0000_0000;
    i_segout3 = 8'b1111_1111;
    i_segout4 = 8'b0000_0000;
    i_segout5 = 8'b0000_0000;
    i_segout6 = 8'b0000_0000;
    i_reset_n = 0;
    #5;
    i_reset_n = 1;
    #5;
    
    for (int i = 0; i < 1800000; i++)
    begin
      tick;
    end
    $display ("Observe Waveform\n");
    $display ("--------------------\nSEG_ADAP_TC_06 END\n--------------------\n");
    
    // SEG_ADAP_TC_07
    // Objective: Observe if o_segments outputs the input of i_segout4 for the 4th, 10th, and
    //            16th millisecond after reset
    // Steps: 1. Set i_segout4 to 8'b1111_1111 and the other i_segouts to 8'b0000_0000
    //        2. Set i_reset_n to 0 for 5 ns
    //        3. Set i_reset_n to 1
    //        4. Observe o_segments outputs i_segout4 three times over the duration of 18 ms
    $display ("--------------------\nSEG_ADAP_TC_07 BEGIN\n--------------------\n");
    i_segout1 = 8'b0000_0000;
    i_segout2 = 8'b0000_0000;
    i_segout3 = 8'b0000_0000;
    i_segout4 = 8'b1111_1111;
    i_segout5 = 8'b0000_0000;
    i_segout6 = 8'b0000_0000;
    i_reset_n = 0;
    #5;
    i_reset_n = 1;
    #5;
    
    for (int i = 0; i < 1800000; i++)
    begin
      tick;
    end
    $display ("Observe Waveform\n");
    $display ("--------------------\nSEG_ADAP_TC_07 END\n--------------------\n");
    
    // SEG_ADAP_TC_08
    // Objective: Observe if o_segments outputs the input of i_segout5 for the 5th, 11th, and
    //            17th millisecond after reset
    // Steps: 1. Set i_segout5 to 8'b1111_1111 and the other i_segouts to 8'b0000_0000
    //        2. Set i_reset_n to 0 for 5 ns
    //        3. Set i_reset_n to 1
    //        4. Observe o_segments outputs i_segout5 three times over the duration of 18 ms
    $display ("--------------------\nSEG_ADAP_TC_08 BEGIN\n--------------------\n");
    i_segout1 = 8'b0000_0000;
    i_segout2 = 8'b0000_0000;
    i_segout3 = 8'b0000_0000;
    i_segout4 = 8'b0000_0000;
    i_segout5 = 8'b1111_1111;
    i_segout6 = 8'b0000_0000;
    i_reset_n = 0;
    #5;
    i_reset_n = 1;
    #5;
    
    for (int i = 0; i < 1800000; i++)
    begin
      tick;
    end
    $display ("Observe Waveform\n");
    $display ("--------------------\nSEG_ADAP_TC_08 END\n--------------------\n");
    
    // SEG_ADAP_TC_09
    // Objective: Observe if o_segments outputs the input of i_segout6 for the 6th, 12th, and
    //            18th millisecond after reset
    // Steps: 1. Set i_segout6 to 8'b1111_1111 and the other i_segouts to 8'b0000_0000
    //        2. Set i_reset_n to 0 for 5 ns
    //        3. Set i_reset_n to 1
    //        4. Observe o_segments outputs i_segout6 three times over the duration of 18 ms
    $display ("--------------------\nSEG_ADAP_TC_09 BEGIN\n--------------------\n");
    i_segout1 = 8'b0000_0000;
    i_segout2 = 8'b0000_0000;
    i_segout3 = 8'b0000_0000;
    i_segout4 = 8'b0000_0000;
    i_segout5 = 8'b0000_0000;
    i_segout6 = 8'b1111_1111;
    i_reset_n = 0;
    #5;
    i_reset_n = 1;
    #5;
    
    for (int i = 0; i < 1800000; i++)
    begin
      tick;
    end
    $display ("Observe Waveform\n");
    $display ("--------------------\nSEG_ADAP_TC_09 END\n--------------------\n");
    
    // SEG_ADAP_TC_10
    // Objective: Observe if o_digits outputs a one-hot encoded bit vector, cycling through
    //            6 possibilities every 6 milliseconds
    // Steps: 1. Set i_reset_n to 0 for 5 ns
    //        2. Set i_reset_n to 1
    //        3. Observe o_digits outputs over the duration of 12 milliseconds
    $display ("--------------------\nSEG_ADAP_TC_10 BEGIN\n--------------------\n");
    i_segout1 = 8'b0000_0000;
    i_segout2 = 8'b0000_0000;
    i_segout3 = 8'b0000_0000;
    i_segout4 = 8'b0000_0000;
    i_segout5 = 8'b0000_0000;
    i_segout6 = 8'b0000_0000;
    i_reset_n = 0;
    #5;
    i_reset_n = 1;
    #5;
    
    for (int i = 0; i < 1200000; i++)
    begin
      tick;
    end
    $display ("Observe Waveform\n");
    $display ("--------------------\nSEG_ADAP_TC_10 END\n--------------------\n");
   
  end
  
  task tick;
  begin
    i_sys_clk = 1; #5;
    i_sys_clk = 0; #5;
  end
  endtask

endmodule
