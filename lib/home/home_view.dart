import 'package:flutter/material.dart';
import 'package:task_one_animation_with_custom_paint/animations/explicit_animation_practice_view.dart';
import 'package:task_one_animation_with_custom_paint/animations/implicit_animation_practice_view.dart';
import 'package:task_one_animation_with_custom_paint/custom_painters/custom_painter_examples.dart';
import 'package:task_one_animation_with_custom_paint/widgets/section_button.dart';

//home view showing different type of  and custom paint

//animation == value changing overtime plus widget rebuilding based on that value.

// gives two major approach - implicit and explicit.
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animations with CustomPaint')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionButton(
                onTap: () {
                  _navigate(
                    pageName: ImplicitAnimationPracticeView(),
                    context: context,
                  );
                },
                title: "Implicit Animations",
              ),
              SectionButton(
                onTap: () {
                  _navigate(
                    pageName: ExplicitAnimationPracticeView(),
                    context: context,
                  );
                },
                title: "Explicit Animations",
              ),
              SectionButton(
                onTap: () {
                  _navigate(
                    pageName: CustomPainterExampless(),
                    context: context,
                  );
                },
                title: "Custom Painters",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigate({required Widget pageName, required BuildContext context}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => pageName));
  }
}
