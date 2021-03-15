import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _Slides()
          ),
          _Dots(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Dot(),
              _Dot(),
              _Dot(),
            ],
          )
        ],
         
      ),
    );
  }
}


class _Dot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
    );
  }
}


class _Slides extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        children: [
          _Slide('assets/svgs/slide-1.svg'),
          _Slide('assets/svgs/slide-2.svg'),
          _Slide('assets/svgs/slide-3.svg'),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String svg;
  _Slide(this.svg);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(55.0),
      width: double.infinity,
      height: double.infinity,
      child: SvgPicture.asset(svg),
    );
  }
}