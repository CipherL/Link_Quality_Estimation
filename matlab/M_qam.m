%% close all; clear; clc
close all; clear; clc;
%% Set the modulation order and generate random data.
M = 16;                     % Size of signal constellation
k = log2(M);                % Number of bits per symbol
n = 30000;                  % Number of bits to process
numSamplesPerSymbol = 1;    % Oversampling factor

%% Create a binary data stream as a column vector.

rng default                 % Use default random number generator
dataIn = randi([0 1],n,1);  % Generate vector of binary data

%% Convert the Binary Signal to an Integer-Valued Signal
dataInMatrix = reshape(dataIn,length(dataIn)/k,k);   % Reshape data into binary k-tuples, k = log2(M)
dataSymbolsIn = bi2de(dataInMatrix);                 % Convert to integers

%% Modulate using 16-QAM
dataMod = qammod(dataSymbolsIn,M,'bin');         % Binary coding, phase offset = 0
dataModG = qammod(dataSymbolsIn,M); % Gray coding, phase offset = 0

%% Calculate the SNR when the channel has an Eb/N0 = 10 dB.

EbNo = 10;
snr = EbNo + 10*log10(k) - 10*log10(numSamplesPerSymbol);
%% Pass the signal through the AWGN channel for both the binary and Gray coded symbol mappings.

receivedSignal = awgn(dataMod,snr,'measured');
receivedSignalG = awgn(dataModG,snr,'measured');
%% Create a Constellation Diagram

sPlotFig = scatterplot(receivedSignal,1,0,'g.');
hold on
scatterplot(dataMod,1,0,'k*',sPlotFig)

%% save recieve data as mat file
Data = [real(receivedSignal), imag(receivedSignal)];
save('Data16.mat','Data');