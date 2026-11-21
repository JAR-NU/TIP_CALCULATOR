
import 'package:flutter_test/flutter_test.dart';
import 'package:tip_calculator/main.dart';

void main() {
  group('Tip Calculator Tests', () {

test('15 percent tip calculation', () {
    final result = computeTip(500, 15);

    expect(result.tip, 75.0);
    expect(result.total, 575.0);
    });

test('10 percent tip calculation', () {
    final result = computeTip(500, 10);

    expect(result.tip, 50.0);
      expect(result.total, 550.0);
    });

test('20 percent tip calculation', () {
      final result = computeTip(500, 20);

    expect(result.tip, 100.0);
      expect(result.total, 600.0);
    });

test('Valid bill input', () {
      expect(parseBill('500'), 500.0);
    });

test('Invalid bill input', () {
    expect(parseBill('abc'), isNull);
    });

test('Empty bill input', () {
  expect(parseBill(''), isNull);
    });

  });
}
