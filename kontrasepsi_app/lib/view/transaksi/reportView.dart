import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kontrasepsi_app/bloc/transaksiBloc.dart';
import 'package:kontrasepsi_app/main.dart';
import 'package:kontrasepsi_app/model/transactionModel.dart';

import 'package:progress_dialog/progress_dialog.dart';

class ReportView extends StatefulWidget {
  final AnimationController mainScreenAnimationController;
  final Animation mainScreenAnimation;
  const ReportView(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);
  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  var scrollController = ScrollController();
  
  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    final bloc = BlocProvider.of<TransactionBloc>(context); 
    bloc.onGetDataReport();
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
    final bloc = BlocProvider.of<TransactionBloc>(context); 
    pr = new ProgressDialog(context);
    return Container(
          color: Colors.white,
          child: Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("181b61"),
        title: Text("Rerport Pemakai Kontrasepsi"),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if(snapshot.data == null){
            return Container();
          }else{
            return Stack(
              children: <Widget>[
                AnimatedBuilder(
                  animation: widget.mainScreenAnimationController,
                  builder: (BuildContext context, Widget child) {
                    return BlocBuilder(
                      bloc: bloc,
                      builder: (BuildContext context, TransactionState state) {
                        if(state.report == null){
                          Future.delayed(Duration.zero, () => pr.show());
                          return Container();
                        }
                        else{
                          if(pr.isShowing()){
                            Future.delayed(Duration(milliseconds: 2)).then((onvalue) {
                              pr.hide();
                            });
                          }
                          return dataReport(state.report); 
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
          )
    );
  }

  Widget dataReport(List<TransactionReportModel> data){
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
                        child: Text("No",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:0.0),
                        child: Text("Propinsi",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Text("Pil",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:15.0),
                        child: Text("Kondom",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:30.0),
                        child: Text("IUD",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:30.0),
                        child: Text("Jumlah",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
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
                      child: Text(data[index].rowNumber.toString()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:0.0),
                      child: Text(data[index].namaPropinsi.toString() ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: Text(data[index].pil.toString(),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:15.0),
                      child: Text(data[index].kondom.toString(),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:30.0),
                      child: Text(data[index].iud.toString(),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:30.0),
                      child: Text(data[index].jumlah.toString(),),
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

