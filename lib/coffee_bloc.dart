import 'package:flutter/cupertino.dart';

const _initialPage = 4.0;

class CoffeeBloc {
  final pageCoffeeController =
      PageController(viewportFraction: .35, initialPage: _initialPage.toInt());
  final pageTextController = PageController(initialPage: _initialPage.toInt());
  final currentPage = ValueNotifier<double>(_initialPage);
  final textPage = ValueNotifier<double>(_initialPage);

  void _coffeeScrollListener() {
    currentPage.value = pageCoffeeController.page;
  }

  void _textScrollController() {
    textPage.value = pageCoffeeController.page;
  }

  void init() {
    currentPage.value = _initialPage;
    textPage.value = _initialPage;
    pageCoffeeController.addListener(_coffeeScrollListener);
    pageTextController.addListener(_textScrollController);
  }

  void dipose() {
    pageCoffeeController.removeListener(_coffeeScrollListener);
    pageTextController.removeListener(_textScrollController);
    pageCoffeeController.dispose();
    pageTextController.dispose();
  }
}

class CoffeeProvider extends InheritedWidget {
  final CoffeeBloc bloc;

  CoffeeProvider({@required this.bloc, Widget child}) : super(child: child);

  static CoffeeProvider of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<CoffeeProvider>();

  @override
  bool updateShouldNotify(covariant CoffeeProvider oldWidget) => false;
}
