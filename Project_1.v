module Project_1(Clk, rs1, rs2, rd, instruction);

input Clk;
input [31:0] instruction;
input [4:0] rs1, rs2;

output reg [4:0] rd;

//R-Type Instructions Only

always @ (posedge Clk)
begin
  if ((instruction[6:0] == 7'b0110011)) //opcode
  begin
	if ((instruction[14:12] == 3'b000)) //func3
    begin
	  if ((instruction[31:25] == 7'b0000000)) //func7         //add
        rd = rs1 + rs2;
      else if ((instruction[31:25] == 7'b0100000)) //sub
        rd = rs1 - rs2;
    end
    else if ((instruction[14:12] == 3'b001)) //sll
      rd = rs1 << rs2;
    else if ((instruction[14:12] == 3'b010)) //slt (if signed)
    begin
      if (rs1 < rs2)
      rd = 1;
      else 
      rd = 0;
    end
    else if ((instruction[14:12] == 3'b011)) //sltu (if unsigned)
    begin
      if (rs1 < rs2)
      rd = 1;
      else 
      rd = 0;
    end
    else if ((instruction[14:12] == 3'b100)) //xor
      rd = rs1 ^ rs2;
    else if ((instruction[14:12] == 3'b101)) 
    begin
	  if ((instruction[31:25] == 0)) //srl 
        rd = rs1 >> rs2;
      else if ((instruction[31:25] == 7'b0100000)) //sra (lower 5 bits)
        rd = rs1 >>> rs2;
    end  
    else if ((instruction[14:12] == 3'b110))  //or
      rd = rs1 | rs2;
    else if ((instruction[14:12] == 3'b111))  //and
      rd = rs1 & rs2;
  end
    
  else if ((instruction[6:0] == 7'b0111011)) //opcode
  begin
	if ((instruction[14:12] == 3'b000)) //func3
    begin
	  if ((instruction[31:25] == 3'b000)) //func7       //addw (32 bits output)
        rd = rs1 + rs2;
      else if ((instruction[31:25] == 7'b0100000)) //subw (32 bits output)
        rd = rs1 - rs2;
    end
    else if ((instruction[14:12] == 3'b001)) //sllw (32 bits output)
      rd =  rs1 << rs2;
    else if ((instruction[14:12] == 3'b101))
    begin
      if ((instruction[31:25] == 7'b0000000)) //srlw (32 bits output)
        rd = rs1 >> rs2;
      else if ((instruction[31:25] == 7'b0100000)) //sraw (32 bits output, lower 5 bits)
        rd = rs1 >>> rs2;
    end
  end
end
endmodule