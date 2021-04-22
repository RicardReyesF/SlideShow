import 'package:flutter/material.dart';
import 'package:slide_show/src/widgets/slider_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderWidget(
        sliders: <Widget>[
          SvgPicture.asset("assets/svgs/slide-1.svg"),
          SvgPicture.asset("assets/svgs/slide-2.svg"),
          SvgPicture.asset("assets/svgs/slide-3.svg"),
          SvgPicture.asset("assets/svgs/slide-4.svg"),
          SvgPicture.asset("assets/svgs/slide-5.svg"),
          SvgPicture.asset("assets/svgs/slide-5.svg"),
        ]
      ),
    );
  }
}