module Adder(A,B,Sign,R,Z,V,N);
	input [31:0] A,B;
	input Sign;
	output [31:0] R;
	output Z,V,N;

	wire [32:0] temp;

 	initial
 	begin
 		R <= 0;
 		Z <= 0;
 		V <= 0;
 		N <= 0;	
 	end

	always @(*)
	begin
		temp <= A + B;
		R <= temp[31:0];
		if(Sign)              //有符号数
		begin
			if(A[31]==0&&B[31]==0)
			begin
				N <= 0;
				if(temp[31]==1)        //溢出
				begin
					V <= 1
				end
			end
			if(A[31]==1&&B[31]==1)
			begin
				N <= 1;
				if(temp[31]==0)        //溢出
				begin
					V <= 1;
				end
			end
			else begin                 //正负相加不可能溢出
				if(temp[31]==0)
				begin
					N <= 0;		
				end	
				else begin
					N <= 1;
				end
			end
		end
		else begin                    //无符号数
			if(temp[32]==0)           //溢出
			begin
				V <= 1;     
			end
		end
	end
endmodule