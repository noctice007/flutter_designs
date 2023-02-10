import 'package:flutter/material.dart';

extension ListExtension<T> on List<T> {
  List<T> addBetween(T t) {
    if (isEmpty) return [];
    final result = <T>[];
    for (var e in this) {
      result.add(e);
      result.add(t);
    }
    return result;
  }
}

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      );
}

const kBackgroundColor = Color(0xFFDDE4EE);

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            NeumorphicButton(
              icon: Icon(Icons.home_sharp),
            ),
            NeumorphicButton(
              icon: Icon(Icons.person),
            ),
            NeumorphicButton(
              icon: Icon(Icons.electric_bolt),
            ),
            NeumorphicButton(
              icon: Icon(Icons.notifications),
            ),
            NeumorphicButton(
              icon: Icon(
                Icons.settings,
              ),
            ),
          ]
              .map(
                (e) => SizedBox(
                  height: size.width * 0.1,
                  width: size.width * 0.1,
                  child: e,
                ),
              )
              .toList()
              .addBetween(
                const SizedBox(
                  width: 20,
                ),
              ),
        ),
      ),
    );
  }
}

class NeumorphicButton extends StatefulWidget {
  const NeumorphicButton({
    super.key,
    required this.icon,
  });
  final Widget icon;

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

const kBlurRadius = 5.0;
const kSpreadRadius = 1.0;
const kBottomRightOffset = Offset(2, 2);
const kTopLeftOffset = Offset(-2, -2);

class _NeumorphicButtonState extends State<NeumorphicButton> {
  var _isPressed = false;
  static const outerShadow = [
    BoxShadow(
      offset: kBottomRightOffset,
      blurRadius: kBlurRadius,
      spreadRadius: kSpreadRadius,
      color: Colors.grey,
    ),
    BoxShadow(
      offset: kTopLeftOffset,
      blurRadius: kBlurRadius,
      spreadRadius: kSpreadRadius,
      color: Colors.white,
    ),
  ];
  static const innerShadow = [
    BoxShadow(
      offset: kTopLeftOffset,
      blurRadius: kBlurRadius,
      spreadRadius: kSpreadRadius,
      color: Colors.grey,
      blurStyle: BlurStyle.inner,
    ),
    BoxShadow(
      offset: kBottomRightOffset,
      blurRadius: kBlurRadius,
      spreadRadius: kSpreadRadius,
      color: Colors.white,
      blurStyle: BlurStyle.inner,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isPressed = !_isPressed),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kBackgroundColor,
          boxShadow: _isPressed ? innerShadow : outerShadow,
        ),
        alignment: Alignment.center,
        child: widget.icon,
      ),
    );
  }
}
