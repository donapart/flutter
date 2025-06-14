import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';

import 'services/detection_service.dart';
import 'widgets/edge_menu.dart';

void main() {
  runApp(const EdgeArApp());
}

class EdgeArApp extends StatelessWidget {
  const EdgeArApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DetectionService()),
      ],
      child: MaterialApp(
        title: 'Edge AR App',
        theme: ThemeData.dark(),
        home: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late final AnimationController _leftMenuController;
  late final AnimationController _rightMenuController;

  ARSessionManager? _arSessionManager;
  ARObjectManager? _arObjectManager;
  ARAnchorManager? _arAnchorManager;
  ARLocationManager? _arLocationManager;

  @override
  void initState() {
    super.initState();
    _leftMenuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _rightMenuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _leftMenuController.dispose();
    _rightMenuController.dispose();
    _arSessionManager?.dispose();
    super.dispose();
  }

  void _toggleLeftMenu() {
    if (_leftMenuController.isCompleted) {
      _leftMenuController.reverse();
    } else {
      _leftMenuController.forward();
    }
  }

  void _toggleRightMenu() {
    if (_rightMenuController.isCompleted) {
      _rightMenuController.reverse();
    } else {
      _rightMenuController.forward();
    }
  }

  void _onARViewCreated(
    ARSessionManager arSessionManager,
    ARObjectManager arObjectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager,
  ) {
    _arSessionManager = arSessionManager;
    _arObjectManager = arObjectManager;
    _arAnchorManager = arAnchorManager;
    _arLocationManager = arLocationManager;

    _arSessionManager!.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
    );
    _arObjectManager!.onInitialize();
  }

  @override
  Widget build(BuildContext context) {
    final detection = context.watch<DetectionService>();
    return Scaffold(
      body: Stack(
        children: [
          ARView(
            onARViewCreated: _onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          // Edge menus
          EdgeMenu(
            alignment: Alignment.centerLeft,
            controller: _leftMenuController,
            width: 250,
            child: _buildNavigationMenu(detection),
          ),
          EdgeMenu(
            alignment: Alignment.centerRight,
            controller: _rightMenuController,
            width: 250,
            child: _buildContextMenu(detection),
          ),
          // Top title bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              title: const Text('System: FreY'),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: _toggleLeftMenu,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: _toggleRightMenu,
                ),
              ],
            ),
          ),
          // Bottom info bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                detection.statusMessage,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNavigationMenu(DetectionService detection) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text('Karte'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Einstellungen'),
          onTap: () {},
        ),
        SwitchListTile(
          title: const Text('Objekterkennung'),
          value: detection.objectDetection,
          onChanged: detection.toggleObjectDetection,
        ),
      ],
    );
  }

  Widget _buildContextMenu(DetectionService detection) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          title: const Text('QR-Code-Scan'),
          value: detection.barcodeScanning,
          onChanged: detection.toggleBarcodeScanning,
        ),
        SwitchListTile(
          title: const Text('Text OCR'),
          value: detection.textRecognition,
          onChanged: detection.toggleTextRecognition,
        ),
        SwitchListTile(
          title: const Text('Gesichtserkennung'),
          value: detection.faceDetection,
          onChanged: detection.toggleFaceDetection,
        ),
      ],
    );
  }
}
