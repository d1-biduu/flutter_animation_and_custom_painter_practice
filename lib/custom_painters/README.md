# Custom Painter in Flutter

## What is Custom Painter?

CustomPainter is used when you want to create custom UI by drawing manually.

---

## How it works

```
CustomPaint widget  =>> gives a Canvas (paper)  => you draw on it using Paint (brush)
```

---

## Two things you always need

**`Paint`** — your brush. Defines color, thickness, and style.
```dart
final paint = Paint()
  ..color = Colors.blue
  ..strokeWidth = 4
  ..style = PaintingStyle.fill;   // filled shape
```

**`Canvas`** — Where you draw the UI
```dart
canvas.drawCircle(center, radius, paint);
canvas.drawLine(start, end, paint);
```

---

## Two methods you must override

**`paint`** — where you draw the UI
```dart
@override
void paint(Canvas canvas, Size size) {
  // canvas => blank canva
  // size   => width and height of canva
}
```

**`shouldRepaint`** — tells Flutter when to redraw
```dart
@override
bool shouldRepaint(CustomPainter oldDelegate) => false;
// false => never redraw, drawing is static
// true  => redraw when something changes
```

---


## Examples

### 1. Circle

```dart
class SimpleCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill; // filled circle

    // center of canvas
    final center = Offset(size.width / 2, size.height / 2);

    // draw circle at center with radius 100
    canvas.drawCircle(center, 100, paint);
  }

  @override
  bool shouldRepaint(SimpleCirclePainter oldDelegate) => false;
}
```

`drawCircle` takes 3 arguments:
- **center** => where to draw the circle
- **100** =>> radius in pixels 
- **paint** => brush 

---

### 2. Line

```dart
class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke; 

    canvas.drawLine(
      Offset(0, size.height / 2),          // start — left middle
      Offset(size.width, size.height / 2), // end   — right middle
      paint,
    );
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => false;
}
```

`drawLine` takes 3 arguments:
- **start point** =>> `Offset(0, size.height/2)` — left middle of canvas
- **end point** =>> `Offset(size.width, size.height/2)` — right middle of canvas
- **paint** =>> brush


---

### How to use in Screen
```dart
Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomPaint(size: Size(150, 150), painter: SimpleCirclePainter()),
          CustomPaint(size: Size(150, 150), painter: LinePainter()),
        ],
      ),
    );
  }
```

---
