import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PageFound extends StatefulWidget {
  const PageFound({super.key});

  // final VoidCallback onPagePopped;
  // const PageFound({Key? key, required this.onPagePopped}) : super(key: key);

  @override
  PageFoundState createState() => PageFoundState();
}

class PageFoundState extends State<PageFound> {
  // @override
  // void initState() {
  //   super.initState();

  //   SchedulerBinding.instance.addPostFrameCallback((_) {
  //     final modalRoute = ModalRoute.of(context);
  //     if (modalRoute != null) {
  //       modalRoute.addScopedWillPopCallback(() {
  //         widget.onPagePopped();
  //         return Future.value(
  //             true); // Return true to allow the page to be popped
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(title: const Text('Page Found')),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ///***If you have exported images you must have to copy those images in assets/images directory.
            Container(
              height: 120,
              width: 120,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network("https://picsum.photos/250?image=9",
                  fit: BoxFit.cover),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Text(
                "Every 'true' value in the DB shown here",
                textAlign: TextAlign.left,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Text(
                "This is used for the nutritional Facts",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Text(
                "This is used for comments",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
