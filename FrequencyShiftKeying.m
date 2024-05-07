% Frequency Shift Keying
clc;
clear;
close all;

a = [1 1 1 1 0 0 0 1 0 1 0 1];
l = length(a);
f1 = 10;
f2 = 50;

for i = 1:l
    for t = (i-1)*100+1:i*100
        if a(i) == 0
            x(t) = cos(2*pi*f1*t/1000);
        else
            x(t) = cos(2*pi*f2*t/1000);
        end
    end
end

plot(x);
title('FSK Signal');
ylabel('Amplitude--->');
xlabel('Time--->');
