import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  // final List<CameraDescription> cameras;

  const CameraScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  @override
  Widget build(BuildContext context) {
    if (!controller!.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
      aspectRatio: controller!.value.aspectRatio,
      child: CameraPreview(controller!),
    );
  }
}
