// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class PageIntro extends StatefulWidget {
  const PageIntro({super.key});
  @override
  PageIntroState createState() => PageIntroState();
}

class PageIntroState extends State<PageIntro> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xffebebeb),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          title: Text(
            'New User Quick Introduction',
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
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                child: Text(
                  'Scroll through these images to see the tutorial',
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Color(0xff3a57e8),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff3a57e8)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ImageSlideshow(
                    height: 700,
                    indicatorColor: Color(0xff3a57e8),
                    onPageChanged: (value) {
                      debugPrint('Page changed: $value');
                    },
                    autoPlayInterval: 10000,
                    isLoop: true,
                    children: [
                      Image.asset(
                        'assets/tutorial/tutorial1.jpg',
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/tutorial/tutorial2.jpg',
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/tutorial/tutorial3.jpg',
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/tutorial/tutorial4.jpg',
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/tutorial/tutorial5.jpg',
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/tutorial/tutorial6.jpg',
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 16, 15, 20),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/user", (route) => false);
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
                    "I'm Ready",
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
    );
  }
}
