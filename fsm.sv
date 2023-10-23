module fsm( SW, LEDR );

	input bit 	[4:0] SW;
	output bit 	[2:0] LEDR;
	
	enum {
		MS_GREEN		= 0,
		MS_YELLOW	= 1,
		MS_RED		= 2
	} state, next_state;
	
	
	always_comb begin
	
		case (state)
		
			MS_GREEN : next_state = SW[0] ? MS_YELLOW : MS_GREEN;
			
			MS_YELLOW : next_state = SW[1] ? MS_RED : MS_YELLOW;
			
			MS_RED : next_state = SW[2] ? MS_GREEN : MS_RED;
			
		endcase
	
	end
	
	always_ff @(posedge SW[4]) begin
	
		if (SW[3])
			state <= MS_GREEN;
		else
			state <= next_state;
	
	end
	
	always_comb begin
	
		case (state)
			
			MS_GREEN: 	LEDR = 3'b100;
			
			MS_YELLOW: 	LEDR = 3'b010;
			
			MS_RED: 		LEDR = 3'b001;
			
		endcase
	
	end
	

endmodule
