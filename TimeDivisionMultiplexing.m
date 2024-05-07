%Time Division Multiplexing
clc; 
clear; 
close all; 

% Parameters for PCM
A = 2;   
fc = 3;   
fs = 20;   
n = 3;   
t = 0:1/(100*fc):1;   
x = A*sin(2*pi*fc*t);   
ts = 0:1/fs:1;   
xs = A*sin(2*pi*fc*ts);   
x1 = xs + A;   
x1 = x1 / (2*A);   
L = (-1 + 2^n);   
x1 = L * x1;   
xq = round(x1);   
r = xq / L;   
r = 2*A * r;   
r = r - A;   
y = [];   
for i = 1:length(xq)   
    d = dec2bin(xq(i), n);   
    y = [y double(d) - 48];   
end   
MSE = sum((xs - r).^2) / length(xs); 
Bitrate = n * fs;   
Stepsize = 2*A / L;   
QNoise = ((Stepsize)^2) / 12;   

% Plot PCM signals
subplot(3,1,1);   
plot(t, x, 'linewidth', 2)   
title('Step 1: Original and Sampled Signals')   
ylabel('Amplitude')   
xlabel('Time (s)')   
hold on   
stem(ts, xs, 'r', 'linewidth', 2)   
hold off   
legend('Analog signal', 'Sampling');   

subplot(3,1,2);   
stem(ts, x1, 'linewidth', 2)   
title('Step 2: Quantization and Reconstruction')   
ylabel('Amplitude')   
hold on   
stem(ts, xq, 'r', 'linewidth', 2)   
plot(ts, xq, '--r')   
plot(t, (x + A) * L / (2*A), '--b')   
grid   
hold off   
legend('Quantization', 'Sampling');   

subplot(3,1,3);   
stairs([y y(length(y))], 'linewidth', 2)   
title('PCM Encoding')  
ylabel('Amplitude')   
xlabel('Bits')   
axis([0 length(y) -2 2])   
grid   

% Parameters for TDM
x = 0:.5:4*pi;   
sig1 = 8*sin(x);   
l = length(sig1);   
sig2 = 8*triang(l);   
l1 = length(sig1);   
l2 = length(sig2);   

% Plot signals for TDM
subplot(4,2,1);   
plot(sig1, 'r');   
title('Sinusoidal Signal');   
ylabel('Amplitude--->');   
xlabel('Time--->');   

subplot(4,2,2);   
plot(sig2, 'r');   
title('Triangular Signal');   
ylabel('Amplitude--->');   
xlabel('Time--->');   

subplot(4,2,3);   
stem(sig1, 'g');   
title('Sampled Sinusoidal Signal');   
ylabel('Amplitude--->');   
xlabel('Time--->');   

subplot(4,2,4);   
stem(sig2, 'g');   
title('Sampled Triangular Signal');   
ylabel('Amplitude--->');   
xlabel('Time--->');   

% Perform TDM
sig = zeros(2, l1);   
for i = 1:l1   
    sig(1, i) = sig1(i);   
    sig(2, i) = sig2(i);   
end   
tdmsig = reshape(sig, 1, 2*l1);   
subplot(4,2,5);  
stem(tdmsig, 'g');   
title('TDM Signal');   
ylabel('Amplitude--->');   
xlabel('Time--->');   

% Demultiplex TDM signal
demux = reshape(tdmsig, 2, l1);   
sig3 = demux(1, :);   
sig4 = demux(2, :);   

% Plot recovered signals
subplot(4,2,7);   
plot(sig3);   
title('Recovered Sinusoidal Signal');   
ylabel('Amplitude--->');   
xlabel('Time--->');   

subplot(4,2,8);  
plot(sig4);   
title('Recovered Triangular Signal');   
ylabel('Amplitude--->');   
xlabel('Time--->'); 