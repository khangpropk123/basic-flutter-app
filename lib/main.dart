import 'package:flutter/material.dart';
import 'dart:async';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'Home.dart';
import 'package:intro_slider/intro_slider.dart';
import 'Config.dart';
File config;
bool isConfig ;
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}
Future<bool> _checkFile() async{
  
  String str = await readData();
  
  if(str==null)
    return false;
  if (str.length!=0)
    return true;
  return false;
}
Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/config.ini');
}
Future getFile() async{
    config = await _localFile;
  }
Future<String> readData() async {
  try {
    final file = await _localFile;

    // Read the file
    String contents = await file.readAsString();
    return contents;
  } catch (e) {
    // If encountering an error, return 0
    return null;
  }
}
void main() async{ 
isConfig = await _checkFile();
 print(isConfig);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BreakUp Day',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: isConfig == false? MyHomePage(title: 'BreakUp Day'): MyHome(),
      routes: <String, WidgetBuilder> {
    '/config': (BuildContext context) => new Config(),
    
  },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Slide> slides = new List();
@override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    slideIntro();
   
  }
  void routeScreen(){
    if(isConfig==false)
    Navigator.pushReplacementNamed(context, '/config');
    else
    Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHome()),
            );
  }
  void slideIntro(){
    slides.add(
      new Slide(
        title:
            "VÀI DÒNG ĐÔI LỜI ...",
        maxLineTitle: 2,
        styleTitle:
            TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
        description:
        "Thật ra là vào một chiều mưa ở sài gòn, vô tình nghe được bài hát buồn trên radio đã làm cho những ký ức vốn không nên tồn tại kia lại ùa về. Mà thôi, mình kể sau vậy ahihi ^.^!",
        styleDescription:
            TextStyle(color: Colors.white, fontSize: 20.0, fontStyle: FontStyle.italic, fontFamily: 'Raleway'),
        marginDescription: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
        centerWidget: Text("", style: TextStyle(color: Colors.white)),
        colorBegin: Color(0xffFFDAB9),
        colorEnd: Color(0xff40E0D0),
        backgroundImage: 'assets/images/rain.jpg',
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
        onCenterItemPress: () {},
      ),
    );
    slides.add(
      new Slide(
        title: "ĐANG YÊU",
        styleTitle:
            TextStyle(color: Color(0xffD02090), fontSize: 30.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
        description: "Cái này dành cho mấy bạn đang yêu nhau nè! Gato ghê vậy đó",
        styleDescription:
            TextStyle(color: Color(0xffD02090), fontSize: 20.0, fontStyle: FontStyle.italic, fontFamily: 'Raleway'),
        pathImage: "assets/images/heart.png",
        colorBegin: Color(0xffFFFACD),
        colorEnd: Color(0xffFF6347),
        directionColorBegin: Alignment.topRight,
        directionColorEnd: Alignment.bottomLeft,
      ),
    );
    slides.add(
      new Slide(
        title: "FA NÈ",
        styleTitle:
            TextStyle(color: Colors.grey, fontSize: 30.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
        description:
            "Cái này thì dành cho mấy đứa FA. Lêu lêu . À mà quên, mình cũng FA T.T",
        styleDescription:
            TextStyle(color: Colors.grey, fontSize: 20.0, fontStyle: FontStyle.italic, fontFamily: 'Raleway'),
        pathImage: "assets/images/fa.png",
        colorBegin: Color(0xffFFA500),
        colorEnd: Color(0xff7FFFD4),
        directionColorBegin: Alignment.topCenter,
        directionColorEnd: Alignment.bottomCenter,
        maxLineTextDescription: 3,
      
      ),
    );
    slides.add(
      new Slide(
        title: "THẤT TÌNH",
        styleTitle:
            TextStyle(color: Colors.black54, fontSize: 30.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
        description:
            "Cái này thì dành cho mấy đứa chia tay rồi. À mình nói ít lại thôi kẻo ăn đấm T.T",
        styleDescription:
            TextStyle(color: Colors.black54, fontSize: 20.0, fontStyle: FontStyle.italic, fontFamily: 'Raleway'),
        pathImage: "assets/images/broken_pink.png",
        colorBegin: Color(0xFFFF9999),
        colorEnd: Color(0xFF262626),
        directionColorBegin: Alignment.topCenter,
        directionColorEnd: Alignment.bottomCenter,
        maxLineTextDescription: 3,
      ),
    );
  }
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: (){routeScreen();},
    );
  }
 }

