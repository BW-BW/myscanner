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
          foodname: row['food_name'] as String);
    }).toList();

    setState(() {});
  }

  void deleteComment(String comment) async {
    await Supabase.instance.client
        .from('commentTable')
        .delete()
        .eq('comment', '$comment');
    getComment();
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
                "Comment Database",
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
            child: Column(children: [
          ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(8),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount:
                commentList.length, // Set the number of items in the list
            itemBuilder: (BuildContext context, int index) {
              final commentData = commentList[
                  index]; // Retrieve the UserData object for the current index
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
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  child: Text(
                                    'Created by: ${commentData.createdby}',
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  child: Text(
                                    commentData.content.toString(),
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                // Navigator.of(context).pushAndRemoveUntil(
                                //     MaterialPageRoute(
                                //         builder: (context) => const MyLogin()),
                                //     (Route<dynamic> route) => false);
                                deleteComment(commentData.content);
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
        ])));
  }
}
