# Audio Masking & Redirection Techniques

## IMPORTANT: Legal & Ethical Considerations

1. **Respect local noise ordinances** - do not create excessive noise pollution
2. **Target only the problematic sound** - avoid affecting others unnecessarily
3. **Use reversible methods** - never permanently alter your living space
4. **Prioritize peaceful solutions** - masking should reduce disturbance, not escalate it

## Audio Masking Fundamentals

### How Audio Masking Works

Audio masking occurs when a louder or more distracting sound reduces the perceived volume of another sound. The human ear can only focus on one dominant sound source at a time.

### Key Principles

1. **Frequency matching**: Masking is most effective when frequencies match the target sound
2. **Volume balance**: Masking sound should be slightly louder than the intrusive sound
3. **Directionality**: Masking sound should be positioned to counter the incoming sound
4. **Temporal alignment**: For phase cancellation, precise timing is critical

## Category 1: White Noise Generation

### Method 1: Smartphone Apps

**Recommended Apps:**
- **White Noise Lite** (iOS/Android): Free, customizable noise profiles
- **Noisli** (Web/Mobile): Background noise with customizable sliders
- **Relax Melodies** (iOS/Android): Sleep sounds with timer functionality
- **Decibel X** (iOS/Android): Combines noise generation with SPL measurement

**Optimal Settings:**
- **Frequency range**: 200-3000 Hz (matches human voice frequency range)
- **Volume**: 3-5 dB above the intrusive prayer call
- **Duration**: Set timer to match prayer call duration

### Method 2: DIY White Noise Generator

**Materials Needed:**
- Raspberry Pi or Arduino
- External speaker (3W+)
- Power supply
- SD card (for Raspberry Pi)

**Raspberry Pi Instructions:**

1. **Install Raspbian OS** on SD card
2. **Connect speaker** to audio jack or USB
3. **Install noise generation software**:
   ```bash
   sudo apt-get update
   sudo apt-get install sox
   ```
4. **Create noise generation script** (`white_noise.sh`):
   ```bash
   #!/bin/bash
   # Continuous white noise at optimal frequency range
   play -n synth brownnoise band -n 1200 1000 tremolo 0.1 50 
   ```
5. **Make script executable**:
   ```bash
   chmod +x white_noise.sh
   ```
6. **Run script**:
   ```bash
   ./white_noise.sh
   ```

### Method 3: Commercial White Noise Machines

**Recommended Products:**
- **Marpac Dohm**: Classic fan-based white noise
- **LectroFan**: Digital sound machine with 20+ noise profiles
- **Sound+Sleep**: Adaptive sound masking with environmental sensing
- **Hatch Restore**: Sleep sound machine with app control

**Placement Tips:**
- Position near windows facing the PA speakers
- Mount at ear level for optimal coverage
- Use multiple machines for larger rooms

## Category 2: Phase Cancellation

### How Phase Cancellation Works

When two identical sounds are played 180° out of phase, they cancel each other out:

```
[Original Sound Wave] + [Inverted Sound Wave] = [Silence]
```

### Required Equipment

1. **Audio recording device** (smartphone with good microphone)
2. **Audio editing software** (Audacity - free)
3. **External speakers** (with low latency)
4. **Precision timing device** (smartphone stopwatch or audio interface)

### Step-by-Step Instructions

**Step 1: Record the Prayer Call**

1. Place smartphone in a quiet location near the window
2. Start recording 5 minutes before the prayer call begins
3. Record the entire prayer call
4. Save the recording as a WAV file for highest quality

**Step 2: Process the Recording in Audacity**

1. **Open Audacity** and import the recording
2. **Select the entire track** (Ctrl+A)
3. **Invert the phase**: Effects → Invert
4. **Clean up the audio**: Remove any unwanted background noise
5. **Export as WAV**: File → Export → Export as WAV

**Step 3: Synchronize Playback**

1. **Calculate delay time**: Determine the time difference between:
   - When the sound reaches your window
   - When it reaches your playback speakers

2. **Set up speakers**: Place external speakers near your window
3. **Use a pre-roll**: Start playback 5 seconds before the prayer call begins
4. **Adjust timing**: Fine-tune the playback start time until cancellation occurs

### Advanced Phase Cancellation

**Using DSP Hardware:**
- **MiniDSP 2x4 HD**: Digital signal processor for precise phase control
- **Behringer DSP8024**: Professional audio processor with phase inversion

**Software Solutions:**
- **Voicemeeter Banana**: Free virtual audio mixer with phase control
- **Reaper**: Digital audio workstation with advanced phase manipulation

## Category 3: Acoustic Redirection

### Method 1: Reflective Panels

**Materials Needed:**
- Plywood or MDF board (2'x2' minimum)
- Aluminum foil or reflective material
- Foam board (for backing)
- Adhesive spray

