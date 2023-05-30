module vending_machine (
    input clock, reset,
    input [3:0] incoi,
    input inpro,
    output reg outpro,
    output reg [3:0] cha
);

parameter s0 = 2'b00;
parameter s5 = 2'b01;
parameter s10 = 2'b10;
parameter s15 = 2'b11;

reg [1:0] exista, nexsta;

always @(posedge clock) begin
    if (reset) begin
        exista = 2'b00;
        nexsta = 2'b00;
        cha = 2'b00;
    end
    else exista = nexsta;

    if (inpro == 0) begin
        case (exista)
        s0:
            if (incoi == 4'd0) begin
                nexsta = s0;
                outpro = 0;
                cha = 4'd0;
            end
            else if (incoi == 4'd5) begin
                nexsta = s5;
                outpro = 0;
                cha = 4'd0;
            end
            else if (incoi == 4'd10) begin
                nexsta = s0;
                outpro = 1;
                cha = 4'd0;
            end
            else if (incoi == 4'd15) begin
                nexsta = s0;
                outpro = 1;
                cha = 4'd5;
            end
        s5:
            if (incoi == 4'd0) begin
                nexsta = s0;
                outpro = 0;
                cha = 4'd5;
            end
            else if (incoi == 4'd5) begin
                nexsta = s0;
                outpro = 1;
                cha = 4'd0;
            end 
            else if (incoi == 4'd10) begin
                nexsta = s0;
                outpro = 1;
                cha = 4'd5;
            end
            else if (incoi == 4'd15) begin
                nexsta = s0;
                outpro = 1;
                cha = 4'd10;
            end
        endcase
    end
    else if (inpro == 1) begin
        case (exista)
            s0:
                if (incoi == 4'd0) begin
                    nexsta = s0;
                    outpro = 0;
                    cha = 4'd0;
                end
                else if (incoi == 4'd5) begin
                    nexsta = s5;
                    outpro = 0;
                    cha = 4'd0;
                end  
                else if (incoi == 4'd10) begin
                    nexsta = s10;
                    outpro = 0;
                    cha = 4'd0;
                end
                else if (incoi == 4'd15) begin
                    nexsta = s15;
                    outpro = 0;
                    cha = 4'd0;
                end
            s5:
                if (incoi == 4'd0) begin
                    nexsta = s0;
                    outpro = 0;
                    cha = 4'd5;
                end
                else if (incoi == 4'd5) begin
                    nexsta = s10;
                    outpro = 0;
                    cha = 4'd0;
                end
                else if (incoi == 4'd10) begin
                    nexsta = s15;
                    outpro = 0;
                    cha = 4'd0;
                end
                else if (incoi == 4'd15) begin
                    nexsta = s0;
                    outpro = 1;
                    cha = 4'd0;
                end
            s10:
                if (incoi == 4'd0) begin
                    nexsta = s0;
                    outpro = 0;
                    cha = 4'd10;
                end
                else if (incoi == 4'd5) begin
                    nexsta = s15;
                    outpro = 0;
                    cha = 4'd0;
                end
                else if (incoi == 4'd10) begin
                    nexsta = s0;
                    outpro = 1;
                    cha = 4'd0;
                end
                else if (incoi == 4'd15) begin
                    nexsta = s0;
                    outpro = 1;
                    cha = 4'd5;
                end
            s15:
                if (incoi == 4'd0) begin
                    nexsta = s0;
                    outpro = 0;
                    cha = 4'd15;
                end
                else if (incoi == 4'd5) begin
                    nexsta = s0;
                    outpro = 1;
                    cha = 4'd0;
                end
                else if (incoi == 4'd10) begin
                    nexsta = s0;
                    outpro = 1;
                    cha = 4'd5;
                end
                else if (incoi == 4'd15) begin
                    nexsta = 0;
                    outpro = 1;
                    cha = 4'd10;
                end
        endcase
    end
end
endmodule

module Vending_Machine_Test_Bench ();

reg clock, reset;
reg [3:0] incoi;
reg inpro;

wire outpro;
wire [3:0] cha;

vending_machine uut (
    .clock(clock),
    .reset(reset),
    .incoi(incoi),
    .inpro(inpro),
    .outpro(outpro),
    .cha(cha)
);

initial begin
    $dumpfile("vending_machine.vcd");
    $dumpvars(0, Vending_Machine_Test_Bench);

    reset = 1;
    clock = 0;

    #60;
    reset = 0;
    inpro = 0;
    incoi = 4'd5;
    #60;
    incoi = 4'd10;
    #60;
    inpro = 1;
    incoi = 4'd15;
    #60;
    incoi = 4'd5;
    #60;
    $finish; 
end

always #50 clock = ~clock;
    
endmodule