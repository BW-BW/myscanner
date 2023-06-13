import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myscanner/dataclass/user_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../dataclass/comment_data.dart';

// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables

class UserSuspend extends StatefulWidget {
  final UserData userData;

  const UserSuspend({super.key, required this.userData});

  @override
  UserSuspendState createState() => UserSuspendState();
}

List<CommentData> commentList = [];

class UserSuspendState extends State<UserSuspend> {
  @override
  void initState() {
    super.initState();
    getComment();
  }

  void suspend() async {
    await Supabase.instance.client
        .from('userCreds')
        .update({
          'suspended': true,
        })
        .eq('full_name', widget.userData.fullname)
        .eq('username', widget.userData.username);
  }

  void getComment() async {
    final commentResponse = await Supabase.instance.client
        .from('commentTable')
        .select()
        .eq('created_by', widget.userData.fullname);

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
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Color(0xff000000),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
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
                        Lottie.network(
                          "https://assets8.lottiefiles.com/packages/lf20_8ydmsved.json",
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                          repeat: true,
                          animate: true,
                        ),
                        Align(
                          alignment: Alignment(0.0, 0.2),
                          child: Container(
                            height: 200,
                            width: 200,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(widget.userData.profileurl,
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    widget.userData.fullname,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 18,
                      color: Color(0xff000000),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 40, 0, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0x273a57e8),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.mail,
                            color: Color(0xff3a57e8),
                            size: 20,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 16),
                            child: Text(
                              widget.userData.username,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0x273a57e8),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.accessibility,
                            color: Color(0xff3a57e8),
                            size: 20,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 16),
                            child: Text(
                              widget.userData.gender,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0x273a57e8),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.calendar_today,
                            color: Color(0xff3a57e8),
                            size: 20,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 16),
                            child: Text(
                              widget.userData.age,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Comments Created',
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
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.center,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.all(8),
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: commentList
                                  .length, // Set the number of items in the list
                              itemBuilder: (BuildContext context, int index) {
                                final commentData = commentList[
                                    index]; // Retrieve the UserData object for the current index
                                return Card(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 0),
                                  color: Color(0xffffffff),
                                  shadowColor: Color(0xff3a57e8),
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 4, 0, 0),
                                                child: Text(
                                                  commentData.content
                                                      .toString(),
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
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: suspend,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                  padding: EdgeInsets.all(0),
                  width: 240,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0x273a57e8),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          "Suspend Account",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Color(0xff3a57e8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                  padding: EdgeInsets.all(0),
                  width: 240,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0x273a57e8),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.logout,
                        color: Color(0xff3a57e8),
                        size: 24,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Text(
                          "Cancel",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Color(0xff3a57e8),
                          ),
                        ),
                      ),
                    ],
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
