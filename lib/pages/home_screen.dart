import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'nev_bar.dart';
import 'scan_history.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isUrl(String? text) {
    if (text == null) return false;
    final uri = Uri.tryParse(text);
    // Accepts URLs with or without scheme, but must have a dot and no spaces
    return (uri != null && (uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https')))
      || (RegExp(r'^[\w\-]+(\.[\w\-]+)+.*').hasMatch(text) && !text.contains(' '));
  }

  Future<void> _openUrl(String url) async {
  String launchUrlString = url;
  final uri = Uri.tryParse(url);
  if (uri == null) return;

  if (!(uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https'))) {
    launchUrlString = 'https://$url';
  }

  final launchUri = Uri.parse(launchUrlString);

  try {
    // Launch directly. It returns false if it fails.
    bool launched = await launchUrl(
      launchUri, 
      mode: LaunchMode.externalApplication,
    );
    
    if (!launched && mounted) {
      _showErrorSnackBar(launchUrlString);
    }
  } catch (e) {
    if (mounted) _showErrorSnackBar(launchUrlString);
  }
}

void _showErrorSnackBar(String url) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Could not open link: $url')),
  );
}
  // Removed unused _currentIndex
  String? _qrResult;

  // Removed unused _onTap

  void _onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
      setState(() {
        _qrResult = barcodes.first.rawValue;
        // Add to scan history
        ScanHistory().add(_qrResult!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // 1. The Full Screen Scanner
            Positioned.fill(
              child: MobileScanner(
                onDetect: _onDetect,
                fit: BoxFit.cover,
              ),
            ),

            // 2. The Result Overlay (only shows if a code is scanned)
            if (_qrResult != null)
              Positioned(
                left: 0,
                right: 0,
                bottom: 120,
                child: GestureDetector(
                  onTap: _isUrl(_qrResult) ? () => _openUrl(_qrResult!) : null,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _isUrl(_qrResult) ? Colors.blue.shade700 : Colors.black87,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'QR Code Detected:',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _qrResult!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            decoration: _isUrl(_qrResult) ? TextDecoration.underline : TextDecoration.none,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (_isUrl(_qrResult))
                          const Padding(
                            padding: EdgeInsets.only(top: 6.0),
                            child: Text(
                              'Tap to open link',
                              style: TextStyle(color: Colors.white70, fontSize: 11),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),      
    );
  }
}