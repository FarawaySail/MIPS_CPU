module control(Instruct,IRQ,PCSrc,RegDst,RegWr,ALUSrc1,ALUSrc2,ALUFun,Sign,MemWr,MemRd,MemToReg,EXTOp,LUOp);
  input [31:0] Instruct;
  input IRQ;
  output reg [2:0] PCSrc;
  output reg [1:0] RegDst;
  output reg RegWr,ALUSrc1,ALUSrc2,Sign,MemWr,MemRd;
  output reg [5:0] ALUFun;
  output reg [1:0] MemToReg;
  output reg EXTOp;
  output reg LUOp;
  wire [5:0] OpCode;
  wire [5:0] Funct;

  
  assign OpCode=Instruct[31:26];
  assign Funct=Instruct[5:0];
    
  always@(*)
  begin
    
    //IRQ
    if(IRQ==1)
      begin
        PCSrc<=4;
        RegDst<=3;
        RegWr<=1;
        ALUSrc1<=0;
        ALUSrc2<=0;
        ALUFun<=6'b000000;
        Sign<=1;
        MemWr<=0;
        MemRd<=0;
        MemToReg<=3;
        EXTOp<=0;
        LUOp<=0;
      end
      

    else if(Instruct==32'h80000008)
      begin
        PCSrc<=3'b101;
        RegDst<=3;
        RegWr<=1;
        ALUSrc1<=0;
        ALUSrc2<=0;
        ALUFun<=6'b000000;
        Sign<=1;
        MemWr<=0;
        MemRd<=0;
        MemToReg<=2;
        EXTOp<=0;
        LUOp<=0;
      end
      
    else
      begin
        //PCSrc
        PCSrc=
        (OpCode==6'h05||OpCode==6'h06||OpCode==6'h07||OpCode==6'h01||OpCode==6'h04)?3'b001:
        (OpCode==6'h02||OpCode==6'h03)?3'b010:
        (OpCode==0&&(Funct==6'h08||Funct==6'h09))?3'b011:3'b000;
         
         //RegDst
         RegDst=
         (OpCode==6'h03)?2'b10:
         (OpCode!=0)?2'b01:2'b00;
         
         //RegWr
         RegWr=
         (OpCode==6'h2b||OpCode==6'h04||OpCode==6'h05||OpCode==6'h06||OpCode==6'h07||OpCode==6'h01||OpCode==6'h02||(OpCode==0&&Funct==6'h08))?0:1;
         
         //ALUSrc1
         ALUSrc1=
         (OpCode==0&&(Funct==0||Funct==6'h02||Funct==6'h03))?1:0;
         
         //ALUSrc2
         ALUSrc2=
         (OpCode==6'h23||OpCode==6'h2b||OpCode==6'h0f||OpCode==6'h08||OpCode==6'h09||OpCode==6'h0c||OpCode==6'h0d||OpCode==6'h0a||OpCode==6'h0b)?1:0;
         
         //ALUFun
         ALUFun=
         (OpCode==6'h23||OpCode==6'h2b||OpCode==6'h08||OpCode==6'h09||(OpCode==0&&(Funct==6'h20||Funct==6'h21)))?6'b000000:
         (OpCode==0&&(Funct==6'h22||Funct==6'h23))?6'b000001:
         (OpCode==6'h0c||(OpCode==0&&Funct==6'h24))?6'b011000:
         (OpCode==6'h0f||OpCode==6'h0d||(OpCode==0&&Funct==6'h25))?6'b011110:
         (OpCode==0&&Funct==6'h26)?6'b010110:
         (OpCode==0&&Funct==6'h27)?6'b010001:
         (OpCode==0&&(Funct==6'h08||Funct==6'h09))?6'b011010:
         (OpCode==0&&Funct==0)?6'b100000:
         (OpCode==0&&Funct==6'h02)?6'b100001:
         (OpCode==0&&Funct==6'h03)?6'b100011:
         (OpCode==6'h04)?6'b110011:
         (OpCode==6'h05)?6'b110001:
         (OpCode==6'h0a||OpCode==6'h0b||(OpCode==0&&(Funct==6'h2a||Funct==6'h2b)))?6'b110101:
         (OpCode==6'h06)?6'b111101:
         (OpCode==6'h01)?6'b111011:0;
         
         //Sign
         Sign=
         (OpCode==6'h09||OpCode==6'h0b||(OpCode==0&&(Funct==6'h21||Funct==6'h23||Funct==6'h2B)))?0:1;
         
         //MemWr
         MemWr=
         (OpCode==6'h2b)?1:0;
         
         //MemRd
         MemRd=
         (OpCode==6'h23)?1:0;
         
         //MemToReg
         MemToReg=
         (OpCode==6'h23)?2'b01:
         (OpCode==6'h03||(OpCode==0&&Funct==6'h09))?2'b10:0;
         
         //EXTOp
         EXTOp=
         (OpCode==6'h0c||OpCode==6'h0d)?0:1;
         
         //LUOp
         LUOp=
         (OpCode==6'h0f)?1:0;
       end
  end
  
endmodule
         
      