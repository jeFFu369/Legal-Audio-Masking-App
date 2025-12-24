# Legal Audio Masking App

A modern, web-based application for legal audio masking to reduce intrusive noise disturbances.

## Description

The Legal Audio Masking App provides an effective, legal solution for reducing the impact of unwanted noise (such as loudspeakers) through scientifically calibrated audio masking techniques. The app generates appropriate noise frequencies to effectively mask intrusive sounds while maintaining comfortable listening levels.

## Features

### Technical Capabilities
- **Custom Noise Generation**: Pink noise (most effective), white noise, and brown noise algorithms
- **Accurate dB Measurement**: Real-time noise level detection using proper RMS calculations
- **Frequency Filtering**: Precise frequency control using BiquadFilterNode for targeted masking
- **Auto-Adjustment**: Automatically maintains masking volume 4dB above background noise
- **Timer Functionality**: Set masking duration from 1-120 minutes
- **Real-time Spectrum Analyzer**: Visual display of audio frequencies with modern graphics

### Modern UI/UX
- **Futuristic Dark Theme**: Gradient backgrounds with neon color accents
- **Card-based Layout**: Organized interface with clear visual hierarchy
- **Smooth Animations**: Staggered fade-in effects, dB value transitions, and hover animations
- **Enhanced Visualization**: Radial gradient backgrounds and glowing frequency bars in spectrum analyzer
- **Responsive Design**: Works on both desktop and mobile devices

## Usage

1. **Start the App**: Open `Legal Audio Masking App.html` in a web browser, or access via local server
2. **Select Noise Type**: Choose pink, white, or brown noise (pink is recommended for speech masking)
3. **Set Frequency Focus**: Select "Voice Range" (200-3000Hz) for optimal speech masking
4. **Adjust Volume**: Use slider or enable auto-adjustment
5. **Start Masking**: Click "Start Masking" to begin noise generation
6. **Set Timer** (optional): Configure timer to automatically stop masking after desired duration

## Legal Disclaimer

**WARNING**: Use only for personal noise reduction. Keep volume within local legal limits.
- Recommended: Keep masking volume 3-5 dB above intrusive sound for optimal effectiveness
- Never use to disrupt emergency systems or safety communications
- Respect local noise ordinances and regulations

## Installation

### Option 1: Direct File Access
1. Download the `Legal Audio Masking App.html` file
2. Open directly in a modern web browser (Chrome, Firefox, Edge)

### Option 2: Local Web Server (Recommended for Full Features)
```bash
# Navigate to the project directory
cd "C:\Your Project\Directory"

# Start Python HTTP server
python -m http.server 8000

# Access at http://localhost:8000/Legal%20Audio%20Masking%20App.html
```

## Changelog

### 2025-12-24 - UI Modernization Update
- Complete UI redesign with futuristic dark theme and neon accents
- Added staggered card animations with sequential fade-in effects
- Implemented dB display animations that pulse on value updates
- Enhanced button interactions with gradient sweep overlays
- Updated spectrum analyzer with radial gradients and glowing frequency bars
- Added smooth hover effects and transitions throughout the interface
- Maintained all existing technical functionality

### Previous Updates
- Fixed noise generation algorithms (Web Audio API doesn't support pink/brown noise natively)
- Implemented accurate dB measurement using RMS calculations
- Added real frequency filtering with BiquadFilterNode
- Improved audio context management with proper user gesture handling

## Browser Compatibility

- Chrome 66+
- Firefox 60+
- Safari 12+
- Edge 79+

Requires microphone access for noise level detection (auto-adjustment feature).

## Technical Details

- **Audio Processing**: Web Audio API
- **UI Framework**: Pure HTML5, CSS3, and JavaScript
- **Graphics**: Canvas API for spectrum visualization
- **No Dependencies**: Self-contained application

## License

MIT License

## Contact

For issues or suggestions, please open an issue in the project repository.
