module counter #(parameter WIDTH) (
	input clk,
	input enable,
	input reset, 
	input [WIDTH-1:0] load,
	output tc,
	output reg [WIDTH-1:0] q
);

reg [WIDTH-1:0] load_reg;

assign tc = (q == load);

always @(posedge clk) begin
	if(reset)
		q <= 0;
	else begin
		if(enable) begin
			if (q==load_reg) begin
				q <= 0;
				load_reg <= load;
			end else begin
				q <= q+1;
			end
		end
	end
end

endmodule