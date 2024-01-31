# metallic

Proof-of-concept GPU-accelerated drop-in replacement for `numpy` on macOS, powered by the Metal and Accelerate frameworks.

## How does it work?

[Metal](<https://en.wikipedia.org/wiki/Metal_(API)>) is a hardware-accelerated shader API created to provide low-level access to the GPU on iOS and macOS devices.
Many vector operations are noticeably faster on GPUs than CPUs, so I wanted to try creating a drop-in `numpy` replacement that would speed up certain large operations on my MacBook.

The `framework` directory provides an Xcode project through which our Metal shaders are made available via bindings written in Objective-C.
This Xcode project builds into `framework/Metallic.framework`, a dynamic framework which is then accessed from Python via the `pyobjc` API.
This framework is universal, meaning it should work on both Intel-based and Apple Silicon machines.

`metallic` takes advantage of these bindings by keeping arrays in GPU memory until a non-metal function is called, requiring it to be brought into regular CPU memory.

## Setup

Most changes to `metallic` involve making changes to the framework described above.
However, if you are only interested in importing `metallic` and trying it out, you may skip the first step and skip to the `Install Python Module` step below.

### Build Metallic.framework (Option 1: Command Line)

If you have trouble building the framework on the command line, you may also build it in Xcode (option 2, below).

```bash
xcodebuild -project framework/Metallic.xcodeproj
```

You may see an error such as the following:

```
xcode-select: error: tool 'xcodebuild' requires Xcode, but active developer directory '/Library/Developer/CommandLineTools' is a command line tools instance
```

If you do, make sure to install Xcode and select the correct `xcodebuild` command:

```bash
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
```

### Build Metallic.framework (Option 2: Xcode)

1. Open `Metallic.xcodeproj` in Xcode
2. Build the project with ⌘+B, or by pressing the play button near the top of the window

### Install Python Module

Make sure you have Python 3 installed. Then, install with the setup script.

```bash
python setup.py develop
```

## Usage

Many operations work just as they would with `numpy`. For example:

```python
>>> import metallic as mtl
>>> x = mtl.random.randn(4)
>>> y = mtl.random.randn(4)
>>> print(x + y)
[-0.6347, -0.3345, -0.7906, 2.4452]
>>> print(x)
[-0.7887, 0.1124, -1.7062, 1.4231]
>>> print(y)
[0.1540, -0.4469, 0.9156, 1.0221]
>>> print(mtl.sin(x))
[-0.7094, 0.1122, -0.9909, 0.9891]
>>> print(mtl.arctan2(x, y))
[-1.3780, 2.8952, -1.0783, 0.9479]
```

As mentioned above, each of these operations (random number generation, addition, sin, atan2) are done in GPU memory, but the result is then copied to the CPU in order to be printed.
Pretty cool!

## Benchmark

The `test_speed.py` script runs the code above several times, along with its `numpy` equivalent, to make a speed comparison.
Here are the results on an older MacBook Pro 13" 2020 (i7 2.3GHz 4-core):

```
$ python test_speed.py

Array size: 10 ** 4
metallic: 0.0791s
numpy: 0.0072s
===
Array size: 10 ** 5
metallic: 0.1266s
numpy: 0.0803s
===
Array size: 10 ** 6
metallic: 0.3868s
numpy: 0.7839s
===
Array size: 10 ** 7
metallic: 2.7277s
numpy: 7.6526s
===
Array size: 10 ** 8
metallic: 34.7095s
numpy: 89.8390s
```

And here are the results on my MacBook Pro 14" 2023 (M2 Pro):

```
$ python test_speed.py

Array size: 10 ** 4
metallic: 0.1041s
numpy: 0.0096s
===
Array size: 10 ** 5
metallic: 0.2661s
numpy: 0.0392s
===
Array size: 10 ** 6
metallic: 0.3869s
numpy: 0.4040s
===
Array size: 10 ** 7
metallic: 2.2621s
numpy: 4.0190s
===
Array size: 10 ** 8
metallic: 27.6258s
numpy: 42.7040s
```

You'll notice that for arrays with only a few thousand elements, the overhead from copying elements between GPU and CPU memory outweighs the performance improvements.
However, for larger arrays, `metallic` beats `numpy` by a good margin.

## License

This repository is available under the MIT license. See the [LICENSE](/LICENSE.md) file for more details.
