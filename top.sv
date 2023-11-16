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
				
	//imem imem(PC, Instr);
	my_rom rom(
				.clk_a(cpu_clock),
				//.clk_b(clk),
				.r_addr_a(instr_addr),
				//.r_addr_b(addr1),
				.rd_a(Instr));
				//.rd_b(rd1));
		
	//my_ram ram(
				//.clk(clk),
				//.we(MemWrite),
				//.addr(DataAdr),
				//.wd(WriteData),
				//.rd(ReadData));
		
	
	dmem dmem(clk, MemWrite, DataAdr, WriteData, ReadData);
endmodule