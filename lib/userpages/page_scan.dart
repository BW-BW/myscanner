import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:myscanner/global/global.dart';
import 'package:myscanner/userpages/page_history.dart';
import 'package:myscanner/userpages/page_history_details.dart';
import 'package:myscanner/userpages/page_not_found.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ignore_for_file: use_build_context_synchronously

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

    //should be returning 1 line only
    final data = await Supabase.instance.client
        .from('detailsTable')
        .select()
        .eq('barcode', _scanBarcode);

    if (data.isEmpty && _scanBarcode == '-1') {
    } else if (data.isEmpty && _scanBarcode != '-1') {
      currentScannedGlobal = _scanBarcode;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PageNotFound()),
      );
    } else {
      ProductData productData = ProductData(
          barcode: data[0]['barcode'],
          name: data[0]['name'],
          vegan: data[0]['vegan'],
          glutenfree: data[0]['gluten_free'],
          halal: data[0]['halal'],
          netto: data[0]['netto'],
          calorie: data[0]['calorie_kcal'],
          fat: data[0]['fat_g'],
          protein: data[0]['protein_g'],
          carbo: data[0]['carbo_g'],
          sodium: data[0]['sodium_mg'],
          sugar: data[0]['sugar_g'],
          details: data[0]['details'],
          imgurl: data[0]['image_url']);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsScreen(productData: productData),
        ),
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
