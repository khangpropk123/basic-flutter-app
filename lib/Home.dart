import 'package:flutter/material.dart';
import 'dart:async';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'main.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class MyHome extends StatefulWidget {
 MyHome({Key key, this.config}) : super(key: key);

  final String config;
  @override
  _MyLanding createState() => _MyLanding();
  }
 class  _MyLanding extends State<MyHome> {
  String _counter = '0';
  String mode = "";
  File img_bg;
  File avartar1,avartar2;
  int day=0;
  int hh=0;
  int mm=0;
  int seconds=0;
  DateTime date;
  String data;
  //DateTime time = new DateTime(2018,5,5,0,0,0) ;
  Timer _timer;
@override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    _getConfig();
    _getAvatar();
   _incrementCounter();
   
  }
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      img_bg = image;
    });
  }
  Future setAvatar1() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    
    setState(() {
      avartar1 = image;
    });
    _saveAvatar1(image.path);
  }
  Future setAvatar2() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      avartar2 = image;
    });
    _saveAvatar2(image.path);
  }
  Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/brokenup_date.txt');
}
Future<File> get _localConfig async {
  final path = await _localPath;
  return File('$path/config.ini');
}
Future<File> _localImages(String fname) async {
  final path = await _localPath;
  return File('$path/$fname');
}
  void _incrementCounter() async {
      date = await readDatetime();
      
      const sec = Duration(seconds: 1);
      _timer = new Timer.periodic(
      sec,
      (Timer timer) => setState(() {
            Duration times = DateTime.now().difference(date);
            seconds = times.inSeconds;
             day = (seconds/(24*3600)).floor();
              seconds = seconds - day*24*3600;
             hh = (seconds/3600).floor();
              seconds = (seconds - hh*3600).floor();
             mm = (seconds/60).floor();
                seconds = (seconds-mm*60);           
          }));
    
  }
// File

