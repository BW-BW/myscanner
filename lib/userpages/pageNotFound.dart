import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';

class PageNotFound extends StatefulWidget {
  const PageNotFound({super.key});

  // final VoidCallback onPagePopped;
  // const PageNotFound({Key? key, required this.onPagePopped}) : super(key: key);

  @override
  PageNotFoundState createState() => PageNotFoundState();
}

class PageNotFoundState extends State<PageNotFound> {
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

  ///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/
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
                  "https://assets10.lottiefiles.com/packages/lf20_mxuufmel.json",
                  height: 200,
                  width: 200,
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
                    onPressed: () {},
                    color: Color(0xff3a57e8),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                    child: Text(
                      "Be The First To add Data",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    textColor: Color(0xffffffff),
                    height: 45,
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
