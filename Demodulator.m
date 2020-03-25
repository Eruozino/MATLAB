%Chirp Sound.
t = [0:1/8000:8191/8000];
x = sin(2*pi*100*t + 2*pi*100*(t.*t));
carrier = sin(2*pi*1000*t);
y = carrier.*x;
z = carrier.*y

%Demodulation with a 5-th order butter filter for fine tuning.
freqRatio = 500/4000;
[B, A] = butter(5, freqRatio);
[H,W] = freqz(B,A,512);
w = filter(B,A,z);
W = fft(w);
Wsymmetric = [W(4097:8192), W(1:4096)];
p = length(w);
fs = 8000;
symmetricFreqs = [-fs/2:fs/p:(fs/2)-(fs/p)];
plot(symmetricFreqs, abs(Wsymmetric));
xlabel('Frequency in Hertz');
ylabel('Magnitude of DFT');
