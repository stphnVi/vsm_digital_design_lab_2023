module vga_driver(
    input clk,   				// clock 25Mhz
    input reset,        	// reset
    output video_on,    	// area de display
    output logic hsync,      // sincronizacion horizontal
    output logic vsync,      // sincronizacion vertical
    output [9:0] x,    // posicion x del pixel, 0-799
    output [9:0] y,    // posicion y del pixel, 0-524
	 output sync, 				// sync simultaneo
	 output blank	//señal de blank de dac VGA
    );
	 
    // Limites horizontales (en cuenta de pixeles). Total = 800 pixels
    parameter H_DISPLAY = 640;            
    parameter H_FRONT_PORCH = 16; 
    parameter H_BACK_PORCH = 48;       
    parameter H_PULSE = 96;             
    parameter HMAX = H_DISPLAY+H_FRONT_PORCH+H_BACK_PORCH+H_PULSE-1; // max val = 799
    // Limites verticales (en cuenta de pixeles). Total = 525 pixels
    parameter V_DISPLAY = 480;              
    parameter V_FRONT_PORCH = 10;            
    parameter V_BACK_PORCH = 33;       
    parameter V_PULSE = 2;      
    parameter VMAX = V_DISPLAY+V_FRONT_PORCH+V_BACK_PORCH+V_PULSE-1; // max val = 524   

    // -------------------------------
	 wire htc;
	 counter #(10) h_counter(.clk(clk), .enable(1'b1), .reset(reset), .load(HMAX), .tc(htc), .q(x));
	 counter #(10) v_counter(.clk(clk), .enable(htc), .reset(reset), .load(VMAX), .tc(1'b0), .q(y));
	 
	 wire x_active, y_active, x_before_pulse, x_after_pulse, y_before_pulse, y_after_pulse;
	 comparator #(10) comp_hd(.a(x), .b(H_DISPLAY), .le(x_active));
	 comparator #(10) comp_vd(.a(y), .b(V_DISPLAY), .le(y_active));
	 comparator #(10) comp_hsync1(.a(x), .b(H_DISPLAY + H_FRONT_PORCH-1), .le(x_before_pulse));
	 comparator #(10) comp_hsync2(.a(x), .b(H_DISPLAY + H_FRONT_PORCH + H_PULSE+1), .ge(x_after_pulse));
	 comparator #(10) comp_vsync1(.a(y), .b(V_DISPLAY + V_FRONT_PORCH-1), .le(y_before_pulse));
	 comparator #(10) comp_vsync2(.a(y), .b(V_DISPLAY + V_FRONT_PORCH + V_PULSE+1), .ge(y_after_pulse));
	 
	 or hs(hsync, x_before_pulse, x_after_pulse);
	 or vs(vsync, y_before_pulse, y_after_pulse);
	 	/*always @(posedge clk) begin   	 
        if(reset) begin
				hsync <= 0;
				vsync <= 0;
        end else begin
				// sync solo es low en pulse
				hsync <= x_before_pulse || x_after_pulse; 
				vsync <= y_before_pulse || y_after_pulse;
			end
		end*/
	 
	 and(video_on, x_active, y_active);
	 and(blank, hsync, vsync);
	 assign sync = 1'b_0 ;
            
endmodule