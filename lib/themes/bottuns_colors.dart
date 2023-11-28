import 'package:flutter/material.dart';

import '../models/buttons.dart';

Color getButtonColor(value){
  return [
    Btn.del, Btn.clr].contains(value) ? Colors.blueGrey : 
    [Btn.per, Btn.multiply, Btn.add, Btn.subtract, Btn.divide, Btn.calculate]
    .contains(value) ? Colors.orange : 
    Colors.black87;
}