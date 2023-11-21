module testbench();
	logic vga_clk, clk;
	logic reset;
	logic [31:0] vga_pixel_addr = 32'd294;
	logic  [7:0] vga_pixel_val;
	reg [31:0] ctrl_val
	
	clock_div #(.DIV(2)) divider2(.clk_in(clk), .clk_out(clk_vga));
	proyecto_cpu_top dut(
    .clk_vga(clk_vga), 
    .clk(clk), 
    .reset(reset),
    .ctrl_val_1(ctrl_val_1), .ctrl_val_2(ctrl_val_2), .ctrl_val_3(ctrl_val_3),
    .vga_pixel_addr(vga_pixel_addr), 
    .vga_pixel_val(vga_pixel_val)
	);

	// initialize test
	initial
	begin
	ctrl_val <=32'b1;
	reset <= 1; #20; reset <= 0;
	ctrl_val <=32'b0;
	#200
	reset <= 1; #20; reset <= 0;
	#200
	ctrl_val <=32'b1;

	end
	// generate clock to sequence tests
	always
	begin
	clk <= 1; # 5; clk <= 0; # 5;
	end

	always @(negedge clk)
	begin
	if(vga_pixel_val == 8'b00011100) begin
			  $display("Simulation succeeded");
			  $stop;
	end
	end
endmodule