import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AREdgeUIApp());
}

class AREdgeUIApp extends StatelessWidget {
  const AREdgeUIApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Edge UI',
      theme: ThemeData.dark(),
      home: const EdgeHomePage(),
    );
  }
}

class EdgeHomePage extends StatefulWidget {
  const EdgeHomePage({Key? key}) : super(key: key);

  @override
  State<EdgeHomePage> createState() => _EdgeHomePageState();
}

class _EdgeHomePageState extends State<EdgeHomePage> {
  late ARSessionManager _arSessionManager;
  late ARObjectManager _arObjectManager;
  bool _showLeft = false;
  bool _showRight = false;
  bool _showTop = false;
  bool _showBottom = false;

  @override
  void dispose() {
    _arSessionManager.dispose();
    _arObjectManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ARView(
            onARViewCreated: _onARViewCreated,
          ),
          _buildEdgePanels(),
        ],
      ),
    );
  }

  void _onARViewCreated(ARSessionManager arSessionManager, ARObjectManager arObjectManager, ARAnchorManager arAnchorManager, ARLocationManager arLocationManager) {
    _arSessionManager = arSessionManager;
    _arObjectManager = arObjectManager;

    _arSessionManager.onInitialize(showFeaturePoints: false, showWorldOrigin: false, handleTaps: false);
    _arObjectManager.onInitialize();
  }

  Widget _buildEdgePanels() {
    return GestureDetector(
      onPanUpdate: (details) {
        const edgeSize = 20.0;
        if (details.localPosition.dx < edgeSize) {
          setState(() => _showLeft = !_showLeft);
        } else if (details.localPosition.dx > MediaQuery.of(context).size.width - edgeSize) {
          setState(() => _showRight = !_showRight);
        } else if (details.localPosition.dy < edgeSize) {
          setState(() => _showTop = !_showTop);
        } else if (details.localPosition.dy > MediaQuery.of(context).size.height - edgeSize) {
          setState(() => _showBottom = !_showBottom);
        }
      },
      child: Stack(
        children: [
          if (_showLeft)
            Align(
              alignment: Alignment.centerLeft,
              child: _buildNavigationMenu(),
            ),
          if (_showRight)
            Align(
              alignment: Alignment.centerRight,
              child: _buildContextMenu(),
            ),
          if (_showBottom)
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildInfoBar(),
            ),
          if (_showTop)
            Align(
              alignment: Alignment.topCenter,
              child: _buildTitleBar(),
            ),
        ],
      ),
    );
  }

  Widget _buildNavigationMenu() {
    return Container(
      width: 200,
      color: Colors.black54,
      child: ListView(
        children: const [
          ListTile(title: Text('Karte')),
          ListTile(title: Text('Einstellungen')),
          ListTile(title: Text('Dashboard')),
        ],
      ),
    );
  }

  Widget _buildContextMenu() {
    return Container(
      width: 200,
      color: Colors.black54,
      child: ListView(
        children: const [
          ListTile(title: Text('Filter')),
          ListTile(title: Text('Ebenen')),
        ],
      ),
    );
  }

  Widget _buildInfoBar() {
    return Container(
      height: 80,
      color: Colors.black54,
      alignment: Alignment.center,
      child: const Text('Information / Status'),
    );
  }

  Widget _buildTitleBar() {
    return AppBar(
      title: const Text('System:FreY'),
      centerTitle: true,
      backgroundColor: Colors.black54,
    );
  }
}
