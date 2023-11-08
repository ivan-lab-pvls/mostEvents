// ignore_for_file: file_names

import 'dart:math';

double getRandomDouble() {
  final random = Random();
  const min = 0.1;
  const max = 7.0;
  final randomDouble = random.nextDouble();
  final result = min + (randomDouble * (max - min));

  return result;
}

int getRandomInt() {
  final random = Random();
  final result = random.nextInt(3);
  return result;
}
