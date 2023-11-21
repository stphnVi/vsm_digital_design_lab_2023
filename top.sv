module top(input 	 logic 			clk_vga, clk, reset,
				input [31:0] vga_pixel_addr,
				input [31:0] ctrl_val,
				output [7:0] vga_pixel_val);
				
	logic [31:0] PCNext, Instr, ReadData;
	
	logic cpu_clock;
	
	logic [31:0] WriteData, DataAdr;
	logic MemWrite;

	// instantiate processor and memories
	
	clock_divider #(.DIV(4)) divider2(.clk_in(clk), .clk_out(cpu_clock));
	
	wire [31:0] instr_addr; 
	assign instr_addr = (reset)? 1'b0: PCNext;
	
	arm arm(
				.clk(cpu_clock), 
				.reset(reset), 
				.PCNext(PCNext), 
				.Instr(Instr), 
				.MemWrite(MemWrite), 
				.ALUResult(DataAdr),
				.WriteData(WriteData), 
				.ReadData(ReadData));
				
				
	logic [31:0] rd1, rd2, rd3, rd4;
	logic we1, we2, we3, we4;
	logic [31:0] addr1, addr2, addr3, addr4;
	logic [31:0] wd1, wd2, wd3, wd4;
	logic [31:0] rd;

	chipset_5regions chipset( 
		 .we(MemWrite),
		 .addr(DataAddr),
		 .wd(WriteData),
		 .rd1(rd1), .rd2(rd2), .rd3(rd3), .rd4(rd4),
		 .ctrl_val(ctrl_val),
		 .we1(we1), .we2(we2), .we3(we3), .we4(we4),
		 .addr1(addr1), .addr2(addr2), .addr3(addr3), .addr4(addr4), 
		 .wd1(wd1), .wd2(wd2), .wd3(wd3), .wd4(wd4),
		 .rd(ReadData)
	);
				
	//imem imem(PC, Instr);
	/**my_rom rom(
				.clk_a(cpu_clock),
				//.clk_b(clk),
				.r_addr_a(instr_addr),
				//.r_addr_b(addr1),
				.rd_a(Instr));
				//.rd_b(rd1));
		
	my_ram ram(
				.clk(clk),
				.we(we2),
				.addr(addr2),
			   .wd(wd2),
				.rd(rd));**/
				
	
	logic[7:0] image_rom_rd_aux;

	instr_rom imem(
		 .clk_a(cpu_clk),
		 .clk_b(clk),
		 .r_addr_a(instr_addr),
		 .r_addr_b(addr1),
		 .rd_a(Instr),
		 .rd_b(rd1)
	);

	image_rom img_mem(
		 .clk(clk),
		 .r_addr(addr2),
		 .rd(image_rom_rd_aux)
	);

	assign rd2 = {24'b0, image_rom_rd_aux};

	sync_data_ram dmem(
		 .clk(clk), 
		 .we(we3), 
		 .addr(addr3), 
		 .wd(wd3), 
		 .rd(rd3)
	);

	vga_ram vga_mem(
		 .we(we4),
		 .r_clk(clk_vga),
		 .w_clk(clk),
		 .wd(wd4[7:0]),
		 .r_addr(vga_pixel_addr),
		 .w_addr(addr4),
		 .rd(vga_pixel_val)
	);
	
	//dmem dmem(clk, MemWrite, DataAdr, WriteData, ReadData);
endmodule