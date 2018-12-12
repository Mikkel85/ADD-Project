
`default_nettype none

module multiplexer(
	input wire PIXEL_CLK,       // Pixel clock: 25Mhz (or 25.125MHz) for VGA
	input wire [4:0] row0,
	input wire [4:0] row1,
	input wire [4:0] row2,
	input wire [4:0] row3,    
	input wire [4:0] row4, // 1 bit for each color RGB  Foreground (bit 0,1 and 2) and background (bit 3,4 and 5)
    output wire [4:0] O_anode,         // horizontal sync output
    output wire [4:0] O_cathode         // vertical sync output
    );

localparam constantNumber = 1000000; //100MHz becomes 100Hz
reg [31:0] count = 0;
reg [2:0] row = 0;
 
reg [4:0] reg_O_cathode = 0;
reg [4:0] reg_O_anode = 0;

always @ (posedge(PIXEL_CLK))
begin
	if (count == constantNumber - 1)
	begin
        count <= 32'b0;
		if(row == 4)
			row <= 0;
		else
			row <= row + 1;
	end	
    else
        count <= count + 1;
end

always @(posedge(PIXEL_CLK))
begin
case (row)
0: 
	begin
		reg_O_cathode = row0;
		reg_O_anode   = 5'b00001; 
	end
1: 
	begin
		reg_O_cathode = row1;
		reg_O_anode   = 5'b00010; 
	end
	
2: 
	begin
		reg_O_cathode = row2;
		reg_O_anode   = 5'b00100; 
	end

3: 
	begin
		reg_O_cathode = row3;
		reg_O_anode   = 5'b01000; 
	end

4: 
	begin
		reg_O_cathode = row4;
		reg_O_anode   = 5'b10000; 
	end
default:
	begin
		reg_O_cathode = 5'b00000;
		reg_O_anode   = 5'b00000; 
	end
endcase
end

assign O_cathode = reg_O_cathode;
assign O_anode = reg_O_anode; 
endmodule
