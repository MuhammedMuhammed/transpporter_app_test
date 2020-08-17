import 'dart:async';
import 'package:flutter/material.dart';
import 'package:transpporter_app_test/Login.dart';
import 'package:transpporter_app_test/databaseModels/trips.dart';
import 'package:transpporter_app_test/databaseModels/tripsLists.dart';
import 'package:transpporter_app_test/databaseModels/userTrips.dart';
import 'package:transpporter_app_test/databaseModels/users.dart';
import 'databaseModels/paymentMethods.dart';
class PaymentMethods extends StatelessWidget{
 List<PaymentMethodsData> pmdAll = [PaymentMethodsData(
    id:1,
    method:paymentMethod.cash,
    userId:curUser.id
  )];
  static int counter = ListTrips.stLs.length>0?  ListTrips.stLs.last.id:0;

  @override
  Widget build(BuildContext context) {
    Map trs = ModalRoute.of(context).settings.arguments;
    trips tr = trs["tripData"];
    List<PaymentMethodsData> curPmdList=pmdAll.where((element) => element.userId == curUser.id).toList(); 
    PaymentMethodsData mCurPm = curPmdList.where((element) => element.method == curUser.mpay).first; 
    curPmdList.sort((a,b)=> a.id.compareTo(mCurPm.id));
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.tripText),
          
      ),
     body:ListView.builder(
      itemCount:curPmdList.length,
      itemBuilder: (context,index)
      {
        String methodName = curPmdList[index].method.index == 0 ?"cash": "card";
        return ListTile(
          contentPadding: EdgeInsets.all(5),
          leading: Icon(Icons.attach_money
          ,color: Colors.green,),
          title: Text(methodName),
          trailing: Text("1"),
          onTap: (){
             usertrips s = usertrips(
                                  id: counter,
                                  tripId: tr.id,
                                  userId: curUser.id,
                                  passengerNum: 1,
                                  amount: tr.price,
                                        );
                    
              ListTrips.stLs.add(s);           
              print(ListTrips.stLs.toString());
            Navigator.popUntil(context, ModalRoute.withName('/c'));
          },
          );
        
      })
      );
      }
}