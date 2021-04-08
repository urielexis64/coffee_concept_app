import 'package:coffe_app/coffee.dart';
import 'package:coffe_app/coffee_detail.dart';
import 'package:flutter/material.dart';

const _duration = Duration(milliseconds: 300);
const _initialPage = 4.0;

class CoffeeList extends StatefulWidget {
  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  final _pageCoffeeController =
      PageController(viewportFraction: .35, initialPage: _initialPage.toInt());
  final _pageTextController = PageController(initialPage: _initialPage.toInt());
  double _currentPage = _initialPage;
  double _textPage = _initialPage;

  void _coffeeScrollListener() {
    setState(() {
      _currentPage = _pageCoffeeController.page;
    });
  }

  void _textScrollController() {
    _textPage = _currentPage;
  }

  @override
  void initState() {
    _pageCoffeeController.addListener((_coffeeScrollListener));
    _pageTextController.addListener(_textScrollController);
    super.initState();
  }

  @override
  void dispose() {
    _pageCoffeeController.removeListener((_coffeeScrollListener));
    _pageTextController.removeListener((_textScrollController));
    _pageCoffeeController.dispose();
    _pageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            left: 20,
            right: 20,
            bottom: -size.height * 0.22,
            height: size.height * 0.3,
            child: DecoratedBox(
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
              BoxShadow(color: Colors.brown, blurRadius: 90, spreadRadius: 45)
            ])),
          ),
          Transform.scale(
            scale: 1.8,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
                controller: _pageCoffeeController,
                scrollDirection: Axis.vertical,
                onPageChanged: (value) {
                  if (value < coffees.length) {
                    _pageTextController.animateToPage(value,
                        duration: _duration, curve: Curves.easeOut);
                  }
                },
                itemCount: coffees.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0 || index == coffees.length + 1) {
                    return const SizedBox.shrink();
                  }
                  final coffee = coffees[index - 1];
                  final result = _currentPage - index + 1;
                  final value = -0.4 * result + 1;
                  final opacity = value.clamp(0.0, 1.0);

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 600),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return FadeTransition(
                            opacity: animation,
                            child: CoffeeDetail(
                              coffee: coffee,
                            ),
                          );
                        },
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..translate(
                                0.0, size.height / 2.6 * (1 - value).abs())
                            ..scale(value),
                          child: Opacity(
                              opacity: opacity,
                              child: Hero(
                                tag: coffee.name,
                                child: Image.asset(
                                  coffee.image,
                                  fit: BoxFit.fitHeight,
                                ),
                              ))),
                    ),
                  );
                }),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 100,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 1, end: 0),
              duration: _duration,
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, -100 * value),
                  child: child,
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: coffees.length,
                    controller: _pageTextController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final opacity =
                          (1 - (index - _textPage).abs()).clamp(0.0, 1.0);
                      return Opacity(
                          opacity: opacity,
                          child: Center(
                            child: _currentPage.toInt() == 12
                                ? SizedBox.shrink()
                                : Hero(
                                    tag: 'text_${coffees[index].name}',
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Text(
                                        coffees[index].name,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                          ));
                    },
                  )),
                  AnimatedSwitcher(
                    duration: _duration,
                    child: _currentPage.toInt() == 12
                        ? SizedBox.shrink()
                        : Text(
                            '\$${coffees[_currentPage.toInt()].price.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 24),
                            key: Key(coffees[_currentPage.toInt()].name),
                          ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
