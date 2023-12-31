module vga_ram #(parameter DATA_WIDTH=8, parameter LENGTH=256*256)
(
    input we, r_clk, w_clk,
	input [(DATA_WIDTH-1):0] wd,
	input [31:0] r_addr, w_addr,
	output reg [(DATA_WIDTH-1):0] rd
);

// declarar la RAM variable
	reg [DATA_WIDTH-1:0] ram[LENGTH-1:0];
	
	initial begin
		//$readmemh("C:/Users/valer/OneDrive/Documentos/GitHub/vsm_digital_design_lab_2023/imageToHex/image.txt",ram);
		$readmemb("C:/Users/steph/OneDrive/Documentos/GitHub/vsm_digital_design_lab_2023/imageToHex/image.txt",ram);
	end
	
	always @ (posedge w_clk)
	begin
		// escribir
		if (we)
			ram[w_addr] <= wd;
	end
	
	always @ (posedge r_clk)
	begin
		// leer
		rd <= ram[r_addr];
	end
endmodule