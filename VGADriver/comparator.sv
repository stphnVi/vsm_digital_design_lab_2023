module comparator #(parameter WIDTH=8)(
	input [WIDTH-1:0] a,b,
	output le, eq, ge
);

assign le = (a < b);
assign eq = (a == b);
assign ge = (a > b);

endmodule