import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraPage({super.key, required this.cameras});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _cameraController;
  Future<void>? _initializeControllerFuture;
  bool isFrontCamera = true;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      _initializeCamera();
    } else {
      print("Camera permission denied");
    }
  }

  void _initializeCamera() async {
    if (widget.cameras.isEmpty) {
      print("No cameras available!");
      return;
    }

    CameraDescription? selectedCamera = widget.cameras.firstWhere(
      (camera) => isFrontCamera
          ? camera.lensDirection == CameraLensDirection.front
          : camera.lensDirection == CameraLensDirection.back,
      orElse: () => widget.cameras.first,
    );

    try {
      _cameraController = CameraController(
        selectedCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      _initializeControllerFuture = _cameraController!.initialize().then((_) {
        if (mounted) {
          setState(() {});
        }
      });
    } catch (e) {
      print("Error initializing camera: $e");
      setState(() {
        _cameraController = null;
      });
    }
  }

  void _switchCamera() {
    setState(() {
      isFrontCamera = !isFrontCamera;
    });
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _takePicture(BuildContext context) async {
    try {
      if (_initializeControllerFuture == null || _cameraController == null) {
        print("Camera is not initialized yet!");
        return;
      }

      await _initializeControllerFuture;
      final XFile picture = await _cameraController!.takePicture();
      print("Picture taken: ${picture.path}");

      _showResultDialog(context, success: true);
    } catch (e) {
      print("Error taking picture: $e");
      _showResultDialog(context, success: false);
    }
  }

  void _showResultDialog(BuildContext context, {required bool success}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(success ? 'Success' : 'Failed'),
          content: Text(success
              ? 'Picture taken successfully!'
              : 'Failed to capture image. Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera')),
      body: Stack(
        children: [
          Positioned.fill(
            child: FutureBuilder(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    _cameraController != null) {
                  return AspectRatio(
                    aspectRatio: _cameraController!.value.aspectRatio,
                    child: isFrontCamera
                        ? Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(3.1415926535897932),
                            child: CameraPreview(_cameraController!),
                          )
                        : CameraPreview(_cameraController!),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () => _takePicture(context),
                  child: const Icon(Icons.camera),
                ),
                FloatingActionButton(
                  onPressed: _switchCamera,
                  child: const Icon(Icons.switch_camera),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
