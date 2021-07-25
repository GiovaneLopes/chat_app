import 'package:animation_login/features/auth/presentation/widgets/clipper_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as Math;

class WaveWidget extends StatefulWidget {
  final double yOffset;
  final Size size;
  final Color color;
  const WaveWidget({Key key, this.yOffset, this.size, this.color})
      : super(key: key);

  @override
  _WaveWidgetState createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget> with TickerProviderStateMixin {
  double yOffset;
  AnimationController _animationController;
  List<Offset> wavePoints = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 5000,
      ),
    )..addListener(() {
        wavePoints.clear();
        final double waveSpped = _animationController.value * 1000;
        final double fullSphere = _animationController.value * Math.pi * 2;
        final double normalizer = Math.cos(fullSphere);
        final double waveWidth = Math.pi / 270;
        final double waveHeight = 20;

        for (int i = 0; i <= widget.size.width.toInt(); i++) {
          double calc = Math.sin((waveSpped - i) * waveWidth);

          wavePoints.add(Offset(
              i.toDouble(), calc * waveHeight * normalizer + widget.yOffset));
        }
      });
    _animationController.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        return ClipPath(
          clipper: ClipperWidget(wavePoints),
          child: Container(
            width: widget.size.width,
            height: widget.size.height,
            color: widget.color,
          ),
        );
      },
    );
  }
}
