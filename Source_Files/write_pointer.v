module write_pointer #(parameter ADDR_SIZE = 4)
(
    output reg full,
    output [ADDR_SIZE-1:0] w_addr,
    output reg [ADDR_SIZE:0] w_ptr,
    input [ADDR_SIZE:0] r_ptr,
    input w_en,
    input wclk,
    input w_rst_n
);
    reg [ADDR_SIZE:0] bin;
    wire [ADDR_SIZE:0] gray_next, bin_next;
    
    bin_to_gray #(ADDR_SIZE+1) bin2gray (
        .bin(bin_next),
        .gray(gray_next)
    );

    // Binary counter increment only if FIFO is not full and write enable is given 
    assign bin_next = bin + (w_en & ~full);

    // Update binary counter and Gray code pointer
    always @(posedge wclk or negedge w_rst_n) begin
        if (!w_rst_n) begin
            bin <= 0;
            w_ptr <= 0;
        end else begin
            bin <= bin_next;
            w_ptr <= gray_next;
        end
    end

    // Memory write-address pointer (okay to use binary to address memory)
    assign w_addr = bin[ADDR_SIZE-1:0];

	// wire full_temp;
	 
    // assign full_temp = (gray_next == {~r_ptr[ADDR_SIZE:ADDR_SIZE-1], r_ptr[ADDR_SIZE-2:0]});
    always @(posedge wclk or negedge w_rst_n) begin
        if (!w_rst_n) begin
            full <= 1'b0;
        end else begin
            full <= (gray_next == {~r_ptr[ADDR_SIZE:ADDR_SIZE-1], r_ptr[ADDR_SIZE-2:0]});
        end
    end
endmodule
