import 'package:flutter/material.dart';

class ImplicitAnimationPracticeView extends StatefulWidget {
  const ImplicitAnimationPracticeView({super.key});

  @override
  State<ImplicitAnimationPracticeView> createState() =>
      _ImplicitAnimationPracticeViewState();
}

class _ImplicitAnimationPracticeViewState
    extends State<ImplicitAnimationPracticeView> {
  late final ValueNotifier<int> _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = ValueNotifier(0);
  }

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  final List<List<Color>> gradients = [
    [Color(0xFFFF758C), Color(0xFFFF7EB3)],
    [Color(0xFF43C6AC), Color(0xFF191654)],
    [Color(0xFFFFA17F), Color(0xFFFFD194)],
    [Color(0xFF667EEA), Color(0xFF764BA2)],
    [Color(0xFF89F7FE), Color(0xFF66A6FF)],
    [Color.fromARGB(255, 179, 139, 139), Color.fromARGB(255, 185, 43, 43)],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _currentIndex,
        builder: (context, value, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: gradients[value],
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Text(
                    "Pick Any Color",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  _buildWave(value),
                  const Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWave(int selectedIndex) {
    final screenWidth = MediaQuery.of(context).size.width;
    const circleSize = 80.0;

    return SizedBox(
      height: 160,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(gradients.length, (index) {
          final distance = (index - selectedIndex).abs();
          final offset = index - selectedIndex;
          final yOffset = distance == 0
              ? 0.0
              : distance == 1
              ? 30.0
              : 60.0;
          final scale = distance == 0 ? 1.0 : 0.8;
          final xCenter = screenWidth * 0.5 + offset * (circleSize + 15);
          return AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            left: xCenter,
            top: yOffset,
            child: GestureDetector(
              onTap: () => _currentIndex.value = index,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                scale: scale,
                child: Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: gradients[index]),

                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      if (distance == 0)
                        const BoxShadow(
                          color: Colors.black26,
                          blurRadius: 16,
                          offset: Offset(0, 8),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
