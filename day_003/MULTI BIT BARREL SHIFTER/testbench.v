module tb_barrel_shifter;

    reg [7:0] data_in;
    reg [2:0] shift_amount;
    reg [1:0] shift_type;
    wire [7:0] data_out;

    // Instantiate the barrel shifter module
    barrel_shifter uut (
        .data_in(data_in),
        .shift_amount(shift_amount),
        .shift_type(shift_type),
        .data_out(data_out)
    );

    initial begin
        // Test case 1: Logical Left Shift
        data_in = 8'b10101010; shift_amount = 3'd2; shift_type = 2'b00;
        #10;
        $display("Logical Left Shift: %b", data_out);

        // Test case 2: Logical Right Shift
        data_in = 8'b10101010; shift_amount = 3'd2; shift_type = 2'b01;
        #10;
        $display("Logical Right Shift: %b", data_out);

        // Test case 3: Circular Left Shift
        data_in = 8'b10101010; shift_amount = 3'd2; shift_type = 2'b10;
        #10;
        $display("Circular Left Shift: %b", data_out);

        // Test case 4: Circular Right Shift
        data_in = 8'b10101010; shift_amount = 3'd2; shift_type = 2'b11;
        #10;
        $display("Circular Right Shift: %b", data_out);

        $finish;
    end

endmodule
