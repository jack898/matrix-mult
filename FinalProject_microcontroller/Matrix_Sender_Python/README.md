# Python Matrix Sender

This MicroPython project stores two 3x3 matrices in arrays of 8-bit integers, converts them to their 8-bit binary representations, and serially streams the values to an FPGA over a controller clock which it generates.

**NOTE:** The embedded C version of the matrix sender runs much faster due to Python's comparatively large overhead, so the embedded C matrix
sender should be used over this MicroPython sender when possible.

## Usage
1. Download [PyCharm](https://www.jetbrains.com/pycharm/) < 2024.3, and install the MicroPython Plugin.

2. Connect a supported microcontroller.

3. Open this folder as a project in PyCharm.

4. Go to Languages & Frameworks > MicroPython, and add your device.

5. Go back to the project, click the Run button, and choose "Run Flash".

## Acknowledgments
[MicroPython Documentation](https://docs.micropython.org/en/latest/)

[MicroPython in PyCharm: Basic Setup](https://medium.com/@andymule/micropython-in-pycharms-basic-setup-9169b497ec8a)
