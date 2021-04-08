import 'package:coffe_app/home_coffee.dart';
import 'package:flutter/material.dart';

class MainCoffee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(data: ThemeData.light(), child: HomeCoffee());
  }
}
