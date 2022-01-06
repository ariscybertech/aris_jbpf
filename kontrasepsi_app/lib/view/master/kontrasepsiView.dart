import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kontrasepsi_app/bloc/kontrasepsiBloc.dart';
import 'package:kontrasepsi_app/main.dart';
import 'package:kontrasepsi_app/model/KontrasepsiModel.dart';

import 'package:progress_dialog/progress_dialog.dart';

class KontrasepsiView extends StatefulWidget {
  final AnimationController mainScreenAnimationController;
  final Animation mainScreenAnimation;
  const KontrasepsiView(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);
  @override
  _KontrasepsiViewState createState() => _KontrasepsiViewState();
}

class _KontrasepsiViewState extends State<KontrasepsiView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  var scrollController = ScrollController();
  

  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    final bloc = BlocProvider.of<KontrasepsiBloc>(context); 
    bloc.onGetData();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }
  
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<KontrasepsiBloc>(context); 
    pr = new ProgressDialog(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("181b61"),
        title: Text("List Data Alat Kontrasepsi"),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if(snapshot.data == null){
            return Container();
          }else{
            return Wrap(
              children: <Widget>[
                AnimatedBuilder(
                  animation: widget.mainScreenAnimationController,
                  builder: (BuildContext context, Widget child) {
                    return BlocBuilder(
                      bloc: bloc,
                      builder: (BuildContext context, KontrasepsiState state) {
                        if(state.list == null){
                          Future.delayed(Duration.zero, () => pr.show());
                          return Container();
                        }
                        else{
                          if(pr.isShowing()){
                            Future.delayed(Duration(milliseconds: 2)).then((onvalue) {
                              pr.hide();
                            });
                          }
                          
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                dataReport(state.list),
                              ],
                            ),
                          );
                        }
                      }
                    );
                  },
                )
              ],
            );
          }
        }
      ),
    );
  }

  Widget dataReport(List<KontrasepsiModel> data){
    if (data.length > 0){
      return new Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(width: 0.0, color: Colors.grey),
            borderRadius: BorderRadius.all(
              Radius.circular(0.0)
            )
          ),
          child: ListView.builder(
          itemBuilder: (context, index) {
            
            if (index == 0){
              return Container(
                color: Colors.white,
                padding: EdgeInsets.all(20.0),
                child: Table(
                  border: TableBorder.all(color: Colors.white),
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.only(left:0.0),
                        child: Text("ID",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:0.0),
                        child: Text("Alat Kontrasepsi",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                    ])
                  ],
                ),
              );
            }
            index -=1;

            return Container(
              color: Colors.white,
              padding: EdgeInsets.all(20.0),
              child: Table(
                border: TableBorder.all(color: Colors.white),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(left:0.0),
                      child: Text(data[index].idKontrasepsi.toString()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:0.0),
                      child: Text(data[index].namaKontrasepsi.toString() ),
                    ),
                  ])
                ],
              ),
            );
          },
          scrollDirection: Axis.vertical,
          controller: scrollController,
          //physics: const AlwaysScrollableScrollPhysics(),
          itemCount: data.length + 1,
          shrinkWrap: true,
          ),
        ),
      );
    }else{
      return Container();
    }
  }
}
