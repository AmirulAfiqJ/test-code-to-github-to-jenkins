import 'package:flutter/material.dart';

class DataUser extends StatelessWidget {
  final List<Widget> children;
  const DataUser({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}

class DataList extends StatelessWidget {
  final List listrekod;
  const DataList({super.key, required this.listrekod});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth >= 501 ? MediaQuery.sizeOf(context).width * .55 : MediaQuery.sizeOf(context).width,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: listrekod.take(5).length,
              itemBuilder: (context, i){
                var aa = listrekod[i];
                String pay = "";

                if(aa["camefrom"] == "WOO"){
                  pay = "Payment Method: WooCommerce";
                }
                else if(aa["camefrom"] == "EMALL"){
                  pay = "Payment Method: Bizappshop (Minishop)";
                }
                else if(aa["fpxkey"] == "DONE"){
                  pay = "Payment Method: Bizappay";
                }
                else{
                  pay = "Payment Method: Manual";
                }

                return ListTile(
                  title: Text("${i+1} . ${listrekod[i]['transactiondate']}  -  $pay"),
                );
              }),
        );
      },
    );
  }
}


