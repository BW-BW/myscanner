import 'package:flutter/material.dart';
import 'package:myscanner/global/global.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../dataclass/comment_data.dart';
import '../dataclass/product_data.dart';

// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables

List<CommentData> commentList = [];
List<String> ingredientList = [];
double currentStar = 0;
int reviewCount = 0;
int fullStars = 0;
bool hasHalfStar = false;
int remainder = 0;

class DetailsScreen extends StatefulWidget {
  final ProductData productData;

  const DetailsScreen({super.key, required this.productData});

  @override
  DetailsScreenState createState() => DetailsScreenState();
}

class DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    ingredientList = splitIngredients();
    getComment();
  }

  void addComment(String comment, String star) async {
    await Supabase.instance.client.from('commentTable').insert({
      'barcode': widget.productData.barcode,
      'created_by': currentNameGlobal,
      'comment': comment,
      'food_name': widget.productData.name,
      'star': star
    });

    getComment();
  }

  void getComment() async {
    final commentResponse = await Supabase.instance.client
        .from('commentTable')
        .select()
        .eq('barcode', widget.productData.barcode);

    final rows = commentResponse as List<dynamic>;

    commentList = rows.map((row) {
      return CommentData(
          barcode: row['barcode'] as int,
          createdby: row['created_by'] as String,
          content: row['comment'] as String,
          foodname: row['food_name'] as String,
          star: row['star'] as String);
    }).toList();

    double sum = 0.0;
    for (final star in commentResponse) {
      final starRating = int.parse(star['star'] as String);
      sum += starRating;
    }

    final average = sum / commentResponse.length;
    final formattedAverage = average.toStringAsFixed(1);

    currentStar = double.parse(formattedAverage);
    reviewCount = commentList.length;

    fullStars = currentStar.floor();
    hasHalfStar = currentStar - fullStars >= 0.5;
    remainder = (5 - currentStar).round();

    setState(() {});
  }

  List<String> splitIngredients() {
    var string = widget.productData.ingredients;
    final splitted = string.split(',');
    return splitted;
  }

  int selectedRating = 0;
  String comment = '';

  void _showPopup2(BuildContext context) {
    setState(() {
      selectedRating = 0;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('What do you think?'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select your rating:',
                      style: TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 1; i <= 5; i++)
                            GestureDetector(
                              onTap: () {
                                setState(
                                  () {
                                    selectedRating = i;
                                  },
                                );
                              },
                              child: Icon(
                                Icons.star,
                                size: 40,
                                color: i <= selectedRating
                                    ? Colors.yellow
                                    : Colors.grey,
                              ),
                            ),
                        ],
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          comment = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your comment',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 5,
                    ),
                    SizedBox(height: 24),
                    Align(
                      alignment: Alignment.center,
                      child: MaterialButton(
                        onPressed: () {
                          addComment(comment, selectedRating.toString());
                          Navigator.of(context).pop();
                        },
                        color: Color(0xff3a57e8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.all(16),
                        textColor: Color(0xffffffff),
                        height: 45,
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text('Submit Rating'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0x00ffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text(
          widget.productData.name,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Color(0xff000000),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Color(0xff212435),
            size: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/userBackround.gif",
                    height: 220.0,
                    width: 220.0,
                  ),
                  Align(
                    alignment: Alignment(0.0, 0.0),
                    child: Container(
                      height: 200,
                      width: 200,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(widget.productData.imgurl,
                          fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (widget.productData.vegan)
                          Container(
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(0),
                            width: 80,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0x1f20ff00),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                  color: Color(0xff3a57e8), width: 1),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Vegan",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Color(0xff3a57e8),
                                ),
                              ),
                            ),
                          ),
                        if (widget.productData.halal)
                          Container(
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(0),
                            width: 80,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0x1f2663c3),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                  color: Color(0xff3a57e8), width: 1),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Halal",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Color(0xff3a57e8),
                                ),
                              ),
                            ),
                          ),
                        if (widget.productData.glutenfree)
                          Container(
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(0),
                            width: 80,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0x1fce9329),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                  color: Color(0xff3a57e8), width: 1),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                                    child: Text(
                                      "Glutten",
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14,
                                        color: Color(0xff3a57e8),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Free",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff3a57e8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            widget.productData.details,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color(0xff3a57e8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff3a57e8)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Ingredients',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff3a57e8),
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: ingredientList.length,
                            itemBuilder: (BuildContext context, int index) {
                              String ingredient = ingredientList[index];
                              return Padding(
                                padding: EdgeInsets.fromLTRB(30, 5, 0, 5),
                                child: Text(
                                  ingredient,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff3a57e8)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Nutritional Information',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff3a57e8),
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 20, 60, 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Net Weight (g)",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                  Text(
                                    widget.productData.netto,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 0, 60, 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Calorie (g)",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                  Text(
                                    widget.productData.calorie,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 0, 60, 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Fat (g)",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                  Text(
                                    widget.productData.fat,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 0, 60, 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Protein (g)",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                  Text(
                                    widget.productData.protein,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 0, 60, 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Carbohydrate (g)",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                  Text(
                                    widget.productData.carbo,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 0, 60, 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Sugar (g)",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                  Text(
                                    widget.productData.sugar,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 0, 60, 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Sodium (mg)",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                  Text(
                                    widget.productData.sodium,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   mainAxisSize: MainAxisSize.max,
                    //   children: [
                    //     Expanded(
                    //       flex: 1,
                    //       child: Align(
                    //         alignment: Alignment.center,
                    //         child: ListView.builder(
                    //           scrollDirection: Axis.vertical,
                    //           padding: EdgeInsets.all(8),
                    //           shrinkWrap: true,
                    //           physics: ClampingScrollPhysics(),
                    //           itemCount: commentList
                    //               .length, // Set the number of items in the list
                    //           itemBuilder: (BuildContext context, int index) {
                    //             final commentData = commentList[
                    //                 index]; // Retrieve the UserData object for the current index
                    //             return Card(
                    //               margin: EdgeInsets.symmetric(
                    //                   vertical: 8, horizontal: 0),
                    //               color: Color(0xffffffff),
                    //               shadowColor: Color(0xff3a57e8),
                    //               elevation: 3,
                    //               shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(12.0),
                    //               ),
                    //               child: Row(
                    //                 mainAxisAlignment: MainAxisAlignment.start,
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 mainAxisSize: MainAxisSize.min,
                    //                 children: [
                    //                   Expanded(
                    //                     flex: 1,
                    //                     child: Padding(
                    //                       padding: EdgeInsets.all(8),
                    //                       child: Column(
                    //                         mainAxisAlignment:
                    //                             MainAxisAlignment.start,
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment.start,
                    //                         mainAxisSize: MainAxisSize.max,
                    //                         children: [
                    //                           Text(
                    //                             commentData.createdby,
                    //                             textAlign: TextAlign.start,
                    //                             maxLines: 1,
                    //                             overflow: TextOverflow.clip,
                    //                             style: TextStyle(
                    //                               fontWeight: FontWeight.w700,
                    //                               fontStyle: FontStyle.normal,
                    //                               fontSize: 16,
                    //                               color: Color(0xff3a57e8),
                    //                             ),
                    //                           ),
                    //                           Padding(
                    //                             padding: EdgeInsets.fromLTRB(
                    //                                 0, 4, 0, 0),
                    //                             child: Text(
                    //                               commentData.content
                    //                                   .toString(),
                    //                               textAlign: TextAlign.start,
                    //                               maxLines: 2,
                    //                               overflow: TextOverflow.clip,
                    //                               style: TextStyle(
                    //                                 fontWeight: FontWeight.w400,
                    //                                 fontStyle: FontStyle.normal,
                    //                                 fontSize: 12,
                    //                                 color: Color(0xff000000),
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             );
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff3a57e8)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Product Rating',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff3a57e8),
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (int i = 1; i <= fullStars; i++)
                                Icon(Icons.star,
                                    color: Colors.yellow, size: 40),
                              if (hasHalfStar)
                                Icon(Icons.star_half,
                                    color: Colors.yellow, size: 40),
                              for (int i = 1; i <= remainder; i++)
                                Icon(Icons.star, color: Colors.grey, size: 40),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(
                              'Total Rating: $currentStar',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text(
                              'Total Review: $reviewCount',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                            child: MaterialButton(
                              onPressed: () {
                                //_showPopup2(context);
                              },
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
                                "View All Rating",
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
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: MaterialButton(
                        onPressed: () {
                          _showPopup2(context);
                        },
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
                          "Add Rating",
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
            ),
          ],
        ),
      ),
    );
  }
}
