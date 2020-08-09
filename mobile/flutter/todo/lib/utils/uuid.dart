import 'dart:math';

class Uuid {
  int get uuid => Random().nextInt(200) * 20;
}
