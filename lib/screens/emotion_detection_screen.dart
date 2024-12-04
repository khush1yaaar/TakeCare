import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:takecare/main.dart';

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
    //loadModel();
  }

  loadCamera() {
    cameraController = CameraController(camera![1], ResolutionPreset.medium);
    cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController!.startImageStream((image) {
          cameraImage = image;
          //runModel();
        });
      });
    }).catchError((e) {
      print('Error initializing camera: $e');
    });
  }

  // runModel() async {
  //   if (cameraImage != null) {
  //     var predictions = await Tflite.runModelOnFrame(
  //       bytesList: cameraImage!.planes.map((planes) {
  //         return planes.bytes;
  //       }).toList(),
  //       imageHeight: cameraImage!.height,
  //       imageWidth: cameraImage!.width,
  //       imageMean: 127.5,
  //       imageStd: 127.5,
  //       rotation: 90,
  //       numResults: 2,
  //       threshold: 0.1,
  //       asynch: true,
  //     );

  //     for (var element in predictions!) {
  //       setState(() {
  //         output = element['label'];
  //       });
  //     }
  //   }
  // }

  // loadModel() async {
  //   await Tflite.loadModel(
  //     model: "ml_model/model.tflite", // Ensure the path is correct
  //     labels: "ml_model/labels.txt",
  //   );
  // }

  @override
  void dispose() {
    cameraController?.dispose();
    //Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Make the camera preview cover the full screen
          cameraController != null && cameraController!.value.isInitialized
              ? SizedBox.expand(
                  child: CameraPreview(cameraController!),
                )
              : const Center(child: CircularProgressIndicator()),

          // Display the output emotion as an overlay
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Detected Emotion: $output',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Button to start/stop camera stream
          Positioned(
            top: 20,
            left: 20,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Theme.of(context).scaffoldBackgroundColor),
              ),
              onPressed: () {
                if (cameraController != null &&
                    cameraController!.value.isStreamingImages) {
                  cameraController!.stopImageStream();
                } else {
                  loadCamera();
                }
              },
              child: Text(cameraController != null &&
                      cameraController!.value.isStreamingImages
                  ? 'Stop Camera'
                  : 'Start Camera',
                  style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
                ),
            ),
          ),
        ],
      ),
    );
  }
}
