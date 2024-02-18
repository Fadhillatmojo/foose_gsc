import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:foose_gsc/shared/shared.dart';

class ScanPage extends StatefulWidget {
  final List<CameraDescription> cameras; // Tambahkan parameter cameras
  const ScanPage({super.key, required this.cameras});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController? controller;
  String imagePath = "";
  IconData flashIcon = Icons.flash_off;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      controller?.setFlashMode(FlashMode.off);
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller!.value.isInitialized) {
      return Container();
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                'Scan Receipt Here',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 40),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: 300,
                  height: 400,
                  child: AspectRatio(
                    aspectRatio: controller!.value.aspectRatio,
                    child: CameraPreview(controller!),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_photo_alternate,
                      color: AppColors.accentColor,
                    ),
                    iconSize: 40,
                  ),
                  IconButton(
                    onPressed: () async {
                      try {
                        final image = await controller!.takePicture();
                        setState(() {
                          imagePath = image.path;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    icon: const Icon(
                      Icons.circle,
                      color: AppColors.accentColor,
                    ),
                    iconSize: 70,
                  ),
                  IconButton(
                    onPressed: () {
                      // Get the current flash mode
                      FlashMode currentFlashMode = controller!.value.flashMode;
                      // Toggle the flash mode
                      FlashMode newFlashMode = currentFlashMode == FlashMode.off
                          ? FlashMode.always
                          : FlashMode.off;
                      // Set the new flash mode
                      controller!.setFlashMode(newFlashMode);
                      // Update the UI
                      setState(() {
                        flashIcon = newFlashMode == FlashMode.off
                            ? Icons.flash_off
                            : Icons.flash_on;
                      });
                    },
                    icon: Icon(
                      // Use different icons based on the current flash mode
                      flashIcon,
                      color: AppColors.accentColor,
                    ),
                    iconSize: 40,
                  ),
                ],
              ),
              if (imagePath != "")
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.file(
                    File(imagePath),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
