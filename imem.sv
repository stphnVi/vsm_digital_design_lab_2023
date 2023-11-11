module imem(input logic [31:0] a,
				output logic [31:0] rd);
	logic [31:0] RAM[63:0];

	initial
		$readmemh("C:/Users/steph/OneDrive/Documentos/GitHub/vsm_digital_design_lab_2023/memfile.dat",RAM);
	assign rd = RAM[a[31:2]]; // word aligned
	
endmodule