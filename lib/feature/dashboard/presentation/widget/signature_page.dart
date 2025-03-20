import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class SignaturePage extends StatefulWidget {
  const SignaturePage({super.key});

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  /// Save signature as an image
  Future<void> _saveSignature() async {
    final data = await _signaturePadKey.currentState?.toImage(pixelRatio: 3.0);
    if (data == null) return;

    final ByteData? byteData =
        await data.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) return;

    final Uint8List imageBytes = byteData.buffer.asUint8List();
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/signature.png';
    final File file = File(filePath);
    await file.writeAsBytes(imageBytes);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Signature saved at: $filePath')),
    );
  }

  /// Clear the signature pad
  void _clearSignature() {
    _signaturePadKey.currentState?.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signature Pad')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SfSignaturePad(
                key: _signaturePadKey,
                backgroundColor: Colors.white,
                strokeColor: Colors.black,
                minimumStrokeWidth: 2.0,
                maximumStrokeWidth: 5.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _clearSignature,
                  child: const Text('Clear'),
                ),
                ElevatedButton(
                  onPressed: _saveSignature,
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
