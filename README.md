# Sleek circular slider/progress bar & spinner for Flutter

---

## Customizable Circular Slider & Progress



![Example 06](doc/slider07.gif)


# Usage


Import:

```dart
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
```

Create:

```dart
final slider = SleekCircularSlider(
                      appearance: CircularSliderAppearance(),
                      onChange: (double value) {
                        print(value);
                      });
```

Fine Tunings:

```dart
final slider = SleekCircularSlider(
  min: 0,
  max: 1000,
  initialValue: 426,
  onChange: (double value) {
    // callback providing a value while its being changed (with a pan gesture)
  },
  onChangeStart: (double startValue) {
    // callback providing a starting value (when a pan gesture starts)
  },
  onChangeEnd: (double endValue) {
    // ucallback providing an ending value (when a pan gesture ends)
  },
  innerWidget: (double value) {
    // use your custom widget inside the slider (gets a slider value from the callback)
  },
);
```

# Progress Bar
Disable interaction with an empty 'onChange' or 'onChangeEnd'.

```dart
final slider = SleekCircularSlider(
  appearance: CircularSliderAppearance(
    customWidths: CustomSliderWidths(progressBarWidth: 10)),
  min: 10,
  max: 28,
  initialValue: 14,
);
```

# Spinner

Ignores Angles and Spins for all your Loading Screen needs.

```dart
final slider = SleekCircularSlider(
  appearance: CircularSliderAppearance(
    spinnerMode: true,
));
```

---

# Customizations


## SleekCircularSlider parameters


| Parameter                 |                       Default                       | Description                                                                                                             |
| :------------------------ | :-------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------- |
| **appearance** *CircularSliderAppearance*    |                                                     | Objects describing the slider look and feel.                                                             |
| **min** *double*                     |                         0                           | Minimum interactive value.  min <= max. |
| **max** *double*                     |                         100                         | Maximum interactive value. Must be greater than or equal to min.  |
| **initialValue** *double*            |                          50                         | Circular Starting Value                      |
| **onChange** *OnChange(double value)*|                                                     | Interaction update, during sliding. |
| **onChangeStart** *OnChange(double value)* |                                               | Called when the user starts selecting a new value for the slider. |
| **onChangeEnd**  *OnChange(double value)*  |                                                     | Called when the user is done with their interaction. |
| **innerWidget** *Widget InnerWidget(double value)* |                                       | Replace the Circular innards. |



## CircularSliderAppearance parameters

| Parameter                 |                       Default                       | Description                                                                                                             |
| :------------------------ | :-------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------- |
| **size** *double*                    |                        150                          | Width & Height                    |
| **startAngle** *double*              |                        150                          | Start Angle.            |
| **angleRange** *double*              |                        240                          | Maximum Possible Angle. |
| **counterClockwise** *bool*          |                       false                         | Circular Direction.                         |
| **customWidths** *CustomSliderWidths*|                                                     | Circular Width.        |
| **customColors** *CustomSliderColors*|                                                     | Circular Colors.        |
| **infoProperties** *InfoProperties*  |                                                     | Internal Label Creation. |
| **animationEnabled** *bool*          |                       true                          | Animate the Sliders Main Label.  |
| **spinnerMode** *bool*               |                       false                         | Circular is Spinner.                       |
| **spinnerDuration** *int*            |                        1500                         | Circular Animation in Milliseconds                            |
| **animDurationMultiplier** *double*  |                        1.0                          | Animation Speed on Interaction.                           |



## CustomSliderWidths parameters

| Parameter                 |                       Default                       | Description                                                                                                             |
| :------------------------ | :-------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------- |
| **trackWidth** *double*              |                progressBarWidth / 4                 | Track Width.                        |
| **progressBarWidth** *double*        |                 slider's size / 10                  | Progress Bar Width                 |
| **shadowWidth** *double*             |                progressBarWidth * 1.4               | Slider Shadow Width.  |
| **handlerSize** *double*             |                progressBarWidth / 5                 | Slider Handler Size |


## CustomSliderColors parameters

| Parameter                 |                       Default                       | Description                                                                                                             |
| :------------------------ | :-------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------- |
| **trackColor** *Color*               |                #DCBEFB                              | Slider Track Color.                        |
| **trackColors** *List<Color>*        |                  null                               | Slider Track Gradient                  |                 
| **trackGradientStartAngle** *double* |                   0                                 | The start angle for the track's gradient.           |
| **trackGradientEndAngle** *double*   |                  180                                | The end angle for the track's gradient.           |
| **progressBarColor** *Color*         |                                                     | Progress Bar Color, ignored when gradient is defined. |
| **progressBarColors** *List<Color>*  |      [#1E003B, #EC008A, #6285DA]                    | Progress Bar Gradient Palette.       |
| **gradientStartAngle** *double*      |                   0                                 | Gradient Start Angle.          |
| **gradientEndAngle** *double*        |                  180                                | Gradient Stop Angle.           |
| **dynamicGradient** *bool*           |                  false                              | Ignore gradient angles. To prevent the dynamic change of gradient angle.          |
| **dotColor** *Color*                 |                #FFFFFF                              | Slider Handle Color.                       |
| **hideShadow** *bool*                |                  false                              | The setting indicating whether the shadow should be showed. |
| **shadowColor** *Color*              |                #2C57C0                              | Shadow Color. |
| **shadowMaxOpacity** *double*        |                    0.2                              | Shadow Opacity.             |
| **shadowStep** *double*              |                                                     |  Determines the size of each Step. The more steps painted the softer the shadow. Achieve a flat shadow using: **shadowWidth** - **progressWidth**.|


## InfoProperties parameters

| Parameter                 |                       Default                       | Description                                                                                                             |
| :------------------------ | :-------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------- |
| **mainLabelStyle** *TextStyle*       |                                                     | Main Label Text Style.     |
| **topLabelStyle** *TextStyle*        |                                                     | Top Label Text Style.                   |
| **bottomLabelStyle** *TextStyle*     |                                                     | Bottom Label Text Style.                |
| **topLabelText** *String*            |                                                     | Main Label Text.                          |
| **bottomLabelText** *String*         |                                                     | Bottom Label Text.                    |
| **modifier** *String PercentageModifier(double percentage)* | closure adding the **%** character | Current Value Displayed Modifier. |

**Example of the modifier**
Enabling value conversion to int and appending **%**.
 ```dart 
 String percentageModifier(double value) {
    final roundedValue = value.ceil().toInt().toString();
    return '$roundedValue %';
  }
``` 

## Future Possibles

- [ ] add divisions

- [ ] add more comments to document the code

- [x] add the counterclockwise direction

- [x] add the spinner mode

- [ ] add the second handle (interval selection)

- [ ] add text labels on a curved path


## Acknowledgments

Adaptation:
[https://github.com/matthewfx/sleek_circular_slider](https://github.com/matthewfx/sleek_circular_slider)

Link From: 
[https://github.com/matthewfx/sleek_circular_slider](https://github.com/matthewfx/sleek_circular_slider)
[![YouTube Video of the example in action](https://img.youtube.com/vi/ECXdRYs89QY/0.jpg)](https://youtu.be/ECXdRYs89QY)

# More Examples

![Example 01](doc/slider00.gif) ![Example 02](doc/slider01.gif)
![Example 03](doc/slider02.gif) ![Example 04](doc/slider03.gif)
![Example 05](doc/slider04.gif) ![Example 12](doc/slider11.gif)
![Example 07](doc/slider06.gif) ![Example 08](doc/slider05.gif)
![Example 09](doc/slider08.gif) ![Example 10](doc/slider09.gif)
![Example 11](doc/slider10.gif) 
