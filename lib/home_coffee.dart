import 'dart:ui';

import 'package:coffe_app/coffee.dart';
import 'package:coffe_app/coffee_list.dart';
import 'package:flutter/material.dart';

class HomeCoffee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta < -20) {
            Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 600),
              pageBuilder: (context, animation, secondaryAnimation) {
                return FadeTransition(
                  opacity: animation,
                  child: CoffeeList(),
                );
              },
            ));
          }
        },
        child: Stack(
          children: [
            SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFA89276), Colors.white])),
              ),
            ),
            Positioned(
                height: size.height * .4,
                left: 0,
                right: 0,
                top: size.height * .15,
                child: Hero(
                    tag: coffees[2].name,
                    child: Image.asset(coffees[2].image))),
            Positioned(
                height: size.height * .7,
                left: 0,
                right: 0,
                bottom: 0,
                child: Hero(
                    tag: coffees[3].name,
                    child: Image.asset(
                      coffees[3].image,
                      fit: BoxFit.cover,
                    ))),
            Positioned(
                height: size.height,
                left: 0,
                right: 0,
                bottom: -size.height * .7,
                child: Hero(
                    tag: coffees[4].name,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Image.asset(
                        coffees[4].image,
                        fit: BoxFit.cover,
                      ),
                    ))),
            Positioned(
                height: 90,
                left: 0,
                right: 0,
                bottom: size.height * .30,
                child: Image.asset(
                  'assets/images/logo.png',
                )),
          ],
        ),
      ),
    );
  }
}
