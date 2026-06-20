import 'package:flutter/material.dart';
import 'curved_loading_bar.dart';

/// Demo screen to showcase the CurvedLoadingBar widget
class LoadingBarDemoScreen extends StatelessWidget {
  const LoadingBarDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Curved Loading Bar Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Simple loading bar with default settings
            const Text(
              'Default Curved Loading Bar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const CurvedLoadingBar(),
            
            // Custom colored loading bar
            const SizedBox(height: 24),
            const Text(
              'Blue Loading Bar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const CurvedLoadingBar(
              color: Colors.blue,
              height: 24,
            ),
            
            // Simple version
            const SizedBox(height: 24),
            const Text(
              'Simple Curve Loading Bar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const CurvedLoadingBarSimple(
              color: Colors.purple,
              height: 30,
            ),
            
            // Static progress (not loading)
            const SizedBox(height: 24),
            const Text(
              'Static Progress (50%)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            CurvedLoadingBar(
              isLoading: false,
              progress: 0.5,
              color: Colors.orange,
              height: 20,
            ),
            
            // Custom sized loading bar
            const SizedBox(height: 24),
            const Text(
              'Tall Loading Bar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const CurvedLoadingBar(
              height: 50,
              color: Colors.teal,
              animationDuration: Duration(seconds: 2),
            ),
          ],
        ),
      ),
    );
  }
}

/// A simple loading indicator widget that uses the curved loading bar
class CurvedLoadingIndicator extends StatelessWidget {
  final String? message;
  final Color color;
  final double size;

  const CurvedLoadingIndicator({
    super.key,
    this.message,
    this.color = Colors.green,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
            child: CurvedLoadingBar(
              color: color,
              height: 8,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ],
      ),
    );
  }
}
