import 'dart:math';
import 'package:flutter/material.dart';

class ExplicitAnimationPracticeView extends StatefulWidget {
  const ExplicitAnimationPracticeView({super.key});

  @override
  State<ExplicitAnimationPracticeView> createState() =>
      _ExplicitAnimationPracticeViewState();
}

class _ExplicitAnimationPracticeViewState
    extends State<ExplicitAnimationPracticeView>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  int _previousIndex = 0;

  Offset _tapPosition = Offset.zero;
  late final AnimationController _controller;
  late final Animation<double> _radius;

  double _maxRadius = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _radius = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
  }

  final List<List<Color>> gradients = [
    [Color(0xFFFF758C), Color(0xFFFF7EB3)],
    [Color(0xFF43C6AC), Color(0xFF191654)],
    [Color(0xFFFFA17F), Color(0xFFFFD194)],
    [Color(0xFF667EEA), Color(0xFF764BA2)],
    [Color(0xFF89F7FE), Color(0xFF66A6FF)],
    [Color.fromARGB(255, 179, 139, 139), Color.fromARGB(255, 185, 43, 43)],
  ];

  double _calcMaxRadius(Offset tapPosition, Size size) {
    final corners = [
      Offset(0, 0),
      Offset(size.width, 0),
      Offset(0, size.height),
      Offset(size.width, size.height),
    ];
    return corners.map((c) => (c - tapPosition).distance).reduce(max);
  }

  void _onTap(int index, Offset position, Size size) {
    if (index == _currentIndex) return;
    setState(() {
      _previousIndex = _currentIndex;
      _currentIndex = index;

      _tapPosition = position;
      _maxRadius = _calcMaxRadius(position, size);
    });
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(_previousIndex),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => ClipPath(
              clipper: CircleRevealClipper(
                center: _tapPosition,
                radius: _radius.value * _maxRadius,
              ),
              child: _buildBackground(_currentIndex),
            ),
          ),

          SafeArea(
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
                _buildWaveCarousel(),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaveCarousel() {
    final screenWidth = MediaQuery.of(context).size.width;
    const circleSize = 80.0;

    return SizedBox(
      height: 160,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(gradients.length, (index) {
          final distance = (index - _currentIndex).abs();
          final offset = index - _currentIndex;
          final yOffset = distance == 0
              ? 0.0
              : distance == 1
              ? 30.0
              : 60.0;
          final scale = distance == 0 ? 1.0 : 0.8;
          final xCenter = screenWidth * 0.5 + offset * (circleSize + 15);
          return AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            left: xCenter,
            top: yOffset,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapUp: (details) {
                final size = MediaQuery.of(context).size;
                _onTap(index, details.globalPosition, size);
              },
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

  Widget _buildBackground(int index) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradients[index],
        ),
      ),
    );
  }
}

class CircleRevealClipper extends CustomClipper<Path> {
  final Offset center;
  final double radius;

  const CircleRevealClipper({required this.center, required this.radius});

  @override
  Path getClip(Size size) {
    return Path()..addOval(Rect.fromCircle(center: center, radius: radius));
  }

  @override
  bool shouldReclip(CircleRevealClipper oldClipper) {
    return oldClipper.radius != radius || oldClipper.center != center;
  }
}
