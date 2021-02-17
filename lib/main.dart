import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:text_editor/text_editor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),      
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  final fonts = [
    'OpenSans',
    'Billabong',
    'GrandHotel',
    'Oswald',
    'Quicksand',
    'BeautifulPeople',
    'BeautyMountains',
    'BiteChocolate',
    'BlackberryJam',
    'BunchBlossoms',
    'CinderelaRegular',
    'Countryside',
    'Halimun',
    'LemonJelly',
    'QuiteMagicalRegular',
    'Tomatoes',
    'TropicalAsianDemoRegular',
    'VeganStyle',
  ];
  TextStyle _textStyle = TextStyle(
    fontSize: 32,
    color: Colors.yellow ,
    fontFamily: 'OpenSans',
    shadows: <Shadow>[
      Shadow(
        offset: Offset(2.0, 2.0),
        blurRadius: 3.0,
        color: Colors.black87,
      ),
      Shadow(
        offset: Offset(2.0, 2.0),
        blurRadius: 8.0,
        color: Colors.black87,
      ),
    ],
    decoration: TextDecoration.none,
  );
  String _text = 'Clique para editar';
  TextAlign _textAlign = TextAlign.center;

  TextStyle _textStyle2 = TextStyle(
    fontSize: 32,
    color: Colors.yellow,
    fontFamily: 'OpenSans',
    shadows: <Shadow>[
      Shadow(
        offset: Offset(2.0, 2.0),
        blurRadius: 3.0,
        color: Colors.black87,
      ),
      Shadow(
        offset: Offset(2.0, 2.0),
        blurRadius: 8.0,
        color: Colors.black87,
      ),
    ],
    decoration: TextDecoration.none,
  );
  String _text2 = 'Clique para editar';
  TextAlign _textAlign2 = TextAlign.center;

  double _x;
  double _y;

  double _x2;
  double _y2;

  bool init = true;
  
  File _image;
  File _imageFile;
  ImageProvider _imageProvider;
  List<String> imagePaths = [];
  final picker = ImagePicker();


  void _tapHandler(text, textStyle, textAlign, selected) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(
        milliseconds: 100,
      ), // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return Container(
          color: Colors.black.withOpacity(0.4),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              // top: false,
              child: Container(
                child: TextEditor(
                  fonts: fonts,
                  text: text,
                  textStyle: textStyle,
                  textAlingment: textAlign,
                  decoration: EditorDecoration(
                    doneButton: Padding(
                      padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.close, color: Colors.white, size: 28, ),
                      ),
                    //fontFamily: Icon(Icons.title, color: Colors.white),
                    //colorPalette: Icon(Icons.palette, color: Colors.white),
                    // alignment: AlignmentDecoration(
                    //   left: Text(
                    //     'left',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    //   center: Text(
                    //     'center',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    //   right: Text(
                    //     'right',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    // ),
                  ),
                  onEditCompleted: (style, align, text) {
                    setState(() {
                      if(selected=='header'){
                        _text = text;
                        _textStyle = style;
                        _textAlign = align;
                      } else {
                        _text2 = text;
                        _textStyle2 = style;
                        _textAlign2 = align;
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );    

  }

  @override
  Widget build(BuildContext context) {
    //final appBarHeight = AppBar().preferredSize.height;
    final topPadding = MediaQuery.of(context).padding.top;
    final width = MediaQuery.of(context).size.width;
    
    Size _textSize(String text, TextStyle style) {
      final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
      return textPainter.size;
    }

    final Size textSize1 = _textSize(_text, _textStyle);
    if(init){
      setState(() {
        _x=(width/2)-(textSize1.width/2);
        _y2=60;
        _x2=(width/2)-(textSize1.width/2);
        _y2=340;
        init=false;
      });      
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 400,
              child: Stack(          
                children: [
                  //Center(child: Image.asset('assets/story.png', height: 400, width:MediaQuery.of(context).size.width , fit: BoxFit.cover,)),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 400.0,
                    child: ClipRect(
                      child: _imageProvider!=null ?PhotoView(
                        backgroundDecoration: BoxDecoration(
                          color: Colors.white,                      
                        ),
                        imageProvider: _imageProvider, //AssetImage('assets/story.png'),//_imageProvider,
                        enableRotation: true,
                        loadingBuilder: (context, event) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ): Container(),
                    ),
                  ),
                  Positioned(
                    top: _y,
                    left: _x,
                    child: GestureDetector(
                      onTap: () => _tapHandler(_text, _textStyle, _textAlign, 'header'),
                      child: Draggable(
                        onDragEnd: (dragDetails) {
                          setState(() {
                            _x = dragDetails.offset.dx;
                            _y = dragDetails.offset.dy-topPadding; //- appBarHeight-topPadding;// - appBarHeight - statusBarHeight;
                          });
                        },
                        childWhenDragging: Container(),
                        feedback: Text(_text, style: _textStyle, textAlign: _textAlign, ),
                        child: Text( _text, style: _textStyle, textAlign: _textAlign, ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: _y2,
                    left: _x2,
                    child: GestureDetector(
                      onTap: () => _tapHandler(_text2, _textStyle2, _textAlign2, 'footer'),
                      child: Draggable(
                        onDragEnd: (dragDetails) {
                          setState(() {
                            _x2 = dragDetails.offset.dx;
                            _y2 = dragDetails.offset.dy-topPadding; //- appBarHeight-topPadding;// - appBarHeight - statusBarHeight;
                          });
                        },
                        childWhenDragging: Container(),
                        feedback: Text(_text2, style: _textStyle2, textAlign: _textAlign2, ),
                        child: Text( _text2, style: _textStyle2, textAlign: _textAlign2, ),                    
                      ),
                    ),
                  ),
                  
                ]
              ),
            ),
            FlatButton(
                onPressed: () {
                  getImage();
                },
                child: Text('Galeria'),
              )
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    print(pickedFile.path);
    if(pickedFile!= null){
      _image = File(pickedFile.path);
      _imageProvider = FileImage( _image);
    }

    setState(() {
      if (pickedFile != null) {
        print(pickedFile.path);
        _imageFile=null;
        imagePaths.clear();
        _image = File(pickedFile.path);
      }
    });
    new Directory('storage/emulated/0/' + 'MemeDaHora')
        .create(recursive: true);
  }
  
  
}