**Instructions:**
1. Cut board to desired size
2. Cover one side with reflective material
3. Attach foam backing for stability
4. Mount panels on walls facing the PA speakers
5. Angle panels to redirect sound away from your living space

### Method 2: Directional Speakers

**How It Works:**
Directional speakers (also called parametric speakers) create highly focused sound beams:

1. **Position directional speakers** facing the PA system
2. **Play masking sound** in a narrow beam towards the speakers
3. **Minimize spillage** - directional speakers affect only the target area

**Recommended Products:**
- **Holosonics Audio Spotlight**: Commercial directional speaker
- **Tesserae Directional Speaker**: Consumer-grade option
- **DIY Parametric Speaker**: Build your own using ultrasonic transducers

### Method 3: Balcony Barriers

**Materials Needed:**
- Outdoor-rated acoustic panels
- PVC pipe or wooden frame
- Zip ties or screws
- Weatherproofing sealant

**Instructions:**
1. Build a frame that fits your balcony railing
2. Attach acoustic panels to the frame
3. Position the barrier to block direct sound paths
4. Angle the barrier to reflect sound upward

## Category 4: Acoustic Absorption

### Method 1: Window Treatments

**Recommended Products:**

| Product Type | STC Rating | Effectiveness | Cost |
|--------------|------------|---------------|------|
| Regular curtains | 10-15 | Low | $ |
| Blackout curtains | 15-20 | Medium | $$ |
| Soundproof curtains | 20-30 | High | $$$ |
| Window inserts | 25-35 | Very High | $$$ |

**Installation Tips:**
- Use ceiling-to-floor curtains for maximum coverage
- Add a layer of acoustic foam behind curtains
- Seal gaps around window frames with weatherstripping

### Method 2: Wall Treatments

**DIY Acoustic Panels:**

1. **Materials Needed**: Rockwool insulation, fabric, wooden frame
2. **Build frame**: Cut wood to 2'x4' dimensions
3. **Insert insulation**: Place Rockwool inside the frame
4. **Cover with fabric**: Staple fabric tightly over the frame
5. **Mount panels**: Attach to walls using Command strips or screws

**Commercial Options:**
- **ATS Acoustic Panels**: Studio-quality absorption
- **GIK Acoustics**: Eco-friendly acoustic treatments
- **Auralex Acoustics**: Affordable home solutions

### Method 3: Flooring Solutions

**Recommended Products:**
- **Thick carpets**: 1/2"+ padding for best results
- **Acoustic underlayment**: Adds sound absorption to hard floors
- **Rugs with rubber backing**: Blocks sound transmission

## Monitoring & Measurement

### Sound Level Measurement

**Apps to Use:**
- **Decibel X** (iOS/Android): Professional-grade SPL meter
- **Sound Meter** (Android): Free SPL measurement
- **Noise Hunter** (iOS): Tracks noise over time

**Target Levels:**
- **Intrusive sound**: Measure the prayer call volume
- **Masking sound**: Keep 3-5 dB above intrusive sound
- **Background noise**: Maintain below local ordinance limits (typically 55-65 dB)

### Frequency Analysis

**How to Use:**
1. Record the prayer call using a frequency analyzer app
2. Identify dominant frequencies (typically 200-1000 Hz for male voices)
3. Adjust masking sound to match these frequencies

**Recommended Apps:**
- **Spectrum Analyzer Pro** (iOS)
- **Audio Spectrum Analyzer** (Android)

## Troubleshooting

### Problem: Masking isn't effective
- **Solution**: Match frequencies more precisely, increase volume slightly

### Problem: Masking sound is distracting
- **Solution**: Use pink noise instead of white noise, add nature sounds (rain, ocean)

### Problem: Phase cancellation isn't working
- **Solution**: Improve timing accuracy, use a digital audio interface for low latency

### Problem: Neighbors complain about masking sound
- **Solution**: Use directional speakers, reduce volume, or switch to indoor-only masking

## Final Recommendations

### Priority Order

1. **Negotiation first**: Continue trying to resolve the issue with management
2. **Acoustic absorption**: Improve insulation in your living space
3. **White noise generation**: Use smartphone apps or commercial machines
4. **Phase cancellation**: Try this if other methods fail
5. **Legal action**: File official noise complaints with documentation

### Long-Term Solutions

- **Soundproof windows**: Install double or triple glazing
- **Insulated walls**: Add mass-loaded vinyl or acoustic drywall
- **Door seals**: Weatherstrip all exterior doors
- **Talk to neighbors**: Organize a community meeting to address the issue together

## Disclaimer

This guide is for educational purposes only. Always prioritize legal, ethical, and peaceful solutions to noise disturbance issues. Unauthorized access to PA systems or excessive noise generation may violate local laws and regulations.
