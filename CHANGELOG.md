## [1.0.0] - 2019-10-07.

* Initial release of the circular slider for Flutter.

## [1.0.1] - 2019-10-08.

* Trying to figure out why Flutter Pub website doesn't display gifs in the README.md

## [1.0.2] - 2019-10-08.

* Another attempt to fix gifs in the README.md

## [1.0.3] - 2019-10-08.

* The last attempt to fix it by modifing the homepage in the pubspec.yaml

## [1.0.4] - 2019-10-08.

* Fixed a bug causing an exception to be thrown when onChangeStart or onChangeEnd were null

## [1.0.5] - 2019-10-09.

* Fixed a bug causing an exception to be thrown when there was the **setState** being called from the **onChange** closure

## [1.0.6] - 2019-10-17.
* Changes to the ReadMe.md to fix a spelling in parameters and add some more claryfication about using the widges as a progress bar

## [1.0.7] - 2019-10-19.
* Simplified the constructor. There is no longer need to provide the CircularSliderAppearance if one wants to use the default one.

## [1.1.0] - 2020-03-12
* Added the spinner mode.
* Added the clockwise direction.
* Fixed a bug - an unhandled exception when the min and max values were equal.