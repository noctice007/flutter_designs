import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const Home(),
      );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _x = 0.0;
  var _y = 0.0;
  var _z = 0.0;
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: StackedWidget(
                colors: [
                  for (var i = 900; i >= 100; i -= 100) Colors.purple[i]!,
                ],
                maxWidth: MediaQuery.of(context).size.width * 0.9,
                dif: 50,
                x: _x,
                y: _y,
                z: _z,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text('Z'),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Slider(
                              onChanged: (value) => setState(
                                () => _z = value,
                              ),
                              label: 'z',
                              value: _z,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text('Y'),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Slider(
                              onChanged: (value) => setState(
                                () => _y = value,
                              ),
                              label: 'y',
                              value: _y,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text('X'),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Slider(
                              onChanged: (value) => setState(
                                () => _x = value,
                              ),
                              label: 'x',
                              value: _x,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class StackedWidget extends StatefulWidget {
  const StackedWidget({
    super.key,
    required this.colors,
    required this.maxWidth,
    required this.dif,
    required this.x,
    required this.y,
    required this.z,
  });
  final List<Color> colors;
  final double x, y, z;
  final double maxWidth, dif;

  @override
  State<StackedWidget> createState() => _StackedWidgetState();
}

class _StackedWidgetState extends State<StackedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    )..forward();
    controller.addListener(() async {
      if (controller.isCompleted) {
        await Future.delayed(const Duration(
          milliseconds: 500,
        ));
        controller.reverse();
      } else if (controller.isDismissed) {
        await Future.delayed(
          const Duration(
            milliseconds: 500,
          ),
        );
        controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          for (var i = 0, width = widget.maxWidth;
              i < widget.colors.length;
              ++i, width = widget.maxWidth - widget.dif * i)
            Center(
              child: AnimatedBuilder(
                animation: CurvedAnimation(
                  parent: controller,
                  curve: Curves.easeOutBack,
                ),
                builder: (_, child) {
                  final circleRadius = width / 2.0;
                  final borderRadius =
                      circleRadius - (width * controller.value) / 2.0 * 0.8;
                  final container = Container(
                    width: width,
                    height: width,
                    decoration: BoxDecoration(
                      color: widget.colors[i],
                      borderRadius: BorderRadius.circular(borderRadius),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 10,
                          blurRadius: 30,
                        ),
                      ],
                    ),
                  );
                  return Transform(
                    alignment: FractionalOffset.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(pi * widget.x)
                      ..rotateY(pi * widget.y)
                      ..rotateZ(pi * widget.z),
                    child: Transform.rotate(
                      angle: (pi / 1.2) *
                          ((i + 1.0) / widget.colors.length) *
                          controller.value,
                      child: container,
                    ),
                  );
                },
              ),
            ),
        ],
      );
}
