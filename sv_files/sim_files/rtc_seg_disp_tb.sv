// Author: Antonio Jimenez
// Date: 6/16/2020
// Purpose: This module executes test cases for the 7 Segment Display module

module rtc_seg_disp_tb;

  logic [23:0] i_count;
  logic [7:0]  o_segout1;
  logic [7:0]  o_segout2;
  logic [7:0]  o_segout3;
  logic [7:0]  o_segout4;
  logic [7:0]  o_segout5;
  logic [7:0]  o_segout6;
  
  logic [7:0] seven_seg_code [9:0] = {
    8'b1001_0000,
    8'b1000_0000,
    8'b1111_1000,
    8'b1000_0010,
    8'b1001_0010,
    8'b1001_1001,
    8'b1011_0000,
    8'b1010_0100,
    8'b1111_1001,
    8'b1100_0000
  };

  rtc_seg_disp DUT(
    .i_count   (i_count),
    .o_segout1 (o_segout1),
    .o_segout2 (o_segout2),
    .o_segout3 (o_segout3),
    .o_segout4 (o_segout4),
    .o_segout5 (o_segout5),
    .o_segout6 (o_segout6)
  );

  initial
  begin
    // Initial Start
    i_count = 24'b0000_0000_0000_0000_0000_0000;
    #5;
    
    // SEG_DISP_TC_1
    // Objective: Test if o_segout1 will output the 7-segment code equivalent to the BCD input of i_count[3:0]
    // Steps: 1. Set i_count[3:0] to BCD 0
    //        2. Observe if o_segout1 is outputting the appropriate 7 segment code
    //        3. Increment the BCD input to i_count
    //        4. Repeat steps 2-3 until BCD 9 is input to i_count[3:0] and the 7 segment code is observed through o_segout1
    $display ("--------------------\nSEG_DISP_TC_1 BEGIN\n--------------------\n");
    for (int i = 0; i < 10; i++)
    begin
      assert (o_segout1 == seven_seg_code[i]) $display ("Value = %d\n Expected = %b\n Actual = %b\n PASS\n", i, seven_seg_code[i], o_segout1);
        else $error("Value = %d\n Expected = %b\n Actual = %b\n FAIL\n", i, seven_seg_code[i], o_segout1);
      
      i_count = i_count + 24'b1;
      #5;
    end
    
    $display ("--------------------\nSEG_DISP_TC_1 END\n--------------------\n");
    
    // SEG_DISP_TC_2
    // Objective: Test if o_segout2 will output the 7-segment code equivalent to the BCD input of i_count[7:4]
    // Steps: 1. Set i_count[7:4] to BCD 0
    //        2. Observe if o_segout2 is outputting the appropriate 7 segment code
    //        3. Increment the BCD input to i_count
    //        4. Repeat steps 2-3 until BCD 9 is input to i_count[7:4] and the 7 segment code is observed through o_segout2
    $display ("--------------------\nSEG_DISP_TC_2 BEGIN\n--------------------\n");
    for (int j = 0; j < 10; j++)
    begin
      assert (o_segout2 == seven_seg_code[j]) $display ("Value = %d\n Expected = %b\n Actual = %b\n PASS\n", j, seven_seg_code[j], o_segout2);
        else $error("Value = %d\n Expected = %b\n Actual = %b\n FAIL\n", j, seven_seg_code[j], o_segout2);
      
      i_count = i_count + 24'b1_0000;
      #5;
    end
    
    $display ("--------------------\nSEG_DISP_TC_2 END\n--------------------\n");
    
    // SEG_DISP_TC_3
    // Objective: Test if o_segout3 will output the 7-segment code equivalent to the BCD input of i_count[11:8]
    // Steps: 1. Set i_count[11:8] to BCD 0
    //        2. Observe if o_segout3 is outputting the appropriate 7 segment code
    //        3. Increment the BCD input to i_count
    //        4. Repeat steps 2-3 until BCD 9 is input to i_count[11:8] and the 7 segment code is observed through o_segout3
    $display ("--------------------\nSEG_DISP_TC_3 BEGIN\n--------------------\n");
    for (int k = 0; k < 10; k++)
    begin
      assert (o_segout3 == seven_seg_code[k]) $display ("Value = %d\n Expected = %b\n Actual = %b\n PASS\n", k, seven_seg_code[k], o_segout3);
        else $error("Value = %d\n Expected = %b\n Actual = %b\n FAIL\n", k, seven_seg_code[k], o_segout3);
      
      i_count = i_count + 24'b1_0000_0000;
      #5;
    end
 
    $display ("--------------------\nSEG_DISP_TC_3 END\n--------------------\n");
    
    // SEG_DISP_TC_4
    // Objective: Test if o_segout4 will output the 7-segment code equivalent to the BCD input of i_count[15:12]
    // Steps: 1. Set i_count[15:12] to BCD 0
    //        2. Observe if o_segout4 is outputting the appropriate 7 segment code
    //        3. Increment the BCD input to i_count
    //        4. Repeat steps 2-3 until BCD 9 is input to i_count[15:12] and the 7 segment code is observed through o_segout4
    $display ("--------------------\nSEG_DISP_TC_4 BEGIN\n--------------------\n");
    for (int l = 0; l < 10; l++)
    begin
      assert (o_segout4 == seven_seg_code[l]) $display ("Value = %d\n Expected = %b\n Actual = %b\n PASS\n", l, seven_seg_code[l], o_segout4);
        else $error("Value = %d\n Expected = %b\n Actual = %b\n FAIL\n", l, seven_seg_code[l], o_segout4);
      
      i_count = i_count + 24'b1_0000_0000_0000;
      #5;
    end
    
    $display ("--------------------\nSEG_DISP_TC_4 END\n--------------------\n");
    
    // SEG_DISP_TC_5
    // Objective: Test if o_segout5 will output the 7-segment code equivalent to the BCD input of i_count[19:16]
    // Steps: 1. Set i_count[19:16] to BCD 0
    //        2. Observe if o_segout5 is outputting the appropriate 7 segment code
    //        3. Increment the BCD input to i_count
    //        4. Repeat steps 2-3 until BCD 9 is input to i_count[19:16] and the 7 segment code is observed through o_segout5
    $display ("--------------------\nSEG_DISP_TC_5 BEGIN\n--------------------\n");
    for (int m = 0; m < 10; m++)
    begin
      assert (o_segout5 == seven_seg_code[m]) $display ("Value = %d\n Expected = %b\n Actual = %b\n PASS\n", m, seven_seg_code[m], o_segout5);
        else $error("Value = %d\n Expected = %b\n Actual = %b\n FAIL\n", m, seven_seg_code[m], o_segout5);
      
      i_count = i_count + 24'b1_0000_0000_0000_0000;
      #5;
    end
    
    $display ("--------------------\nSEG_DISP_TC_5 END\n--------------------\n");
    
    // SEG_DISP_TC_6
    // Objective: Test if o_segout6 will output the 7-segment code equivalent to the BCD input of i_count[23:20]
    // Steps: 1. Set i_count[23:20] to BCD 0
    //        2. Observe if o_segout6 is outputting the appropriate 7 segment code
    //        3. Increment the BCD input to i_count
    //        4. Repeat steps 2-3 until BCD 9 is input to i_count[23:20] and the 7 segment code is observed through o_segout6
    $display ("--------------------\nSEG_DISP_TC_6 BEGIN\n--------------------\n");
    for (int n = 0; n < 10; n++)
    begin
      assert (o_segout6 == seven_seg_code[n]) $display ("Value = %d\n Expected = %b\n Actual = %b\n PASS\n", n, seven_seg_code[n], o_segout6);
        else $error("Value = %d\n Expected = %b\n Actual = %b\n FAIL\n", n, seven_seg_code[n], o_segout6);
      
      i_count = i_count + 24'b1_0000_0000_0000_0000_0000;
      #5;
    end
    
    $display ("--------------------\nSEG_DISP_TC_6 END\n--------------------\n");
  end

endmodule
