/**
Region 1: INSTR ROM [0000,1000[
Region 2: IMG ROM [1000,2000[
Region 3: VGA RAM[2000,3000[
Region 4: D TABLE RAM [3000, 4000[
Region 5: I/O [4000, 5000[
**/

module chipset_5regions
#(parameter REGION1_BASE=32'h00000, 
				REGION2_BASE=32'h10000, 
				REGION3_BASE=32'h20000, 
				REGION4_BASE=32'h30000, 
				REGION5_BASE=32'h40000)
(
		input we, //write enable 
		input [31:0] addr, wd, //address and write data
		input [31:0] rd1, rd2, rd3, rd4, //read data
		input [31:0] ctrl_val1, ctrl_val2, //control value -> switch value
		output logic we1, we2, we3, we4, //write enable by region
		output logic [31:0] addr1, addr2, addr3, addr4, //address by region
		output logic [31:0] wd1, wd2, wd3, wd4, //write data by region
		output logic [31:0] rd //read data by region -> utiliza el valor leido por la region seleccionada
		
		
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
	if(addr >= REGION3_BASE && addr < REGION4_BASE) begin
		we3 = we;
		{we1, we2, we4} = 1'b0;
		addr3 = (addr - REGION3_BASE);
		{addr1, addr2, addr4} = 1'b0;
		wd3 = wd;
		{wd1, wd2, wd4} = 1'b0;
		rd = rd3;
	end
	else
	if(addr >= REGION4_BASE && addr < REGION5_BASE) begin
		we4 = we;
		{we1, we2, we3} = 1'b0;
		addr4 = (addr - REGION4_BASE);
		{addr1, addr2, addr3} = 1'b0;
		wd4 = wd;
		{wd1, wd2, wd3} = 1'b0;
		rd = rd4;
	end
	else begin
		{we1, we2, we3, we4} = 1'b0;
		{addr1, addr2, addr3, addr4} = 1'b0;
		{wd1, wd2, wd3, wd4} = 1'b0;
		
		if(addr == (REGION5_BASE + 32'h0)) rd = ctrl_val1;
		else if(addr == (REGION5_BASE + 32'h4)) rd = ctrl_val2;
		else rd = 1'b0;
		
	end
end

endmodule
		