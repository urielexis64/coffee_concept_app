import 'package:coffe_app/coffee_list.dart';
import 'package:flutter/material.dart';

class HomeCoffee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(data: ThemeData.light(), child: CoffeeList());
  }
}
