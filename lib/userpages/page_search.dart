// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:myscanner/global/loading.dart';
import 'package:myscanner/userpages/page_details.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../dataclass/product_data.dart';

class MyPage1 extends StatefulWidget {
  const MyPage1({super.key});
  @override
  MyPage1State createState() => MyPage1State();
}

List<ProductData> productList = [];

class MyPage1State extends State<MyPage1> {
  @override
  void initState() {
    super.initState();
    searchData('12345'); // Call a method to fetch the data
  }

  void searchData(String search) async {
    final response = await Supabase.instance.client
        .from('detailsTable')
        .select()
        .ilike('name', '%$search%');

    final rows = response as List<dynamic>;

    productList = rows.map((row) {
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
          imgurl: row['image_url'] as String,
          ingredients: row['ingredients'] as String);
    }).toList();

    setState(() {});
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
          "Search Your Item",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 18,
            color: Color(0xff000000),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 16, 10, 20),
              child: TextField(
                obscureText: false,
                textAlign: TextAlign.start,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Color(0xff3a57e8), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Color(0xff3a57e8), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Color(0xff3a57e8), width: 1),
                  ),
                  hintText: "What do you want to search?",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                  filled: true,
                  fillColor: Color(0xffffffff),
                  isDense: false,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  prefixIcon:
                      Icon(Icons.search, color: Color(0xff212435), size: 24),
                ),
                onChanged: (value) {
                  searchData(value);
                },
              ),
            ),
            productList.isEmpty
                ? Image.asset(
                    "assets/noData.png",
                    height: 400.0,
                    width: 400.0,
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(8),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: productList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final productData = productList[index];
                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                        color: Color(0xffffffff),
                        shadowColor: Color(0xff000000),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoadingScreen(),
                              ),
                            );
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        padding:
                                            EdgeInsets.fromLTRB(0, 4, 0, 0),
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
                                        padding:
                                            EdgeInsets.fromLTRB(0, 4, 0, 0),
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
                                        padding:
                                            EdgeInsets.fromLTRB(0, 8, 0, 0),
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
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
