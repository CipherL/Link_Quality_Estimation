%% close all; clear; clc
close all; clear; clc;
%% Create a PSK modulator System object. the default modulation order for the psk modulator object is 8.
pskModulator = comm.PSKModulator('ModulationOrder', 8);

%% Modulate te signal.
 modData = pskModulator(randi([0 7], 2000, 1));
 
 %% Add white Gaussian noise to the modulated signal by passing the signal through an AWGN channel.
 channel = comm.AWGNChannel('EbNo',15,'BitsPerSymbol',3);

%% Transmit the signal through the AWGN channel.
channelOutput = channel(modData);

%% Plot the noiseless and noisy data using scatter plots to observe the effects of noise.
scatterplot(modData)
scatterplot(channelOutput)

%% save recieve data as mat file
Data = [real(channelOutput), imag(channelOutput)];
save('Data8.mat','Data');