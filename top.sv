module top(input 	 logic 			clk, reset,
				output logic [31:0]  WriteData, DataAdr,
				output logic 			MemWrite);
				
	logic [31:0] PCNext, Instr, ReadData;
	
	logic cpu_clock;
	
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

	chipset_4regions chipsetx( 
		 .we(MemWrite),
		 .addr(DataAddr),
		 .wd(WriteData),
		 .rd1(rd1), .rd2(rd2), .rd3(rd3), .rd4(rd4),
		 .we1(we1), .we2(we2), .we3(we3), .we4(we4),
		 .addr1(addr1), .addr2(addr2), .addr3(addr3), .addr4(addr4), 
		 .wd1(wd1), .wd2(wd2), .wd3(wd3), .wd4(wd4),
		 .rd(ReadData)
	);
				
	//imem imem(PC, Instr);
	my_rom rom(
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
				.rd(rd));
		
	
	//dmem dmem(clk, MemWrite, DataAdr, WriteData, ReadData);
endmodule