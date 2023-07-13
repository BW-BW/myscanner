import 'package:flutter/material.dart';
import 'package:myscanner/adminpages/page_user_suspend.dart';
import 'package:myscanner/dataclass/user_data.dart';
import 'package:myscanner/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables

class PageUser extends StatefulWidget {
  const PageUser({super.key});

  @override
  PageUserState createState() => PageUserState();
}

List<UserData> userList = [];

class PageUserState extends State<PageUser> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final response = await Supabase.instance.client
        .from('userTable')
        .select()
        .eq('suspended', false);

    final rows = response as List<dynamic>;

    userList = rows.map((row) {
      return UserData(
          suspended: row['suspended'] as bool,
          fullname: row['full_name'] as String,
          gender: row['gender'] as String,
          age: row['age'] as String,
          profileurl: row['profile_url'] as String,
          username: row['username'] as String,
          password: row['password'] as String);
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
              "User Database",
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
              itemCount: userList.length,
              itemBuilder: (BuildContext context, int index) {
                final userData = userList[index];
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
                          builder: (context) => UserSuspend(userData: userData),
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
                            image: NetworkImage(userData.profileurl),
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
                                  userData.fullname,
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
                                    userData.age,
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
                                    userData.username,
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
                                    userData.gender,
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
