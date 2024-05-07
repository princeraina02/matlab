%Amplitude Shift Keying
clc;
clear;
close all;

a = [1 1 1 1 0 0 0 1 0 1 0 1];
l = length(a);
fc = 10;

for i = 1:l
    for t = (i-1)*100+1:i*100
        x(t) = a(i) * cos(2*pi*fc*t/1000);
    end
end

plot(x,'r');
title('ASK Signal');
ylabel('Amplitude--->');
xlabel('Time--->');
