# Sleek circular slider/progress bar for Flutter

A highly customizable circular slider/progress bar for Flutter.

## Getting Started

- [Installation](#installation)
- [Basic Usage](#basic-usage)
- [Customizations](#customizations)

### Installation

Add

```bash

sleek_circular_slider : ^lastest_version

```

to your pubspec.yaml, and run

```bash
flutter packages get
```

in your project's root directory.

### Basic Usage


Import it to your project file

```dart
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
```

And add it in its most basic form like it:

```dart
final slider = SleekCircularSlider(
                      appearance: CircularSliderAppearance(),
                      onChange: (double value) {
                        print(value);
                      });
```

### Customizations