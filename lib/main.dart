import 'package:flutter/material.dart';
import 'package:myscanner/adminpages/adminmain.dart';
import 'package:myscanner/global/loading.dart';
import 'package:myscanner/register.dart';
import 'package:myscanner/userpages/page_account.dart';
import 'package:myscanner/userpages/usermain.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myscanner/global/global.dart';

// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseURL,
    anonKey: supabaseKey,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        //'/': (context) => MyLogin(),
        '/admin': (context) => const AdminPage(),
        '/user': (context) => const MyHomePage(),
        '/register': (context) => const MyRegister(),
        '/login': (context) => const MyLogin(),
        '/mypage4': (context) => MyPage4(),
      },
      title: 'Login Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyLogin(),
    );
  }
}

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});
  @override
  MyLoginState createState() => MyLoginState();
}

class MyLoginState extends State<MyLogin> {
  String _email = "";
  String _password = "";

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passowordController = TextEditingController();

  void updateAllGlobal(String email, String password, String name,
      String gender, String age, String url, String id) {
    currentEmailGlobal = email;
    currentPasswordGlobal = password;
    currentNameGlobal = name;
    currentGenderGlobal = gender;
    currentAgeGlobal = age;
    currentUrlGlobal = url;
    currentIdGlobal = id;
  }

  void register() async {
    await Supabase.instance.client
        .from('userTable')
        .insert({'username': _email, 'password': _password});
  }

  void login() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoadingScreen(),
      ),
    );

    final data = await Supabase.instance.client
        .from('userTable')
        .select()
        .eq('username', _email)
        .eq('password', _password);

    if (_email == 'a' && _password == 'a') {
      Navigator.of(context).pushNamedAndRemoveUntil("/admin", (route) => false);
    } else if (data.isEmpty) {
      //print('data not found');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Oh No!'),
            content: Text('We cannot find your credentials'),
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
    } else if (data[0]['suspended'] == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Oh No!'),
            content: Text('This account has been suspended!'),
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
    } else {
      print(data);
      updateAllGlobal(
          _email,
          _password,
          data[0]['full_name'],
          data[0]['gender'],
          data[0]['age'].toString(),
          data[0]['profile_url'],
          data[0]['id'].toString());
      // print(currentEmailGlobal);
      // print('asdas');
      // print(currentPasswordGlobal);
      // print(currentNameGlobal);
      // print(currentGenderGlobal);
      // print(currentAgeGlobal);
      // print(currentUrlGlobal);

      // ignore_for_file: use_build_context_synchronously
      Navigator.of(context).pushNamedAndRemoveUntil("/user", (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe6e6e6),
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.35000000000000003,
            decoration: BoxDecoration(
              color: Color(0xff3a57e8),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: Color(0x4d9e9e9e), width: 1),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 100, 20, 60),
            padding: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: Color(0x4d9e9e9e), width: 1),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ///***If you have exported images you must have to copy those images in assets/images directory.
                    Image(
                      image: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoSL4WHG5Ypv4e4W58d5Gt4PnBEM_kZQDDhAKjZAOYLBy6V1karPn2SMil6DFkjUUeX7M&usqp=CAU"),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Login",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 22,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                      child: TextField(
                        controller: _emailController,
                        obscureText: false,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                        decoration: InputDecoration(
                          disabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide:
                                BorderSide(color: Color(0xff000000), width: 1),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide:
                                BorderSide(color: Color(0xff000000), width: 1),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide:
                                BorderSide(color: Color(0xff000000), width: 1),
                          ),
                          hintText: "Enter Email",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff494646),
                          ),
                          filled: true,
                          fillColor: Color(0xffffffff),
                          isDense: false,
                          contentPadding: EdgeInsets.all(0),
                        ),
                        onChanged: (value) {
                          _email = value;
                        },
                      ),
                    ),
                    TextField(
                      controller: _passowordController,
                      obscureText: true,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                      decoration: InputDecoration(
                        disabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              BorderSide(color: Color(0xff000000), width: 1),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              BorderSide(color: Color(0xff000000), width: 1),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              BorderSide(color: Color(0xff000000), width: 1),
                        ),
                        hintText: "Enter Password",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff494646),
                        ),
                        filled: true,
                        fillColor: Color(0xffffffff),
                        isDense: false,
                        contentPadding: EdgeInsets.all(0),
                      ),
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                      child: MaterialButton(
                        onPressed: login,
                        color: Color(0xff3a57e8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        textColor: Color(0xffffffff),
                        height: 40,
                        minWidth: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: Text(
                              "Don't have an account?",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 18,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyRegister()),
                                );
                              },
                              child: Text(
                                "SignUp",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
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
            ),
          ),
        ],
      ),
    );
  }
}
