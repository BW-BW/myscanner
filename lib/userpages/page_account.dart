// ignore_for_file: use_build_context_synchronously, unused_field, prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:myscanner/global/global.dart';
import 'package:myscanner/global/loading.dart';
import 'package:myscanner/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class PageProfile extends StatefulWidget {
  const PageProfile({super.key});
  @override
  PageProfileState createState() => PageProfileState();
}

class PageProfileState extends State<PageProfile> {
  final SupabaseClient client = SupabaseClient(supabaseURL, supabaseKey);

  void resetGlobal() {
    currentEmailGlobal = '';
    currentPasswordGlobal = '';
    currentNameGlobal = '';
    currentGenderGlobal = '';
    currentAgeGlobal = '';
    currentUrlGlobal = '';
  }

  void logout() {
    resetGlobal();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MyLogin()),
        (Route<dynamic> route) => false);
  }

  void changeProfile() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoadingScreen(),
      ),
    );

    var pickedFile = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (pickedFile != null) {
      final file = File(pickedFile.files.first.path!);
      await client.storage
          .from("user")
          .upload(pickedFile.files.first.name, file)
          .then((value) {});
      final String publicUrl =
          client.storage.from('user').getPublicUrl(pickedFile.files.first.name);

      await Supabase.instance.client
          .from('userTable')
          .update({'profile_url': publicUrl})
          .eq('username', currentEmailGlobal)
          .eq('password', currentPasswordGlobal);

      currentUrlGlobal = publicUrl;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Congratulations'),
            content: Text('You have successfully update your profile'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      setState(() {});
    }
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
                            child: Image.network(currentUrlGlobal,
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    currentNameGlobal,
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
                              currentEmailGlobal,
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
                              currentGenderGlobal,
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
                              currentAgeGlobal,
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
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: changeProfile,
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
                          "Change Profile",
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
                  logout();
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
                          "Sign Out",
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
