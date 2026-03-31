# Flutter Animations

## What is Animation?

Animation is the process of making UI elements move, change, or transform over time to create a smooth and interactive experience. In Flutter, animations work by changing values over a duration — like moving a widget from left to right, fading it in, or changing its color.

---

## Types of Animation in Flutter

Flutter has two main types of animations:

**1. Implicit Animations**
Flutter handles the animation automatically. You just change a value and Flutter smoothly transitions between the old and new value on its own.

**2. Explicit Animations**
You handle the animation yourself using an `AnimationController`. This gives you full control — you decide when it starts, stops, repeats, and how it behaves at every frame.

---

### When to use which?


Simple property change (color, size, position) => Implicit 
Complex, custom animations => Explicit 
You need pixel level control => Explicit 

---

## For Implicit Animation Practice View


### What was used in the code: 

**`AnimatedContainer`** — animates the background gradient when a new color is selected.
```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 800),
  curve: Curves.easeOutCubic,
  decoration: BoxDecoration(
    gradient: LinearGradient(colors: gradients[value]),
  ),
)
```
When `_currentIndex` changes => background gradient smoothly transitions to new colors automatically.

---

**`AnimatedPositioned`** -smoothly moves a widget from its old position to a new position when the position values change!
```dart
AnimatedPositioned(
  duration: const Duration(milliseconds: 400),
  curve: Curves.easeOutCubic,
  left: xCenter,
  top: yOffset,
)
```
When a circle is selected => all circles smoothly slide to their new positions creating a wave effect.

---

**`AnimatedScale`** — animates the size of each circle.
```dart
AnimatedScale(
  duration: const Duration(milliseconds: 400),
  scale: scale,  // 1.0 for selected, 0.8 for others
)
```
Selected circle scales up, others scale down — all automatically.

---

## For Explicit Animation Practice View

 You manually control the animation using `AnimationController`.

### What was used:

**`AnimationController`** — controls when the animation starts and its duration.
```dart
_controller = AnimationController(
  vsync: this,
  duration: const Duration(milliseconds: 800),
);
```
When a circle is tapped => `_controller.forward(from: 0)` triggers the reveal animation.

---

**`CurvedAnimation`** — applies an easing curve to the animation.
```dart
_radius = CurvedAnimation(
  parent: _controller,
  curve: Curves.easeOutCubic,
);
```
Makes the circle reveal start fast and slow down smoothly at the end.

---

**`AnimatedBuilder`** — rebuilds only the circle reveal layer on every frame.
```dart
AnimatedBuilder(
  animation: _controller,
  builder: (context, child) => ClipPath(
    clipper: CircleRevealClipper(
      center: _tapPosition,
      radius: _radius.value * _maxRadius,
    ),
    child: _buildBackground(_currentIndex),
  ),
)
```
As `_radius.value` grows to maxRadius, the new background is revealed in a growing circle from the exact tap position.

---

**`CircleRevealClipper`** — custom clipper that clips the background into a circle shape.
```dart
class CircleRevealClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()..addOval(Rect.fromCircle(center: center, radius: radius));
  }
}
```
As radius grows => circle expands until it fully covers the screen revealing the new gradient.
