module bintobcd(thousands,hundreds,tens,ones,bin);

input [31:0] bin;
output reg [3:0] ones,tens,hundreds,thousands;

integer i;
reg [47:0] shift; // 32-bit binary + 4 BCD digits (16 bits)

always @(*) begin
    shift = 0;
    shift[31:0] = bin;

    for (i = 0; i < 32; i = i + 1) begin
        // Add-3 step
        if (shift[35:32] >= 5) shift[35:32] = shift[35:32] + 3; // ones
        if (shift[39:36] >= 5) shift[39:36] = shift[35:32] + 3; // tens
        if (shift[43:40] >= 5) shift[43:40] = shift[35:32] + 3; // hundreds
        if (shift[47:44] >= 5) shift[47:44] = shift[35:32] + 3; // thousands

        // Shift left
        shift = shift << 1;
    end

    // Assign outputs
    ones      = shift[35:32];
    tens      = shift[39:36];
    hundreds  = shift[43:40];
    thousands = shift[47:44];
end
endmodule