import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class MyPage1 extends StatefulWidget {
  const MyPage1({super.key});
  @override
  MyPage1State createState() => MyPage1State();
}

class MyPage1State extends State<MyPage1> {
  String _scanBarcode = 'Unknown';

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } catch (e) {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 1')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Page 1'),
            ElevatedButton(
                onPressed: scanQR, child: const Text('Start QR scan')),
            Text('Scan result : $_scanBarcode\n',
                style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
