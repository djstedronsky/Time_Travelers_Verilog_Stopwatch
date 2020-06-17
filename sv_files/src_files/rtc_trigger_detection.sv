// Author: Antonio Jimenez
// Date: 6/12/2020
// Purpose: This module enables the 24-Bit counter module to count based
//          on the pulse sent to the i_trigger input.

module rtc_trigger_detection (
  input  logic i_sclk,
  input  logic i_reset_n,
  input  logic i_trigger,
  output logic o_countinit,
  output logic o_countenb,
  output logic o_latchcount
);

  logic dff0_output;
  logic dff1_output;
  logic debounced_i_trigger;

  always_ff @(negedge i_reset_n, posedge i_sclk)
  begin
    if (~i_reset_n) begin
	  dff0_output <= 0;
	end else begin
	  dff0_output <= i_trigger;
	end
  end
  
  always_ff @(negedge i_reset_n, posedge i_sclk)
  begin
    if (~i_reset_n) begin
	  dff1_output <= 0;
	end else begin
	  dff1_output <= dff0_output;
	end
  end
  
  assign debounced_i_trigger = dff0_output & (~dff1_output);

  always_ff @(negedge i_reset_n, posedge i_sclk)
  begin
    if (~i_reset_n) begin
	  o_countinit  <= 1;
	  o_countenb   <= 0;
	  o_latchcount <= 0;
	end else if (debounced_i_trigger) begin
	  o_countinit  <= 0;
	  o_countenb   <= ~o_countenb;
	  o_latchcount <= ~o_latchcount;
	end else begin
	  o_countinit  <= 0;
	  o_countenb   <= o_countenb;
	  o_latchcount <= o_latchcount;
	end
  end

endmodule
