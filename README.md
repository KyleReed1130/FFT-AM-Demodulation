# FFT-Based Carrier Estimation and AM Demodulation (MATLAB)

This MATLAB project demonstrates how to recover audio from an AM-modulated signal using FFT-based carrier estimation. The script estimates the carrier frequency from the spectrum, demodulates the signal, applies a Butterworth filter, and plays back the recovered baseband audio.

## Features
- **Carrier estimation**: FFT peak analysis determines `Fc`.  
- **AM demodulation**: MATLAB `demod` function with automatic carrier frequency input.  
- **Filtering**: 5th-order Butterworth low-pass filter for clean recovery.  
- **Audio playback**: Listen to the hidden message after processing.  
- **Included dataset**: Comes with a sample AM-modulated signal (`signal_data.mat`) for instant testing.  

## Files
- `fft_am_demod.m` — Main decoder script.  
- `signal_data.mat` — Sample AM dataset (`y`, `Fs`).  
- `LICENSE` — MIT license.  

## Quick Start
1. Clone the repository.  
2. Open MATLAB in the project folder.  
3. Run:  
   ```matlab
   run("fft_am_demod.m")