Future<File> writeDatetime(DateTime datetime) async {
  int date = datetime.millisecondsSinceEpoch;
  final file = await _localFile;
  return file.writeAsString('$date');
}
Future<File> writeImagePath(String imageConfig, String fname) async {
  
  final file = await _localImages(imageConfig) ;
  return file.writeAsString('$fname');
}
Future<DateTime> readDatetime() async {
  try {
    final file = await _localFile;

    // Read the file
    String contents = await file.readAsString();
    int date = int.parse(contents);
    DateTime Brokenup_date = DateTime.fromMillisecondsSinceEpoch(date);
    print(Brokenup_date);
    return Brokenup_date;
  } catch (e) {
    // If encountering an error, return 0
    return DateTime.now();
  }
}
Future<String> readImagesPath(String fname) async {
  try {
    final file = await _localImages(fname);

    // Read the file
    String contents = await file.readAsString();
    print(contents);
    return contents;
    
  } catch (e) {
    // If encountering an error, return 0
    return null;
  }
}
Future<String> readConfig() async {
  try {
    final file = await _localConfig;

    // Read the file
    String contents = await file.readAsString();
    return contents;
  } catch (e) {
    // If encountering an error, return 0
    return "FA";
  }
}
_saveAvatar1(String avatar) async{
 await writeImagePath("avatar1.ini", avatar);
}
_saveAvatar2(String avatar) async{
 await writeImagePath("avatar2.ini", avatar);
}
_getAvatar() async{
  try{
  avartar1 =  File( await readImagesPath("avatar1.ini"));
  avartar2 = File(await readImagesPath("avatar2.ini"));
  setState(() {});
  }
catch(e){}
}
_getData() async{
  date = await readDatetime();
}
_getConfig() async{
  mode = await readConfig();
  data =setText(mode);
  setState(() {
  });
}
String setText(String modes){
 switch (modes) {
   case "FA":
    return "Ế";
     break;
  case "LOVE":
    return "hai bạn Yêu Nhau";
    break;
  case "BROKEN":
    return "bạn Chia Tay";
    break;
   default:
   return "FA";
 }
}
_resetConfig() async{
  
  final path = await _localPath;
  print(path);
  File f = await File('$path/config.ini');
  await f.writeAsStringSync("");
  exit(0);

}
_arlertReset(){
  Alert(
      context: context,
      type: AlertType.warning,
      title: "Reset!!!",
      desc: "Nếu reset, bạn phải mở lại app để thực hiện thay đổi! ^^",
      buttons: [
        DialogButton(
          child: Text(
            "Thôi Khỏi ",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "Ok Reset",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => _resetConfig(),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
}
  Widget float1() {
    return Container(
      child: FloatingActionButton(
        heroTag: 3,
        onPressed: (){
          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1990,1,1),
                              maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                             setState(() {
                               writeDatetime(date);
                              _getData();
                             });;
                          }, currentTime: DateTime.now(), locale: LocaleType.en);
         
          },
        tooltip: 'First button',
        child: Icon(Icons.date_range),
      ),
    );
}
Widget float2() {
    return Container(
      child: FloatingActionButton(
        heroTag: 2,
        onPressed: ()=>{getImage()},
        tooltip: 'Second button',
        child: Icon(Icons.image),
      ),
    );
}
Widget float3() {
    return Container(
      child: FloatingActionButton(
        heroTag: 1,
        onPressed: (){_arlertReset();
        },
        tooltip: 'Second button',
        child: Icon(Icons.restore),
      ),
    );
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      
        title: Center( child: mode != "LOVE" ? ImageIcon(AssetImage('assets/images/broken_icon.png'),size: 50,):new ImageIcon(AssetImage('assets/images/heart.png'),size: 50,)),
        
        
      ),
      body: Center(
        
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: img_bg != null ? new FileImage(img_bg) : new AssetImage('assets/images/img_bg.png'),
                 fit: BoxFit.cover)
              ),
          child:  Column(
             
              children: <Widget>[
              
              
              Expanded(
                flex:2 ,
                child: Container(
                    child: mode !="FA" ? 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                     
                     GestureDetector(
                          child: Container(
                             margin: EdgeInsets.only(right: 50),
                             width: 100,
                             height: 100,
                             child: CircleAvatar(
                             backgroundImage:avartar1 == null ? AssetImage('assets/images/avar1.jpg'):FileImage(avartar1),
                             backgroundColor: Colors.transparent,
                             radius: 100,
                    ),
                     ),
                      onTap: ()=>setAvatar1(),
                      ),
                    Container (
                        child: mode!="LOVE" ? new ImageIcon(AssetImage('assets/images/broken_icon.png')):new ImageIcon(AssetImage('assets/images/heart.png')),

                    ),
                    
                    GestureDetector(
                     child: Container(
                         margin: EdgeInsets.only(left: 50),
                         width: 100,
                         height: 100,
                         child: CircleAvatar(
                                backgroundImage: avartar2 == null ? AssetImage('assets/images/avar2.jpg') : FileImage(avartar2),
                                backgroundColor: Colors.transparent,
                                radius: 100,
                    ), ),
                      onTap: ()=>setAvatar2(),
                     )
                   
                      ],
                    )
                    :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                          child: Container(
                             width: 100,
                             height: 100,
                             child: CircleAvatar(
                             backgroundImage:avartar1 == null ? AssetImage('assets/images/avar1.jpg'):FileImage(avartar1),
                             backgroundColor: Colors.transparent,
                             radius: 100,
                    ),
                     ),
                      onTap: ()=>setAvatar1(),
                      ),
                    ],
                  ) 
                ),
              ),
              
              Expanded(
                flex: 4,
                child: Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Column(
                  children: <Widget>[
                    Container(
                    padding: EdgeInsets.only(bottom: 15),
                    child: mode == "FA" ? Text(
                    "Bạn đã Ế ",
                    style: TextStyle(
                      color: Colors.grey,
                    ) ,
                  ) :
                  Text(
                    'Đã',
                    style: TextStyle(
                      color: Colors.grey,
                    ) ,
                  ),
                  ),
                  Text(
                    '$day'+" Ngày",
                    style: Theme.of(context).textTheme.display1,
                  ),
                  Text(
                    '$hh'+" Giờ",
                    style: Theme.of(context).textTheme.display1,
                  ),
                  Text(
                    '$mm'+" Phút",
                    style: Theme.of(context).textTheme.display1,
                  ),
                  Text(
                    '$seconds'+" Giây",
                    style: Theme.of(context).textTheme.display1,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: mode == "FA" ? Text(
                    'Thật là một câu chuyện buồn mà!',
                    style: TextStyle(
                      color: Colors.grey,
                    ) ,
                  ) : 
                  Text(
                    'Kể từ lúc $data!',
                    style: TextStyle(
                      color: Colors.grey,
                    ) ,
                  ),
                  )
                ],),
                )
              ),
              
            ],
            ),
        ),
        
      ),
      floatingActionButton: AnimatedFloatingActionButton(
        //Fab list
        fabButtons: <Widget>[
            float1(), float2(),float3()
        ],
        colorStartAnimation: Colors.blue,
        colorEndAnimation: Colors.red,
        animatedIconData: AnimatedIcons.menu_close //To principal button
    ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  }