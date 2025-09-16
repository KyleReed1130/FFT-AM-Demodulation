# FFT-Based Carrier Estimation and AM Demodulation (MATLAB)

This MATLAB project demonstrates how to recover audio from an AM-modulated signal using FFT-based carrier estimation. The script estimates the carrier frequency from the spectrum, demodulates the signal, applies a Butterworth filter, and plays back the recovered baseband audio.

## Features
- **Carrier estimation**: FFT peak analysis determines `Fc`.  
- **AM demodulation**: MATLAB `demod` function with automatic carrier frequency input.  
- **Filtering**: 5th-order Butterworth low-pass filter for clean recovery.  
- **Audio playback**: Listen to the hidden message after processing.  
- **Synthetic dataset support**: If no dataset is present, the script auto-generates a synthetic AM signal for testing.  

## Files
- `fft_am_demod.m` — Main decoder script (loads `.mat` or generates one).  
- `gen_synth_am.m` — Creates a synthetic AM dataset (`Question_01.mat`).  
- `.gitignore` — Excludes `.mat` files from Git.  
- `LICENSE` — MIT license.  

## Quick Start
1. Clone the repository.  
2. Open MATLAB in the project folder.  
3. Run:  
   ```matlab
   run("fft_am_demod.m")
   ```
   - If `Question_01.mat` exists, it will be used.  
   - Otherwise, `gen_synth_am.m` generates a synthetic AM dataset automatically.  

## Example Output
```
Estimated Fc ≈ 4000 Hz
Playing recovered audio...
```

## Notes
- Developed and tested in MATLAB R2023b.  
- `.mat` datasets are not committed; use the generator for reproducibility.  
- The approach is general and works for any AM-modulated signal.
