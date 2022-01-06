import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kontrasepsi_app/bloc/kontrasepsiBloc.dart';
import 'package:kontrasepsi_app/bloc/propinsiBloc.dart';
import 'package:kontrasepsi_app/bloc/transaksiBloc.dart';
import 'package:kontrasepsi_app/view/master/kontrasepsiView.dart';
import 'package:kontrasepsi_app/view/master/propinsiView.dart';
import 'package:kontrasepsi_app/view/transaksi/inputFormView.dart';
import 'package:kontrasepsi_app/view/transaksi/reportView.dart';

class MenuView extends StatefulWidget {
  final AnimationController mainScreenAnimationController;
  final Animation mainScreenAnimation;

  const MenuView(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<String> areaListData = [
    "lib/assets/images/bill.png",
    "lib/assets/images/report.png",
    "lib/assets/images/input-2.png",
    "lib/assets/images/input-3.png",
  ];

  List<String> areaListDataText = [
    "Input Data",
    "Report",
    "Propinsi",
    "Kontrasepsi",
  ];

  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: GridView(
                  shrinkWrap: true,
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                  //physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: List.generate(
                    areaListData.length,
                    (index) {
                      var count = areaListData.length;
                      var animation = Tween(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      );
                      animationController.forward();
                      return AreaView(
                        imagepath: areaListData[index],
                        animation: animation,
                        animationController: animationController,
                        imageText: areaListDataText[index],
                      );
                    },
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 24.0,
                    crossAxisSpacing: 24.0,
                    childAspectRatio: 1.0,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AreaView extends StatelessWidget {
  final String imagepath;
  final String imageText;
  final AnimationController animationController;
  final Animation animation;

  const AreaView({
    Key key,
    this.imagepath,
    this.imageText,
    this.animationController,
    this.animation,
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: new Transform(
              transform: new Matrix4.translationValues(
                  0.0, 50 * (1.0 - animation.value), 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    splashColor: Colors.blueGrey.withOpacity(0.2),
                    onTap: () {
                      if (imageText == "Input Data"){
                        TransactionBloc bloc = TransactionBloc();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                            new BlocProvider(
                              bloc: bloc,
                              child: InputFormView(mainScreenAnimationController: animationController,)
                            ) 
                          )
                        );
                      }
                      if (imageText == "Report"){
                        TransactionBloc bloc = TransactionBloc();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                            new BlocProvider(
                              bloc: bloc,
                              child: ReportView(mainScreenAnimationController: animationController,)
                            ) 
                          )
                        );
                      }
                      if (imageText == "Propinsi"){
                        PropinsiBloc blocPropinsi = PropinsiBloc();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                            new BlocProvider(
                              bloc: blocPropinsi,
                              child: PropinsiView(mainScreenAnimationController: animationController,)
                            ) 
                          )
                        );
                      }
                      if (imageText == "Kontrasepsi"){
                        KontrasepsiBloc blocKontrasepsi = KontrasepsiBloc();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                            new BlocProvider(
                              bloc: blocKontrasepsi,
                              child: KontrasepsiView(mainScreenAnimationController: animationController,)
                            ) 
                          )
                        );
                      }
                    },
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 18, left: 16, right: 16),
                          //child: Image.asset(imagepath),
                          child: new Image(image: new AssetImage(imagepath), width: 100.0, height: 100.0),
                        ),
                        Text(
                          imageText,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            letterSpacing: 0.5,
                            color: Colors.lightBlue,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
    );
  }

}

