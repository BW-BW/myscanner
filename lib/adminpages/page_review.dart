import 'package:flutter/material.dart';
import 'package:myscanner/adminpages/page_review_details.dart';
import 'package:myscanner/main.dart';
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
          imgurl: row['image_url'] as String,
          ingredients: row['ingredients'] as String,
          price: row['price_RM'] as String);
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Review Database",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                fontSize: 18,
                color: Color(0xff3a57e8),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MyLogin()),
                    (Route<dynamic> route) => false);
              },
              child: Icon(
                Icons.logout,
                color: Color(0xff3a57e8),
                size: 24,
              ),
            ),
          ],
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
              itemCount: productList.length,
              itemBuilder: (BuildContext context, int index) {
                final productData = productList[index];
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
                          child: Image(
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
                                    productData.details,
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    '${productData.netto} gram',
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 11,
                                      color: Color(0xff7a7a7a),
                                    ),
                                  ),
                                ),
                                if (productData.vegan)
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                    child: Text(
                                      'Vegan',
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 11,
                                        color: Color(0xff7a7a7a),
                                      ),
                                    ),
                                  ),
                                if (productData.halal)
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                    child: Text(
                                      'Halal',
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 11,
                                        color: Color(0xff7a7a7a),
                                      ),
                                    ),
                                  ),
                                if (productData.glutenfree)
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                    child: Text(
                                      'Gluten Free',
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 11,
                                        color: Color(0xff7a7a7a),
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
