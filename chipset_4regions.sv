module chipset_4regions
#(parameter REGION1_BASE=32'h00000, REGION2_BASE=32'h10000, REGION3_BASE=32'h20000, REGION4_BASE=32'h30000, REGION5_BASE=32'h40000)
(
		input we,
		input [31:0] addr, wd, 
		input [31:0] rd1, rd2, rd3, rd4, //Read data
		output logic we1, we2, we3, we4,
		output logic [31:0] addr1, addr2, addr3, addr4,
		output logic [31:0] wd1, wd2, wd3, wd4,
		output logic [31:0] rd
		
		
);

always @(*) begin 
	if(addr >= REGION1_BASE && addr < REGION2_BASE) begin
		we1 = we;
		{we2, we3, we4} = 1'b0;
		addr1 = (addr - REGION1_BASE);
		{addr2, addr3, addr4} = 1'b0;
		wd1 = wd;
		{wd2, wd3, wd4} = 1'b0;
		rd = rd1;
	end
	else
	if(addr >= REGION2_BASE && addr < REGION3_BASE) begin
		we2 = we;
		{we1, we3, we4} = 1'b0;
		addr2 = (addr - REGION2_BASE);
		{addr1, addr3, addr4} = 1'b0;
		wd2 = wd;
		{wd1, wd3, wd4} = 1'b0;
		rd = rd2;
	end
	else
	if(addr >= REGION2_BASE && addr < REGION3_BASE) begin
		we3 = we;
		{we1, we2, we4} = 1'b0;
		addr3 = (addr - REGION3_BASE);
		{addr1, addr2, addr4} = 1'b0;
		wd3 = wd;
		{wd1, wd2, wd4} = 1'b0;
		rd = rd3;
	end
	else
	if(addr >= REGION3_BASE && addr < REGION4_BASE) begin
		we4 = we;
		{we1, we2, we3} = 1'b0;
		addr4 = (addr - REGION4_BASE);
		{addr1, addr2, addr3} = 1'b0;
		wd4 = wd;
		{wd1, wd2, wd3} = 1'b0;
		rd = rd4;
	end
end

endmodule
		
		
		
		