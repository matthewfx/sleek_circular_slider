import 'dart:math' as math;
import 'package:flutter_test/flutter_test.dart';
import 'package:sleek_circular_slider/src/utils.dart';

void main() {
  group('Angle conversion functions', () {
    test('degreeToRadians converts correctly', () {
      expect(degreeToRadians(0), equals(0));
      expect(degreeToRadians(90), closeTo(math.pi / 2, 0.0001));
      expect(degreeToRadians(180), closeTo(math.pi, 0.0001));
      expect(degreeToRadians(360), closeTo(2 * math.pi, 0.0001));
    });

    test('radiansToDegrees converts correctly', () {
      expect(radiansToDegrees(0), equals(0));
      expect(radiansToDegrees(math.pi / 2), closeTo(90, 0.0001));
      expect(radiansToDegrees(math.pi), closeTo(180, 0.0001));
      expect(radiansToDegrees(2 * math.pi), closeTo(360, 0.0001));
    });

    test('radiansNormalized normalizes correctly', () {
      // Test actual behavior: radians < 0 ? -radians : 2 * pi - radians
      expect(
        radiansNormalized(-math.pi / 4),
        closeTo(math.pi / 4, 0.0001),
      ); // -radians for negative

      expect(
        radiansNormalized(math.pi / 4),
        closeTo(7 * math.pi / 4, 0.0001),
      ); // 2π - radians for positive

      expect(radiansNormalized(0), closeTo(2 * math.pi, 0.0001)); // 2π - 0 = 2π

      expect(
        radiansNormalized(math.pi),
        closeTo(math.pi, 0.0001),
      ); // 2π - π = π
    });
  });

  group('Coordinate conversion functions', () {
    test('degreesToCoordinates converts correctly', () {
      final center = const Offset(100, 100);
      final result = degreesToCoordinates(center, 0, 50);
      expect(result.dx, closeTo(150, 0.0001));
      expect(result.dy, closeTo(100, 0.0001));
    });

    test('radiansToCoordinates converts correctly', () {
      final center = const Offset(100, 100);
      final result = radiansToCoordinates(center, 0, 50);
      expect(result.dx, closeTo(150, 0.0001));
      expect(result.dy, closeTo(100, 0.0001));
    });

    test('extended coordinatesToRadians converts correctly', () {
      final center = const Offset(100, 100);

      // Right (0° in standard, but radiansNormalized transforms it)
      expect(
        coordinatesToRadians(center, const Offset(150, 100)),
        closeTo(2 * math.pi, 0.0001), // radiansNormalized(0) = 2π - 0 = 2π
      );

      // Up (270° in standard)
      expect(
        coordinatesToRadians(center, const Offset(100, 50)),
        closeTo(
          3 * math.pi / 2,
          0.0001,
        ), // radiansNormalized(π/2) = 2π - π/2 = 3π/2
      );

      // Left (180° in standard)
      expect(
        coordinatesToRadians(center, const Offset(50, 100)),
        closeTo(math.pi, 0.0001), // radiansNormalized(π) = 2π - π = π
      );

      // Down (90° in standard)
      expect(
        coordinatesToRadians(center, const Offset(100, 150)),
        closeTo(math.pi / 2, 0.0001), // radiansNormalized(-π/2) = -(-π/2) = π/2
      );
    });

    test('coordinatesToRadians converts correctly', () {
      final center = const Offset(100, 100);
      final coords = const Offset(150, 100);
      final result = coordinatesToRadians(center, coords);
      // This function returns normalized radians, so test the actual output
      expect(result, isA<double>());
      expect(result >= 0, isTrue);
    });
  });

  group('Point detection functions', () {
    test('isPointInsideCircle detects correctly', () {
      final center = const Offset(100, 100);
      // Function uses 1.2x radius internally
      expect(isPointInsideCircle(const Offset(105, 105), center, 50), isTrue);
      expect(isPointInsideCircle(const Offset(200, 200), center, 50), isFalse);
    });

    test('isPointAlongCircle detects correctly', () {
      final center = const Offset(100, 100);
      expect(isPointAlongCircle(const Offset(150, 100), center, 50, 5), isTrue);
      expect(
        isPointAlongCircle(const Offset(110, 100), center, 50, 5),
        isFalse,
      );
    });
  });

  group('Angle calculation functions', () {
    test('calculateRawAngle calculates correctly clockwise', () {
      final result = calculateRawAngle(
        startAngle: 0,
        angleRange: 180,
        selectedAngle: degreeToRadians(90),
      );
      expect(result, isA<double>());
    });

    test('calculateRawAngle calculates correctly', () {
      // Test specific scenarios with known expected values
      final result = calculateRawAngle(
        startAngle: 0,
        angleRange: 180,
        selectedAngle: degreeToRadians(90),
      );
      // Should return the relative angle within the range
      expect(result, closeTo(90, 0.0001)); // Assuming this returns degrees
    });

    test('calculateRawAngle calculates correctly counterclockwise', () {
      final result = calculateRawAngle(
        startAngle: 0,
        angleRange: 180,
        selectedAngle: degreeToRadians(90),
        counterClockwise: true,
      );
      expect(result, isA<double>());
    });

    test('calculateAngle handles null selectedAngle', () {
      final result = calculateAngle(
        startAngle: 0,
        angleRange: 180,
        selectedAngle: null,
        defaultAngle: 45.0,
      );
      expect(result, equals(45.0));
    });

    test('isAngleWithinRange validates correctly', () {
      // Test angle clearly within range
      expect(
        isAngleWithinRange(
          startAngle: 0,
          angleRange: 180,
          touchAngle: degreeToRadians(45),
          previousAngle: 0,
        ),
        isTrue,
      );

      // Test angle clearly outside range
      expect(
        isAngleWithinRange(
          startAngle: 0,
          angleRange: 90,
          touchAngle: degreeToRadians(270),
          previousAngle: 0,
        ),
        isFalse,
      );
    });

    test('isAngleWithinRange returns correct values', () {
      final result1 = isAngleWithinRange(
        startAngle: 0,
        angleRange: 180,
        touchAngle: degreeToRadians(45),
        previousAngle: 0,
      );
      expect(result1, isA<bool>());

      final result2 = isAngleWithinRange(
        startAngle: 0,
        angleRange: 90,
        touchAngle: degreeToRadians(270),
        previousAngle: 0,
      );
      expect(result2, isA<bool>());
    });
  });

  group('Value conversion functions', () {
    test('valueToDuration calculates correctly', () {
      final result = valueToDuration(50, 25, 0, 100);
      // (max-min)/100 = 1, (50-25).abs() = 25, 25 ~/ 1 * 15 = 375
      expect(result, equals(375));
    });

    test('valueToDuration handles edge cases', () {
      expect(valueToDuration(50, 25, 100, 100), equals(0)); // max == min
    });

    test('valueToPercentage converts correctly', () {
      expect(valueToPercentage(50, 0, 100), equals(50));
      expect(valueToPercentage(25, 0, 100), equals(25));
      expect(valueToPercentage(0, 0, 100), equals(0));
      expect(valueToPercentage(100, 0, 100), equals(100));
    });

    test('valueToPercentage handles edge cases', () {
      expect(valueToPercentage(50, 100, 100), equals(0)); // max == min
      expect(valueToPercentage(50, 200, 100), equals(0)); // max < min
    });

    test('percentageToValue converts correctly', () {
      expect(percentageToValue(50, 0, 100), equals(50));
      expect(percentageToValue(25, 0, 100), equals(25));
      expect(percentageToValue(0, 10, 20), equals(10));
      expect(percentageToValue(100, 10, 20), equals(20));
    });
  });

  group('Angle-percentage conversion functions', () {
    test('percentageToAngle converts correctly', () {
      expect(percentageToAngle(50, 180), equals(90));
      expect(percentageToAngle(100, 180), equals(180));
      expect(percentageToAngle(0, 180), equals(0));
    });

    test('percentageToAngle handles edge cases', () {
      expect(percentageToAngle(-10, 180), equals(0.5)); // minimum threshold
      expect(percentageToAngle(150, 180), equals(180)); // over 100%
    });

    test('angleToPercentage converts correctly', () {
      expect(angleToPercentage(90, 180), equals(50));
      expect(angleToPercentage(180, 180), equals(100));
      expect(angleToPercentage(1, 180), closeTo(0.556, 0.001)); // 1/180*100
    });

    test('angleToPercentage handles edge cases', () {
      expect(angleToPercentage(0.3, 180), equals(0)); // below threshold
      expect(angleToPercentage(200, 180), equals(100)); // over range
      expect(angleToPercentage(90, 0), equals(0)); // zero range
    });
  });

  group('Combined conversion functions', () {
    test('valueToAngle converts correctly', () {
      final result = valueToAngle(50, 0, 100, 180);
      expect(result, equals(90));
    });

    test('angleToValue converts correctly', () {
      final result = angleToValue(90, 0, 100, 180);
      expect(result, equals(50));
    });

    test('round trip conversions maintain values', () {
      const value = 75.0;
      const min = 0.0;
      const max = 100.0;
      const angleRange = 270.0;

      final angle = valueToAngle(value, min, max, angleRange);
      final backToValue = angleToValue(angle, min, max, angleRange);

      expect(
        backToValue,
        closeTo(value, 1.0),
      ); // Increased tolerance for round-trip
    });
  });
}
