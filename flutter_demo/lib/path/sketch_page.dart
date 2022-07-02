import 'package:flutter/material.dart';

class SketchPad extends StatelessWidget {
  const SketchPad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('sketch')),
      body: _SketchPad(),
    );
  }
}

class _SketchPad extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SketchState();
  }
}

class SketchState extends State<_SketchPad> {
  final List<Offset> _points = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onPanUpdate: ((details) {
        setState(() {
          _points.add(details.localPosition);
        });
      }),
      onPanEnd: ((details) {}),
    );
  }
}
