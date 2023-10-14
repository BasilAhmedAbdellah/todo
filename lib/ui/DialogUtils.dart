import 'package:flutter/material.dart';

class DialogUtils{

      static void showLoading(BuildContext context , String message ,
          {bool isCancelable = true}){

        showDialog(context: context, builder: (buildContext){

          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 5,),
                Expanded(child: Text(message))
              ],
            ),
          );
        },
        barrierDismissible: isCancelable
        );
      }
      static void hideMessage (BuildContext context){
        Navigator.pop(context);
      }
      static void showMessage(BuildContext context , String message ,
          {bool isCancelable = true,
            String? PosActionTitle,
            VoidCallback? posAction,
            String? NegActionTitle,
            VoidCallback? negAction
          }){
        List<Widget> actions=[];
        if(PosActionTitle!=null){
          actions.add(TextButton(onPressed: (){
            Navigator.pop(context);
            posAction?.call();
          },
              child:Text(PosActionTitle) ));
        }
        if(NegActionTitle!=null){
          actions.add(TextButton(onPressed: (){
            Navigator.pop(context);
            negAction?.call();
          },
              child:Text(NegActionTitle) ));
        }

        showDialog(context: context, builder: (buildContext){

          return AlertDialog
            (
            actions: actions,
            content: Row(
              children: [
                Expanded(child: Text(message))
              ],
            ),
          );
        },
            barrierDismissible: isCancelable
        );
      }
}