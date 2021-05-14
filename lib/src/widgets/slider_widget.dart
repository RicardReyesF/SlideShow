import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class SliderWidget extends StatelessWidget {
  final List<Widget> sliders;
  final bool points;
  final Color colorPrimario;
  final Color colorSecundario;
  final int bulletPrimario;
  final int bulletSecundario;
    SliderWidget({
      @required this.sliders,
      this.points = false,
      this.colorPrimario = Colors.blue,
      this.colorSecundario = Colors.grey,
      this.bulletPrimario = 12,
      this.bulletSecundario = 12,
    });  
  @override
  
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      create: (_)=> new _SlideShowModel(),
      child: SafeArea(
        child: Center(
            child: Builder(builder: (BuildContext context){
             Provider.of<_SlideShowModel>(context).colorPrimario = this.colorPrimario;
             Provider.of<_SlideShowModel>(context).colorSecundario = this.colorSecundario;
             Provider.of<_SlideShowModel>(context).bulletPrimario = this.bulletPrimario;
             Provider.of<_SlideShowModel>(context).bulletSecundario = this.bulletSecundario;
             return  _ConstruirSSModel(points: points, sliders: sliders);
            } 
          ,)
             
          ),
      ),
    );
  }
  
}

class _ConstruirSSModel extends StatelessWidget {
  const _ConstruirSSModel({
    Key key,
    @required this.points,
    @required this.sliders,
  }) : super(key: key);

  final bool points;
  final List<Widget> sliders;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if( this.points ) _Dots(this.sliders.length),
        Expanded(
          child: _Slides(this.sliders)
        ),
        if( !this.points ) _Dots(this.sliders.length)
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  final int numPag;


  _Dots(this.numPag);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
      child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(this.numPag , (i) => _Dot(i))
           )
    );
  }
}

class _Dot extends StatelessWidget {
  
  final int index;
  _Dot(this.index);
  @override
  Widget build(BuildContext context) {
   final ssModel= Provider.of<_SlideShowModel>(context);
   int tamanio;
   Color color;
   if(ssModel.currentPage >= index-0.5 && ssModel.currentPage< index+0.5){
     tamanio = ssModel.bulletPrimario;
     color = ssModel.colorPrimario;
   }else{
     tamanio = ssModel.bulletSecundario;
     color = ssModel.colorSecundario;
   }
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: tamanio.toDouble(),
      height: tamanio.toDouble(),
      decoration: BoxDecoration(
        color: color,
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
      Provider.of<_SlideShowModel>(context,listen: false).currentPage = pageController.page;
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

class _SlideShowModel with ChangeNotifier{

  double _currentPage = 0;
  Color _colorPrimario = Colors.blue;
  Color _colorSecundario = Colors.grey;
  int _bulletPrimario=12;
  int _bulletSecundario=12;

  
  double get currentPage => this._currentPage;

  set currentPage(double currentPage){
    this._currentPage = currentPage;
    notifyListeners();  
  }

  Color get colorPrimario => this._colorPrimario;

  set colorPrimario(Color colorPrimario){
    this._colorPrimario = colorPrimario;

  }

  Color get colorSecundario => this._colorSecundario;

  set colorSecundario(Color colorSecundario){
    this._colorSecundario = colorSecundario;
    
  }

  int get bulletPrimario => this._bulletPrimario;

  set bulletPrimario(int bulletPrimario){
    this._bulletPrimario = bulletPrimario;
    
  }

    int get bulletSecundario => this._bulletSecundario;

  set bulletSecundario(int bulletSecudario){
    this._bulletSecundario = bulletSecudario;
    
  }

}