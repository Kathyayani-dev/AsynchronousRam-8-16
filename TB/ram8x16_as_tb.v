# code for  ram8x16_as_tb.v
  ...
     module ram8x16_as_tb();
        reg wclk,rclk,rst,we,re;
        reg [2:0]wadd,radd;
        reg  [15:0]d_in;

        wire [15:0]d_out;

        integer i;

        //parameter CYCLE=10;

        ram8x16_as DUT(wclk,rclk,rst,d_in,wadd,radd,we,re,d_out);

        always #10 wclk=~wclk;
        always #7 rclk=~rclk;

        task rst_dut();
                begin
                        @(negedge wclk,negedge rclk);
                        rst=1'b1;
                        @(negedge wclk,negedge rclk);
                        rst=1'b0;
                end
        endtask

        task write();
                begin
                        we=1'b1;
                        re=1'b0;
                end
        endtask

         task read();
                begin
                        we=1'b0;
                        re=1'b1;
                end
        endtask

        task delay();
                begin
                        #20;
                end
        endtask

        task initialize();
                begin
                        {d_in,wadd,radd,wclk,rclk}=0;
                        {we,re}=0;
                end
        endtask

        task stimulus([15:0]a,[2:0]b,[2:0]c);
                begin
                        d_in=a;
                        wadd=b;
                        radd=c;
                end
        endtask



        initial
        begin
                initialize;
                rst_dut;
                write;
                for(i=0;i<8;i=i+1)
                begin
                        stimulus(i,i,i);
                        delay;
                end

                read;
                for(i=0;i<8;i=i+1)
                begin
                        stimulus(i,i,i);
                        delay;
                end
        end

       initial
                $monitor("d_in=%b wadd=%b radd=%b d_out=%b we=%b re=%b",d_in,wadd,radd,d_out,we,re);

        endmodule
                  
