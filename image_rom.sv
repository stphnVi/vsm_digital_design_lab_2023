module image_rom
#(parameter WIDTH = 8, LENGTH = (256*256))
(
	input clk, 
	input [31:0] r_addr,
	output reg [(WIDTH-1):0] rd
);
	reg [WIDTH-1:0] rom[LENGTH-1:0];

	initial begin
		//$readmemb("../../code/build/image.txt", rom);
		//$readmemb(dir,rom);
		//$readmemb("C:/Users/valer/OneDrive/Documentos/GitHub/vsm_digital_design_lab_2023/imageToHex/image.txt",rom);
		$readmemh("C:/Users/steph/OneDrive/Documentos/GitHub/vsm_digital_design_lab_2023/memfile.dat",rom);
	end

	always @ (posedge clk)
	begin
		rd <= rom[r_addr];
	end
endmodule