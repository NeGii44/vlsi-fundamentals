`timescale 1ns / 1ps

module tb_top();

    // 1. The Virtual Wires
    reg fake_sys_clk;
    reg fake_s1;
    reg fake_s2;
    wire [3:0] observe_led;

    // 2. Stamp down the Motherboard
    top uut (
        .sys_clk(fake_sys_clk),
        .s1(fake_s1),
        .s2(fake_s2),
        .led(observe_led)
    );

    // 3. Turn on the Virtual 27MHz Crystal
    initial begin
        fake_sys_clk = 0;
        forever #18.5 fake_sys_clk = ~fake_sys_clk; 
    end

    // 4. MUST HAVE: Command Icarus to record the waveform for GTKWave
    initial begin
        $dumpfile("waveform.vcd"); 
        $dumpvars(0, tb_top);      
    end

    // 5. The Virtual Robot Pressing the Buttons
    initial begin
        // Start with buttons unpressed (Active-Low)
        fake_s1 = 1;
        fake_s2 = 1;
        #100000; 

        // Hold Data button
        fake_s1 = 0; 
        #50000;

        // Press Shutter button (with mechanical bouncing)
        fake_s2 = 0; #1000;  
        fake_s2 = 1; #2000;  
        fake_s2 = 0; #1500;  
        fake_s2 = 1; #1000;  
        fake_s2 = 0;         
        
        // Wait 25 milliseconds for debouncer
        #25000000; 
        
        // Release Shutter button
        fake_s2 = 1; 
        #25000000;

        // Release Data button
        fake_s1 = 1;
        #100000;

        $display("Virtual Validation Complete!");
        $finish;
    end

endmodule