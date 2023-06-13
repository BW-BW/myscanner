import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:myscanner/global/global.dart';
import 'package:myscanner/global/loading.dart';
import 'package:myscanner/userpages/page_details.dart';
import 'package:myscanner/userpages/page_not_found.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../dataclass/product_data.dart';

// ignore_for_file: use_build_context_synchronously, unused_field, prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables

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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoadingScreen(),
        ),
      );

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

      final duplicate = await Supabase.instance.client
          .from('historyTable')
          .select()
          .eq('user_id', currentIdGlobal)
          .eq('item_code', data[0]['barcode']);

      if (duplicate.isEmpty) {
        await Supabase.instance.client.from('historyTable').insert(
            {'user_id': currentIdGlobal, 'item_code': data[0]['barcode']});
      }

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
      backgroundColor: Color(0xffebebeb),
      appBar: AppBar(
        elevation: 10,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text(
          "Scan Now",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 18,
            color: Color(0xff000000),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(80.0),
              child: MaterialButton(
                onPressed: scanBarcodeNormal,
                color: Color(0xff3a57e8),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.all(16),
                textColor: Color(0xffffffff),
                height: 45,
                minWidth: MediaQuery.of(context).size.width,
                child: Text(
                  "Scan Barcode",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
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
