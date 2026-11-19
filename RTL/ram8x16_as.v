# code for ram8x16_as.v
  ...
     module ram8x16_as(wclk,rclk,rst,d_in,wadd,radd,we,re,d_out);
        input wclk,rclk,rst,we,re;
        input [2:0]wadd,radd;
        input [15:0]d_in;

        output reg[15:0]d_out;

        integer i;

        reg [15:0]mem[7:0];

        always@(posedge wclk)
        begin
                if(rst)
                begin
                        for(i=0;i<8;i=i+1)
                        begin
                                mem[i]<=0;
                        end
                end
                else if(we)
                begin
                        mem[wadd]<=d_in;
                end
        end

        always@(posedge rclk)
        begin
                if(rst)
                begin
                        d_out<=0;
                end
                else if(re)
                begin
                        d_out<=mem[radd];
                end
        end
        endmodule
...
