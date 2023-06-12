import 'package:flutter/material.dart';
import 'package:myscanner/adminpages/page_review_details.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../dataclass/product_data.dart';

// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables

class PageReview extends StatefulWidget {
  const PageReview({super.key});

  @override
  PageReviewState createState() => PageReviewState();
}

List<ProductData> productList = [];

class PageReviewState extends State<PageReview> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final response =
        await Supabase.instance.client.from('reviewTable').select();

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
          imgurl: row['image_url'] as String);
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
            ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(8),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount:
                  productList.length, // Set the number of items in the list
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ReviewScreenAdmin(productData: productData),
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
