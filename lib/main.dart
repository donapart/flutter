import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';

void main() {
  runApp(const EdgeARApp());
}

class EdgeARApp extends StatelessWidget {
  const EdgeARApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edge AR',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ARHomePage(),
    );
  }
}

class ARHomePage extends StatefulWidget {
  const ARHomePage({Key? key}) : super(key: key);

  @override
  State<ARHomePage> createState() => _ARHomePageState();
}

class _ARHomePageState extends State<ARHomePage> {
  late ARSessionManager _arSessionManager;
  late ARObjectManager _arObjectManager;

  bool _showLeftPanel = false;
  bool _showRightPanel = false;
  bool _showTopPanel = false;
  bool _showBottomPanel = false;

  @override
  void dispose() {
    _arSessionManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanStart: _handleEdgePan,
        child: Stack(
          children: [
            ARView(onARViewCreated: _onARViewCreated),
            _buildEdgePanels(),
          ],
        ),
      ),
    );
  }

  void _onARViewCreated(
    ARSessionManager arSessionManager,
    ARObjectManager arObjectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager,
  ) {
    _arSessionManager = arSessionManager;
    _arObjectManager = arObjectManager;
    _arSessionManager.onInitialize();
  }

  void _handleEdgePan(DragStartDetails details) {
    const edgeSize = 20.0;
    final size = MediaQuery.of(context).size;
    if (details.localPosition.dx < edgeSize) {
      setState(() => _showLeftPanel = !_showLeftPanel);
    } else if (details.localPosition.dx > size.width - edgeSize) {
      setState(() => _showRightPanel = !_showRightPanel);
    } else if (details.localPosition.dy < edgeSize) {
      setState(() => _showTopPanel = !_showTopPanel);
    } else if (details.localPosition.dy > size.height - edgeSize) {
      setState(() => _showBottomPanel = !_showBottomPanel);
    }
  }

  Widget _buildEdgePanels() {
    return Stack(
      children: [
        if (_showLeftPanel)
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 200,
            child: Container(
              color: Colors.black54,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Text('Navigation')],
              ),
            ),
          ),
        if (_showRightPanel)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: 200,
            child: Container(
              color: Colors.black54,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Text('Kontext')],
              ),
            ),
          ),
        if (_showTopPanel)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 80,
            child: Container(
              color: Colors.black54,
              alignment: Alignment.center,
              child: const Text('Titel'),
            ),
          ),
        if (_showBottomPanel)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 80,
            child: Container(
              color: Colors.black54,
              alignment: Alignment.center,
              child: const Text('Status'),
            ),
          ),
      ],
    );
  }
}
