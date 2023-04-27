import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Circular Avatar series',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('A Row of Circular icons'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                //aligns children to Center.
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  AvatarAnimation(
                    backgroundColor: Colors.purple,
                    label: 'CV',
                  ),
                  SizedBox(
                    width: 2.5,
                  ),
                  AvatarAnimation(
                    backgroundColor: Colors.purple,
                    label: 'SB',
                  ),
                  SizedBox(
                    width: 2.5,
                  ),
                  AvatarAnimation(
                    backgroundColor: Colors.purple,
                    label: 'VG',
                  ),
                  SizedBox(
                    width: 2.5,
                  ),
                  AvatarAnimation(
                    backgroundColor: Colors.purple,
                    label: 'MB',
                  ),
                ],
              ),
            )));
  }
}
class AvatarAnimation extends StatefulWidget {
  final Color backgroundColor;
  final String label;

  const AvatarAnimation({
    Key? key,
    required this.backgroundColor,
    required this.label,
  }) : super(key: key);

  @override
  _AvatarAnimationState createState() => _AvatarAnimationState();
}

class _AvatarAnimationState extends State<AvatarAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  );

  late final Animation<double> _animation = Tween(
    begin: 0.0,
    end: 30.0,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  ));


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _controller.forward();
        });
      },
      onExit: (event) {
        setState(() {
          _controller.reverse();
        });
      },
      child: InkWell(
        onTap: () {},
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _animation.value),
              child: child,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.orange, // changed to orange
                width: 5.0,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: widget.backgroundColor,
              radius: 50.0,
              child: CircleAvatar( // added orange circular avatar
                backgroundColor: Colors.orange,
                radius: 52.0,
                child: CircleAvatar(
                  backgroundColor: widget.backgroundColor,
                  radius: 50.0,
                  child: Text(
                    widget.label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
