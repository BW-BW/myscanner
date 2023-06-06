import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myscanner/userpages/page_add_product.dart';

// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables

class PageNotFound extends StatefulWidget {
  const PageNotFound({super.key});

  @override
  PageNotFoundState createState() => PageNotFoundState();
}

class PageNotFoundState extends State<PageNotFound> {
  void redirect() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddProduct()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.network(
                  "https://assets9.lottiefiles.com/packages/lf20_tmsiddoc.json",
                  height: 200,
                  width: 300,
                  fit: BoxFit.cover,
                  repeat: true,
                  animate: true,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 16),
                  child: Text(
                    "No records found",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      color: Color(0xff3e3e3e),
                    ),
                  ),
                ),
                Text(
                  "There was no record based on the details you Scanned.",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    color: Color(0xff848484),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 16),
                  child: MaterialButton(
                    onPressed: redirect,
                    color: Color(0xff3a57e8),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                    textColor: Color(0xffffffff),
                    height: 45,
                    child: Text(
                      "Be The First To add Data",
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
      ),
    );
  }
}
