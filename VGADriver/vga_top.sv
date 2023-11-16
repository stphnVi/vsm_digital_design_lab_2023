`timescale 1ns / 1ps

module vga_top(
	input clk_50MHz,      
	input reset,
	input [23:0] sw,       
	output hsync, 
	output vsync,
	output [23:0] rgb,      
	output p_tick,
	output sync,
	output blank
);
	

	wire video_on;
	wire [23:0] rgb_w;    
	reg [9:0] current_x = 0;
	reg [9:0] current_y = 0;
	reg [9:0] next_x, next_y;
	
	
	reg toggle = 1'b0;
	
	wire misc_clk, clk_vga,ssa, locked;
	 
	 clock_div #(.DIV(25000000)) divider(.clk_in(clk_vga), .clk_out(misc_clk));
	 clock_div #(.DIV(2)) divider2(.clk_in(clk_50MHz), .clk_out(clk_vga));
	 assign p_tick = clk_vga;
	 
	
	 
    
    vga_driver vga_c(
			.clk(clk_vga), 
			.reset(reset), 
			.hsync(hsync), 
			.vsync(vsync),
			.video_on(video_on), 
			.x(next_x), 
			.y(next_y), 
			.sync(sync), 
			.blank(blank));
	 

    
    always @(posedge clk_vga or posedge reset) begin
		if (reset) begin
			current_x <= 0;
			current_y <= 0;
		end else begin
			current_x <= next_x;
			current_y <= next_y;
		end
	 end
	 
    assign rgb = (video_on) ? rgb_w : 24'b0;   // while in display area RGB color = sw, else all OFF
        
endmodule