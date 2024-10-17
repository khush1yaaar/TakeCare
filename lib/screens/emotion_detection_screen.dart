import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class EmotionDetectionScreen extends StatefulWidget {
  const EmotionDetectionScreen({super.key});

  @override
  State<EmotionDetectionScreen> createState() => _EmotionDetectionScreenState();
}

class _EmotionDetectionScreenState extends State<EmotionDetectionScreen> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = 'Detecting...';

  @override
  void initState() {
    super.initState();
    loadCamera();
    loadModel();
  }

  loadCamera() {
    cameraController = CameraController(camera[0], ResolutionPreset.medium);
    cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController!.startImageStream((image) {
          cameraImage = image;
          runModel();
        });
      });
    }).catchError((e) {
      print('Error initializing camera: $e');
    });
  }

  runModel() async {
    if (cameraImage != null) {
      var predictions = await Tflite.runModelOnFrame(
        bytesList: cameraImage!.planes.map((planes) {
          return planes.bytes;
        }).toList(),
        imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );

      predictions!.forEach((element) {
        setState(() {
          output = element['label'];
        });
      });
    }
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "lib/assets/model.tflite",
      labels: "lib/assets/labels.txt",
    );
  }

  @override
  void dispose() {
    cameraController?.dispose();
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emotion Detection"),
      ),
      body: Column(
        children: [
          // Display the camera preview
          cameraController != null && cameraController!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: cameraController!.value.aspectRatio,
                  child: CameraPreview(cameraController!),
                )
              : const Center(child: CircularProgressIndicator()),
          
          const SizedBox(height: 20),

          // Display the output emotion
          Text(
            'Detected Emotion: $output',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          // Button to stop or start the camera
          ElevatedButton(
            onPressed: () {
              if (cameraController != null && cameraController!.value.isStreamingImages) {
                cameraController!.stopImageStream();
              } else {
                loadCamera();
              }
            },
            child: Text(cameraController != null && cameraController!.value.isStreamingImages
                ? 'Stop Camera'
                : 'Start Camera'),
          ),
        ],
      ),
    );
  }
}
