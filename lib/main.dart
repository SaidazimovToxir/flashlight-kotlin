import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FlashlightControl(),
    );
  }
}

class FlashlightControl extends StatefulWidget {
  const FlashlightControl({super.key});

  @override
  State<FlashlightControl> createState() => _FlashlightControlState();
}

class _FlashlightControlState extends State<FlashlightControl> {
  static const platform = MethodChannel('com.example.flashlight/flashlight');

  bool isFlashOn = false;

  Future<void> toggleFlashlight() async {
    try {
      final bool result = await platform.invokeMethod('toggleFlashlight');
      setState(() {
        isFlashOn = result;
      });
    } on PlatformException catch (e) {
      print("Failed to toggle flashlight: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashlight Control'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isFlashOn ? Icons.flash_on : Icons.flash_off,
              size: 100,
              color: isFlashOn ? Colors.teal : Colors.grey,
            ),
            const SizedBox(height: 20),
            Text(
              isFlashOn ? "Flashlight is ON" : "Flashlight is OFF",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isFlashOn ? Colors.teal : Colors.grey,
              ),
            ),
            const SizedBox(height: 40),
            Switch(
              value: isFlashOn,
              onChanged: (value) {
                toggleFlashlight();
              },
              activeColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
