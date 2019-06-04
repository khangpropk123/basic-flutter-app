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


class Config  extends StatefulWidget {
  Config({Key key,}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<Config> {
  File config;
  String mode = "";
@override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

   
  }
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/config.ini');
}
Future getFile() async{
    config = await _localFile;
  }
Future<File> writeConfig(String str) async {
  
  final file = await _localFile;
  return file.writeAsString('$str');
}
Future<String> readDatetime() async {
  try {
    final file = await _localFile;

    // Read the file
    String contents = await file.readAsString();
    
    return contents;
  } catch (e) {
    // If encountering an error, return 0
    return "FA";
  }
}
void configApp(String conf) async{
  await writeConfig(conf);
  Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHome()),
            );
}
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: Builder(
    builder: (BuildContext context) {
      return Text("");
    },
  ),
        title: new Center(
          child: Text("Chọn Tình Trạng"),
        )
        //new ImageIcon(AssetImage('assets/images/setting_icon.png'),size: 50,),
        
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child:  GestureDetector(
                onTap: (){configApp("LOVE");},
                child: Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/heart.png')
                    ),
                    backgroundBlendMode: BlendMode.darken,
                    color: Colors.black.withOpacity(0.1)
                    )
                  ),
                ),
            ),
            Expanded(
              child:  GestureDetector(
                onTap: (){configApp("FA");},
                child: Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/fa.png')
                    ),
                    backgroundBlendMode: BlendMode.darken,
                    color: Colors.black.withOpacity(0.1)
                    )
                  ),
                ),
            ),
            Expanded(
              child:  GestureDetector(
                onTap: (){configApp("BROKEN");},
                child: Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    backgroundBlendMode: BlendMode.darken,
                    image: DecorationImage(
                      image: AssetImage('assets/images/broken_pink.png')
                    ),
                    color: Colors.black.withOpacity(0.1)
                    ),
                  
                  ),
                ),
            )
          ],
        ),
      )
    );
  }
}