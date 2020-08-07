import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:transpporter_app_test/databaseModels/trips.dart';
import 'package:transpporter_app_test/databaseModels/tripsLists.dart';
import 'package:transpporter_app_test/databaseModels/userTrips.dart';
import 'package:transpporter_app_test/dialog.dart';
import 'Login.dart';

List<trips> avaialableTrips = [new trips(
  id: 1, startPointLat:30.31231, startPointLng:30.3123123, 
   endPointLat:31.312313, 
   endPointLng:31.41241, 
   routeLength:111, 
   price:11,
   tripTime:DateTime.now()
  ,  driverId:2
  ,  tripText:"M to M"
)];


class AvailableTrips extends StatelessWidget {
  int counter =0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
          
      ),
      body: ListView.builder(
          itemCount: avaialableTrips.length,
          itemBuilder:(context,index){ 
              String titleText =index >= 0 ? avaialableTrips[index].tripText: "no Availabel Trips"; 
             return ListTile(
                  title:Text(titleText),
                  onLongPress:(trips tr) 
                      {  print("tripText:"+tr.tripText);
                      Future.delayed(Duration(milliseconds: 2000)).then((value) => {
                      
                        showDialog(
                        context: context,
                        builder: (context)
                          {
                            return AlertDialog(
                              title: Text("trips"),
                              actions:[
                                Text(tr.tripText),
                                Text(tr.price.toString()),
                            MaterialButton(
                              elevation: 5.0,
                              onPressed: (){
                               usertrips s = usertrips(
                                  id: counter,
                                  tripId: tr.id,
                                  userId: curUser.id,
                                  passengerNum: 1,
                                  amount: tr.price,
                                  isfinished: false,
                                  hasDiscount:false
                                );
                                 
                               ListTrips.stLs.add(s);           
                                counter++;
                              },
                              child: Text("Submit"),
                              )
                              ],
                          );
                          }
                        )
                        
                        // DialogsCreator().createDialog(
                        //   context,
                        //    "trips",
                        //     [
                        //     MaterialButton(
                        //       elevation: 5.0,
                        //       onPressed: (){
                        //        usertrips s = usertrips(
                        //           id: counter,
                        //           tripId: tr.id,
                        //           userId: curUser.id,
                        //           passengerNum: 1,
                        //           amount: tr.price,
                        //           isfinished: false,
                        //           hasDiscount:false
                        //         );
                                 
                        //        ListTrips.stLs.add(s);           
                        //         counter++;
                        //       },
                        //       child: Text("Submit"),
                        //       )
                        //       ],
                        //     ListView(
                        //       children:
                        //        [
                        //       //   Row(
                                  
                        //       //     children: [
                        //       //       Text("title :"),
                        //       //       Text("tr.tripText")]
                        //       //   ),
                        //       // Row(
                                  
                        //       //     children: [
                        //       //       Text("price :"),
                        //       //       Text("tr.price.toString()")]
                        //       //   )

                        //        ])
                        //     )
                     });
                      }(avaialableTrips[index])

                
                );
            }
          
        )

        
    );
  }
 Future<void> _route(BuildContext context) {
                 Navigator.pushNamed(
                   context,
                   "/c",
                   arguments:{"nasrCity_Badr":[[30.0324825,31.338229],[30.1350694,31.7117137]],
                   "drawRoute":true});
              //         MaterialPageRoute(builder: (context) => MyHomePage(),
              //                 settings: RouteSettings(
              //             arguments: {"nasrCity_Badr":[[30.0324825,31.338229],[30.1350694,31.7117137]]
              //             ,"drawRoute":true},
              //           ),
              //  ),
              //       ); 
    }
  
}

class USERSTrips extends StatelessWidget {
  int counter =0;
  static List<usertrips> curUserList = ListTrips.stLs.where((ele) => ele.userId == curUser.id).toList();
   
