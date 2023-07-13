import 'package:flutter/material.dart';
import 'package:myscanner/dataclass/comment_data.dart';
import 'package:myscanner/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables

class PageComment extends StatefulWidget {
  const PageComment({super.key});

  @override
  PageCommentState createState() => PageCommentState();
}

List<CommentData> commentList = [];
int fullStars = 0;
bool hasHalfStar = false;
int remainder = 0;

class PageCommentState extends State<PageComment> {
  @override
  void initState() {
    super.initState();
    getComment();
  }

  void getComment() async {
    final commentResponse =
        await Supabase.instance.client.from('commentTable').select();

    final rows = commentResponse as List<dynamic>;

    commentList = rows.map((row) {
      return CommentData(
          barcode: row['barcode'] as int,
          createdby: row['created_by'] as String,
          content: row['comment'] as String,
          foodname: row['food_name'] as String,
          star: row['star'] as String);
    }).toList();

    setState(() {});
  }

  void deleteComment(String comment, String createdby) async {
    await Supabase.instance.client
        .from('commentTable')
        .delete()
        .eq('comment', comment)
        .eq('created_by', createdby);
    getComment();
    setState(() {});
  }

  void getStar(int star) {
    fullStars = star.floor(); //fullstar is the current star rounded down
    hasHalfStar = star - fullStars >= 0.5;
    remainder = (5 - star).round();
  }

  void popupConfirm(BuildContext context, String comment, String createdby) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Approve Confirmation'),
          content: Text('Are you sure you want to delete this rating?'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () {
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
                child: Text('Cancel'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () {
                  deleteComment(comment, createdby);
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
                child: Text('Yes'),
              ),
            ),
          ],
        );
      },
    );
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
              "Rating Database",
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
              itemCount: commentList.length,
              itemBuilder: (BuildContext context, int index) {
                final commentData = commentList[index];
                getStar(int.parse(commentData.star));
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                  color: Color(0xffffffff),
                  shadowColor: Color(0xff3a57e8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    commentData.foodname,
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16,
                                      color: Color(0xff3a57e8),
                                    ),
                                  ),
                                  Text(
                                    'Created By: ${commentData.createdby}',
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff3a57e8),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        for (int i = 1; i <= fullStars; i++)
                                          Icon(Icons.star,
                                              color: Colors.yellow, size: 30),
                                        if (hasHalfStar)
                                          Icon(Icons.star_half,
                                              color: Colors.yellow, size: 30),
                                        for (int i = 1; i <= remainder; i++)
                                          Icon(Icons.star,
                                              color: Colors.grey, size: 30),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Container(
                                            constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  80,
                                            ),
                                            child: Text(
                                              commentData.content,
                                              textAlign: TextAlign.start,
                                              maxLines: 5,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14,
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
                              InkWell(
                                onTap: () {
                                  popupConfirm(context, commentData.content,
                                      commentData.createdby);
                                },
                                child: Icon(
                                  Icons.close_sharp,
                                  color: Color(0xff3a57e8),
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
