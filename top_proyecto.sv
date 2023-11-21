module top_proyecto(
	input clk_50MHz,      
	//input reset,
	input ctrl_flag_1,
	input ctrl_flag_2,
	//señales VGA
	output hsync, 
	output vsync,
	output [7:0] rgb_r,
	output [7:0] rgb_g,
	output [7:0] rgb_b,	
	output clk_vga,
	output sync,
	output blank
);

logic reset;
assign reset = 0;

clock_divider #(.DIV(2)) divider2(.clk_in(clk_50MHz), .clk_out(clk_vga));

//graficos
wire video_on;
wire [23:0] rgb_w;
wire [7:0] gray_val;    
reg [9:0] current_x = 0;
reg [9:0] current_y = 0;
reg [9:0] next_x, next_y;
reg [31:0] ctrl_val1, ctrl_val2;

wire [31:0] img_ram_addr;
assign img_ram_addr = ((next_x < 256) && (next_y <256))? ((next_y*256)+next_x) : 32'h0;

always @(posedge clk_50MHz, posedge reset) begin 
	if(reset) begin
		ctrl_val1 <= 0;
		ctrl_val2 <= 0;
	end 
	else begin 
		if(~ctrl_flag_1) ctrl_val1 <= 32'b1;
		if(~ctrl_flag_2) ctrl_val2 <= 32'b1;
	end 
end

vga_driver vga_inst(
		.clk(clk_vga), 
		.reset(reset), 
		.hsync(hsync), 
		.vsync(vsync),
		.video_on(video_on), 
		.x(next_x), 
		.y(next_y), 
		.sync(sync), 
		.blank(blank));
		
top cpu_top(
	.clk(clk_50MHz),
	.clk_vga(clk_vga),
	.reset(reset), 
   .ctrl_val1(ctrl_val1), 
	.ctrl_val2(ctrl_val2),
	.vga_pixel_addr(img_ram_addr),
	.vga_pixel_val(gray_val)
);

assign rgb_w = {gray_val, gray_val, gray_val};
 
always @(posedge clk_vga or posedge reset) begin
	if (reset) begin
		current_x <= 0;
		current_y <= 0;
	end else begin
		current_x <= next_x;
		current_y <= next_y;
	end
 end
 
assign rgb_r = (video_on) ? rgb_w[23:16] : 8'b0; 
assign rgb_g = (video_on) ? rgb_w[15:8] : 8'b0; 
assign rgb_b = (video_on) ? rgb_w[7:0] : 8'b0; 


endmodule