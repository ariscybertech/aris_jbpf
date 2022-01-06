import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kontrasepsi_app/bloc/transaksiBloc.dart';
import 'package:kontrasepsi_app/main.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class InputFormView extends StatefulWidget {
  final AnimationController mainScreenAnimationController;
  final Animation mainScreenAnimation;
  const InputFormView(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);
  @override
  _InputFormViewState createState() => _InputFormViewState();
}

class _InputFormViewState extends State<InputFormView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  

  final textControllerIDPropinsi = TextEditingController(), 
        textControllerIDKontrasepsi = TextEditingController(),
        textControllerTotal = TextEditingController();
  

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

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }
  
  ProgressDialog pr;

  void insertData() {
    final bloc = BlocProvider.of<TransactionBloc>(context); 
      pr = new ProgressDialog(context);
      if (textControllerIDPropinsi.text == null){
        Alert(context: context, title: "Alert", desc: "Please input id propinsi!").show();
      }else if (textControllerIDKontrasepsi.text == ""){
        Alert(context: context, title: "Alert", desc: "Please input id kontrasepsi!").show();
      }else if(textControllerTotal.text == ""){
          Alert(context: context, title: "Alert", desc: "Please input total pemakai!").show();
      }else{
        try{
          bloc.insertData(int.parse(textControllerIDPropinsi.text), int.parse(textControllerIDKontrasepsi.text), int.parse(textControllerTotal.text))
          .then((result) {
            if(result){
              Alert(context: context, title: "Sukses", desc: "Data berhasil disimpan").show();
            }else{
              Alert(context: context, title: "Error", desc: "Terjadi kesalahan pada server").show();
            }
          });
          
        }catch(SocketException){
          Alert(context: context, title: "Error", desc: "Terjadi kesalahan pada server").show();
        }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("181b61"),
        title: Text("Input Pemakai Kontrasepsi"),
      ),
      body: new Wrap(
        children: <Widget>[
          AnimatedBuilder(
            animation: widget.mainScreenAnimationController,
            builder: (BuildContext context, Widget child) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    formInput(),
                  ],
                ),
              );
            },
          )
        ],
      )
    );
  }

  Widget formInput() {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if(snapshot.data == null){
          return Container();
        }else{
          final bloc = BlocProvider.of<TransactionBloc>(context); 
          return BlocBuilder(
            bloc: bloc,
            builder: (BuildContext context, TransactionState state) {
              textControllerIDPropinsi.text = (state.propinsiModel != null) ? state.propinsiModel.idPropinsi.toString() : textControllerIDPropinsi.text; 
              textControllerIDKontrasepsi.text = (state.kontrasepsiModel != null) ? state.kontrasepsiModel.idKontrasepsi.toString() : textControllerIDKontrasepsi.text; 
              //textControllerTotal.text = (textControllerTotal.text == "0" || textControllerTotal.text == "" ) ? state.volume.toString().replaceAll(".0", "") : textControllerTotal.text; 
              return Container(
                padding: const EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white,
                    HexColor("#FFFFFF")
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(60.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      new TextFormField(
                        onChanged: (value){
                          bloc.onGetDataPropinsiByID(int.parse(value));
                        },
                        controller: textControllerIDPropinsi,
                        decoration: const InputDecoration(labelText: 'ID Propinsi'),
                        keyboardType: TextInputType.number,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0, top: 20.0, left: 0.0, right: 5.0),
                            child: Text("Propinsi: " + ((state.propinsiModel != null) ? state.propinsiModel.namaPropinsi : ""), style: TextStyle(fontSize: 14, color: Colors.grey)),
                          )
                        ]
                      ),
                      new TextFormField(
                        controller: textControllerIDKontrasepsi,
                        decoration: const InputDecoration(labelText: 'ID Kontrasepsi'),
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          bloc.onGetDataKontrasepsiByID(int.parse(value));
                        },
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0, top: 20.0, left: 0.0, right: 5.0),
                            child: Text("Kontrasepsi: " + ((state.kontrasepsiModel != null) ? state.kontrasepsiModel.namaKontrasepsi : ""), style: TextStyle(fontSize: 14, color: Colors.grey)),
                          )
                        ]
                      ),
                      new TextFormField(
                        controller: textControllerTotal,
                        decoration: const InputDecoration(labelText: 'Jumlah Pemakai'),
                        keyboardType: TextInputType.number,
                      ),
                      new SizedBox(
                        height: 10.0,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: SizedBox(
                          width: 300.0, // match_parent
                          child: new RaisedButton(
                             onPressed: (){
                              insertData();
                            },
                            color: HexColor("181b61"),
                            textColor: Colors.white,
                            child: new Text('Simpan'),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              );
            }
          );
        }
      }
    );
  }
}
