import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_show/src/models/slider_model.dart';


class SliderWidget extends StatelessWidget {
  final List<Widget> sliders;
  final bool points;
  final Color colorPrimario;
  final Color colorSecundario;
    SliderWidget({
      @required this.sliders,
      this.points = false,
      this.colorPrimario = Colors.blue,
      this.colorSecundario = Colors.grey
    });  
  @override
  
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      create: (_)=> new SliderModel(),
      child: SafeArea(
        child: Center(
            child: Column(
              children: [
                if( this.points ) _Dots(this.sliders.length,this.colorPrimario,this.colorSecundario),
                Expanded(
                  child: _Slides(this.sliders)
                ),
                if( !this.points ) _Dots(this.sliders.length,this.colorPrimario,this.colorSecundario)
              ],
            ),
          ),
      ),
    );
  }
  
}

class _Dots extends StatelessWidget {
  final int numPag;
  final Color colorPrimario;
  final Color colorSecundario;

  _Dots(this.numPag,this.colorPrimario,this.colorSecundario);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
      child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(this.numPag , (i) => _Dot(i,this.colorPrimario,this.colorSecundario))
           )
    );
  }
}

class _Dot extends StatelessWidget {
  final Color colorPrimario;
  final Color colorSecundario;
  final int index;
  _Dot(this.index,this.colorPrimario,this.colorSecundario);
  @override
  Widget build(BuildContext context) {
   final paginaActual= Provider.of<SliderModel>(context).currentPage;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: ( paginaActual >= index-0.5 && paginaActual< index+0.5) ? this.colorPrimario : this.colorSecundario,
        shape: BoxShape.circle
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> sliders;
  _Slides(this.sliders);
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
        children: widget.sliders.map( (slide) => _Slide(slide) ).toList()
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;
  _Slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(55.0),
      width: double.infinity,
      height: double.infinity,
      child: slide,
    );
  }
}