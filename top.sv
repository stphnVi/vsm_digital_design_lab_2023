module top(input 	 logic 			clk, reset,
				output logic [31:0]  WriteData, DataAdr,
				output logic 			MemWrite);
				
	logic [31:0] PCNext, PC, Instr, ReadData;
	
	logic cpu_clock;
	
	// instantiate processor and memories
	
	clock_divider #(1) cpu_clk_gen(clk, cpu_clock);
	
	wire [31:0] instr_addr; 
	assign instr_addr = (reset)? 1'b0: PCNext;
	
	arm arm(clk, reset, PCNext, Instr, MemWrite, DataAdr,
				WriteData, ReadData);
	//imem imem(PC, Instr);
	my_rom rom(
		.clk_a(clk),
		//.clk_b(clk),
		.r_addr_a(instr_addr),
		//.r_addr_b(addr1),
		.rd_a(Instr));
		//.rd_b(rd1));
	
	dmem dmem(clk, MemWrite, DataAdr, WriteData, ReadData);
endmodule