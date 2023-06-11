import 'package:flutter/material.dart';
import 'package:myscanner/global/global.dart';
import 'package:myscanner/userpages/page_details.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductData {
  final int barcode;
  final String name;
  final bool vegan;
  final bool glutenfree;
  final bool halal;
  final String netto;
  final String calorie;
  final String fat;
  final String protein;
  final String carbo;
  final String sodium;
  final String sugar;
  final String details;
  final String imgurl;

  ProductData(
      {required this.barcode,
      required this.name,
      required this.vegan,
      required this.glutenfree,
      required this.halal,
      required this.netto,
      required this.calorie,
      required this.fat,
      required this.protein,
      required this.carbo,
      required this.sodium,
      required this.sugar,
      required this.details,
      required this.imgurl});
}

List<ProductData> productList = [];

class MyPage2 extends StatefulWidget {
  const MyPage2({super.key});
  @override
  MyPage2State createState() => MyPage2State();
}

class MyPage2State extends State<MyPage2> {
  @override
  void initState() {
    super.initState();
    fetchData(); // Call a method to fetch the data
  }

  void fetchData() async {
    final detailsTable =
        await Supabase.instance.client.from('detailsTable').select();

    final historyTable = await Supabase.instance.client
        .from('historyTable')
        .select()
        .eq('user_id', currentIdGlobal);

    print(detailsTable);
    final rowsDet = detailsTable as List<dynamic>;
    final rowsHist = historyTable as List<dynamic>;

    final joinedData = <Map<String, dynamic>>[];
    for (final rowsHist in rowsHist) {
      final barcodes = rowsHist['item_code'];
      final userId = rowsHist['user_id'];

      final matchingTable = rowsDet.firstWhere(
          (rowsDet) => rowsDet['barcode'] == barcodes,
          orElse: () => null);

      if (matchingTable != null) {
        final nameJoin = matchingTable['name'];
        final veganJoin = matchingTable['vegan'];
        final glutenfreeJoin = matchingTable['gluten_free'];
        final detailsJoin = matchingTable['details'];
        final halalJoin = matchingTable['halal'];
        final calorieJoin = matchingTable['calorie_kcal'];
        final fatJoin = matchingTable['fat_g'];
        final proteinJoin = matchingTable['protein_g'];
        final carboJoin = matchingTable['carbo_g'];
        final sodiumJoin = matchingTable['sodium_mg'];
        final sugarJoin = matchingTable['sugar_g'];
        final imageJoin = matchingTable['image_url'];
        final nettoJoin = matchingTable['netto'];

        joinedData.add({
          'user_id': userId,
          'barcode': barcodes,
          'name': nameJoin,
          'vegan': veganJoin,
          'gluten_free': glutenfreeJoin,
          'details': detailsJoin,
          'halal': halalJoin,
          'calorie_kcal': calorieJoin,
          'fat_g': fatJoin,
          'protein_g': proteinJoin,
          'carbo_g': carboJoin,
          'sodium_mg': sodiumJoin,
          'sugar_g': sugarJoin,
          'image_url': imageJoin,
          'netto': nettoJoin,
        });
      }
    }

    productList = joinedData.map((row) {
      return ProductData(
          barcode: row['barcode'] as int,
          name: row['name'] as String,
          vegan: row['vegan'] as bool,
          glutenfree: row['gluten_free'] as bool,
          halal: row['halal'] as bool,
          netto: row['netto'] as String,
          calorie: row['calorie_kcal'] as String,
          fat: row['fat_g'] as String,
          protein: row['protein_g'] as String,
          carbo: row['carbo_g'] as String,
          sodium: row['sodium_mg'] as String,
          sugar: row['sugar_g'] as String,
          details: row['details'] as String,
          imgurl: row['image_url'] as String);
    }).toList();

    setState(() {}); // Refresh the UI with the fetched data
  }

// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables
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
          "Your Scan History",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 18,
            color: Color(0xff000000),
          ),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(8),
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: productList.length, // Set the number of items in the list
        itemBuilder: (BuildContext context, int index) {
          final productData = productList[
              index]; // Retrieve the UserData object for the current index
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
            color: Color(0xffffffff),
            shadowColor: Color(0xff000000),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: InkWell(
              onTap: () {
                print("HistoryTapped");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailsScreen(productData: productData),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        bottomLeft: Radius.circular(12.0)),
                    child:

                        ///***If you have exported images you must have to copy those images in assets/images directory.
                        Image(
                      image: NetworkImage(productData.imgurl),
                      height: 130,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            productData.name,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color(0xff000000),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                            child: Text(
                              productData.netto,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 12,
                                color: Color(0xff7a7a7a),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                            child: Text(
                              productData.barcode.toString(),
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 18,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: Text(
                              productData.details,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 11,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.more_vert,
                      color: Color(0xff212435),
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
