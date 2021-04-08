import 'package:coffe_app/coffee_bloc.dart';
import 'package:coffe_app/home_coffee.dart';
import 'package:flutter/material.dart';

class MainCoffee extends StatefulWidget {
  @override
  _MainCoffeeState createState() => _MainCoffeeState();
}

class _MainCoffeeState extends State<MainCoffee> {
  final bloc = CoffeeBloc();

  @override
  void initState() {
    bloc.init();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dipose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData.light(),
        child: CoffeeProvider(
            bloc: bloc,
            child: MaterialApp(
                debugShowCheckedModeBanner: false, home: HomeCoffee())));
  }
}
