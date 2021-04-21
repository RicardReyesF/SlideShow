import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:slide_show/src/models/slider_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> new SliderModel(),
        child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: _Slides()
            ),
            _Dots(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Dot(0),
                _Dot(1),
                _Dot(2),
              ],
            )
          ],
           
        ),
      ),
    );
  }
}


class _Dot extends StatelessWidget {
  final int index;
  _Dot(this.index);
  @override
  Widget build(BuildContext context) {
   final paginaActual= Provider.of<SliderModel>(context).currentPage;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: ( paginaActual >= index-0.5 && paginaActual< index+0.5) ? Colors.blue : Colors.grey,
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


class _Slides extends StatefulWidget {
  @override
  __SlidesState createState() => __SlidesState();
}
class __SlidesState extends State<_Slides> {
  
  final pageController = new PageController();

  @override
  void initState() { 
    super.initState();
    pageController.addListener(() { 
      print("la pagina es: ${pageController.page}");
      Provider.of<SliderModel>(context,listen: false).currentPage = pageController.page;
    });
    
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageController,
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