   List<Widget> containers =[
      ListView.builder(
          itemCount:curUserList.length,
          itemBuilder:(context,index){ 
            if(!curUserList[index].isfinished)
            {
             return MaterialButton(
                  child:Text((avaialableTrips.where((element) => element.id == curUserList[index].tripId)).first.tripText),
                  onPressed:(trips tr)
                      {
                        Future.delayed(Duration(milliseconds: 2000)).then((value) => {

                        
                        showDialog(
                        context: context,
                        builder: (context)
                          {
                            return AlertDialog(
                              title: Text("trips"),
                              actions:[
                                Text(tr.tripText),
                                Text(tr.price.toString()),
                            MaterialButton(
                              elevation: 5.0,
                              onPressed: (){
                                 
                              },
                              child: Text("Submit"),
                              )
                              ],
                          );
                          }
                        )
                        });
                        // DialogsCreator().createDialog(
                        //   context,
                        //    "trips",
                        //     [
                        //       MaterialButton(
                        //         elevation: 5.0,  
                        //       onPressed: (){
                        //                                       },
                        //       child: Text("Cancel"),

                        //       ),
                        //       MaterialButton(
                        //       elevation: 5.0,
                        //       onPressed: (){
                             
                                              
                        //       },
                        //       child: Text("Submit"),
                        //       )],
                        //     ListView(
                        //       children:
                        //        [
                        //         Row(
                                  
                        //           children: [
                        //             Text("title :"),
                        //             Text(tr.tripText)]
                        //         ),
                        //       Row(
                                  
                        //           children: [
                        //             Text("price :"),
                        //             Text(tr.price.toString())]
                        //         )

                        //        ])
                        //     );
                      }(avaialableTrips.where((element) => element.id == curUserList[index].tripId).first)

                
                );
            }
          }
        ),
    
        ListView.builder(
          itemCount: curUserList.length,
          itemBuilder:(context,index){ 
            if(curUserList[index].isfinished)
            {
             return ListTile(
                  title:Text((avaialableTrips.where((element) => element.id == curUserList[index].tripId)).first.tripText),
                  onTap:(trips tr)
                      {
                        // DialogsCreator().createDialog(
                        //   context,
                        //    "trips",
                        //     [
                        //       MaterialButton(
                        //         elevation: 5.0,  
                        //       onPressed: (){
                        //                                       },
                        //       child: Text("Cancel"),

                        //       ),
                        //       MaterialButton(
                        //       elevation: 5.0,
                        //       onPressed: (){
                             
                                              
                        //       },
                        //       child: Text("Submit"),
                        //       )],
                        //     ListView(
                        //       children:
                        //        [
                        //         Row(
                                  
                        //           children: [
                        //             Text("title :"),
                        //             Text(tr.tripText.toString())]
                        //         ),
                        //       Row(
                                  
                        //           children: [
                        //             Text("price :"),
                        //             Text(tr.price.toString())]
                        //         )

                        //        ])
                        //     );
                      }((avaialableTrips.where((element) => element.id == curUserList[index].tripId)).first)

                
                );
            }
          }
        )
    

   ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
        title: new Text("Trips"),
        bottom: TabBar(
        tabs: [
          
          Tab(text: "up coming"),
          Tab(text: "Finished Trips"),
        ],
      ),
      ),
      body: TabBarView(
        children: containers
        ),
      ),
    );
  }
}

class DriverAvailableTrips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
          
      ),
      body: ListView.builder(
          itemCount: avaialableTrips.length,
          itemBuilder:(context,index){ 
             return ListTile(
                  title:Text("avaialableTrips[index].tripText"),
                  onTap:(trips tr)
                      {
                        
                      }(avaialableTrips[index])

                
                );
            }
          
        )

        
    );
  }
 Future<void> _route(BuildContext context) {
                 Navigator.pushNamed(
                   context,
                   "/c",
                   arguments:{"nasrCity_Badr":[[30.0324825,31.338229],[30.1350694,31.7117137]],
                   "drawRoute":true});
              //         MaterialPageRoute(builder: (context) => MyHomePage(),
              //                 settings: RouteSettings(
              //             arguments: {"nasrCity_Badr":[[30.0324825,31.338229],[30.1350694,31.7117137]]
              //             ,"drawRoute":true},
              //           ),
              //  ),
              //       ); 
    }
  
}
