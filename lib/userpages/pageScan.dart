import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:myscanner/userpages/PageFound.dart';
import 'package:myscanner/userpages/pageNotFound.dart';

class MyPage3 extends StatefulWidget {
  const MyPage3({super.key});

  @override
  MyPage3State createState() => MyPage3State();
}

class MyPage3State extends State<MyPage3> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
    scanBarcodeNormal();
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } catch (e) {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });

    if (_scanBarcode == '8690632060743') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PageFound(onPagePopped: scanBarcodeNormal)),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PageNotFound(onPagePopped: scanBarcodeNormal)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Scan'),
            ElevatedButton(
              onPressed: scanBarcodeNormal,
              child: const Text('Start Barcode scan'),
            ),
            Text(
              'Scan result: $_scanBarcode\n',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
