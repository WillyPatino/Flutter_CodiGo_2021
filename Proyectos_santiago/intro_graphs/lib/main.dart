import 'package:flutter/material.dart';
import 'package:intro_graphs/graphs.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  Function goToTab;

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "SCHOOL",
        styleTitle: TextStyle(
          color: Color(0xff3da4ab),
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoMono',
        ),
        description:
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.",
        styleDescription:
        TextStyle(color: Color(0xfffe9c8f), fontSize: 20.0, fontStyle: FontStyle.italic, fontFamily: 'Raleway'),
        pathImage: "images/photo_school.png",
      ),
    );
    slides.add(
      new Slide(
        title: "MUSEUM",
        styleTitle:
        TextStyle(color: Color(0xff3da4ab), fontSize: 30.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
        description: "Ye indulgence unreserved connection alteration appearance",
        styleDescription:
        TextStyle(color: Color(0xfffe9c8f), fontSize: 20.0, fontStyle: FontStyle.italic, fontFamily: 'Raleway'),
        pathImage: "images/photo_museum.png",
      ),
    );
    slides.add(
      new Slide(
        title: "COFFEE SHOP",
        styleTitle:
        TextStyle(color: Color(0xff3da4ab), fontSize: 30.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
        description:
        "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        styleDescription:
        TextStyle(color: Color(0xfffe9c8f), fontSize: 20.0, fontStyle: FontStyle.italic, fontFamily: 'Raleway'),
        pathImage: "images/photo_coffee_shop.png",
      ),
    );
  }

  void onDonePress() {
    Navigator.push(context, MaterialPageRoute(builder: (c)=>Graficos()));
    this.goToTab(0);
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0xffffcc5c),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Color(0xffffcc5c),
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(0xffffcc5c),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                    currentSlide.pathImage,
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.contain,
                  )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: Color(0x33ffcc5c),
      highlightColorSkipBtn: Color(0xffffcc5c),

      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Color(0x33ffcc5c),
      highlightColorDoneBtn: Color(0xffffcc5c),

      // Dot indicator
      colorDot: Color(0xffffcc5c),
      sizeDot: 13.0,


      // Tabs
      listCustomTabs: this.renderListCustomTabs(),
      backgroundColorAllSlides: Colors.white,
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },

      // Behavior
      scrollPhysics: BouncingScrollPhysics(),

      // Show or hide status bar
      hideStatusBar: false,

      // On tab change completed
      onTabChangeCompleted: this.onTabChangeCompleted,
    );
  }
}