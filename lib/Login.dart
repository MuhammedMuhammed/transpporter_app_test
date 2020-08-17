import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:transpporter_app_test/availableTripsView.dart';
import 'package:transpporter_app_test/databaseModels/dbHolder.dart';
import 'package:transpporter_app_test/databaseModels/trips.dart';
import 'package:transpporter_app_test/driver.dart';
import 'package:transpporter_app_test/paymentMethods.dart';
import 'main.dart';
import 'databaseModels/users.dart';
void main() {
  dbHolder().tableCreates();
  runApp(MyApp());
}
List<trips> avaialableTrips = [new trips(
  id: 1, startPointLat:30.31231, startPointLng:30.3123123, 
   endPointLat:31.312313, 
   endPointLng:31.41241, 
   routeLength:111, 
   price:11,
   tripTime:DateTime(2020,8,14,18,00)
  ,  driverId:2
  ,  tripText:"M to M"
)];
user curUser = new user();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      
      ),
      home: MyLoginPage(title: ''),
     routes: <String,WidgetBuilder> {
       "/c":(BuildContext context) =>MyHomePage(title: 'Flutter Demo Home Page'),
       "/a":(BuildContext context) =>Routes(),
       "/b":(BuildContext context) =>USERSTrips(),
       "/d":(BuildContext context) =>DriverMain(),
       "/e":(BuildContext context) =>AvailableTrips(),
       "/f":(BuildContext context) =>PaymentMethods()

     
     },
    );
  }
}

class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
  }
  class _MyLoginPageState extends State<MyLoginPage> {
    int _counter = 0;
    Color btnColor = Colors.grey;
        bool driver = false;

     void _incrementCounter() {
    setState(() {
   
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
     }
     @override
     Widget build(BuildContext context) {
       Map args = ModalRoute.of(context).settings.arguments;
       PageController pageController = new PageController();
       TextEditingController phoneEditingController = new TextEditingController();
       TextEditingController emailEditingController = new TextEditingController();
       TextEditingController passwordEditingController = new TextEditingController();
        
        return Scaffold( 
        
        body:PageView(
          physics: NeverScrollableScrollPhysics(),
          allowImplicitScrolling: false,
          children: <Widget>[
            Container(
              color: Colors.lime,
              child: Center(
                child:Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children:[
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width - 50,
                   child:FlatButton(
                    color: Colors.white,

                     materialTapTargetSize: MaterialTapTargetSize.padded,
                     onPressed: (){

                      driver =true;
                      if(pageController.hasClients){
                        Future.delayed(Duration(milliseconds: 50),(){
                      pageController.animateToPage(3, duration: Duration(milliseconds: 1000), curve: Curves.easeInOut );
                        });
                      }
                    }, child: Text("Login"))
                    ),
                    ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width - 50,
                   child:FlatButton(
                    color: Colors.white,

                     materialTapTargetSize: MaterialTapTargetSize.padded,
                     onPressed: (){

                      if(pageController.hasClients){
                        Future.delayed(Duration(milliseconds: 50),(){
                      pageController.animateToPage(1, duration: Duration(milliseconds: 1000), curve: Curves.easeInOut );
                        });
                      }
                    }, child: Text("Register"))
                    ),
                    
                ]
                 )
                  )
                ),
            Container(
              color: Colors.lime,
              child: Center(
                child:Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children:[
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width - 50,
                   child:FlatButton(
                    color: Colors.white,

                     materialTapTargetSize: MaterialTapTargetSize.padded,
                     onPressed: (){

                      driver =true;
                      if(pageController.hasClients){
                        Future.delayed(Duration(milliseconds: 50),(){
                      pageController.animateToPage(2, duration: Duration(milliseconds: 1000), curve: Curves.easeInOut );
                        });
                      }
                    }, child: Text("driver"))
                    ),
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width - 50,
                   child:FlatButton(
                    color: Colors.white,
                     
                     onPressed: (){
                      driver =false;
                      
                      if(pageController.hasClients){
                        Future.delayed(Duration(milliseconds: 50),(){
                      pageController.animateToPage(2, duration: Duration(milliseconds: 1000), curve: Curves.easeInOut );
                        });
                      }
                    }, child: Text("passengers"))
                  ),


                               ]),
              ),
       
            ),
            Container(
              color: Colors.lime,
              child: Center(

                child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,

                  children:<Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                    child:TextField(
                      decoration: InputDecoration(
                        
                        filled: true,
                        border:InputBorder.none,
                        fillColor: Colors.white,
                        hintText: "Email",
                      )
                      ,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailEditingController)),
                  Padding(
                      padding: EdgeInsets.all(5),
                    child:TextField(
                      decoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        hintText: "Password",
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordEditingController,)),
                    
                    Padding(
                      padding: EdgeInsets.all(5),
                    child:TextField(
                    decoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        hintText: "Phone",
                      ),
                    keyboardType: TextInputType.phone,
                    controller: phoneEditingController,)),
                      // CheckboxListTile(
                      //   key: Key("isDriver"),
                      //   value: driver,
                      //   onChanged:(value){
                          
                      //   setState((){ driver =value;
                      
                      //   emailEditingController.text = emailEditingController.text;
                      //   passwordEditingController.text = passwordEditingController.text;  });
                      //     print(driver.toString());                  
                      //                        }
                      //                        ,
                      //   title: Text("driver"),
                      //   controlAffinity: ListTileControlAffinity.leading,
                        
                      // ),
                    FlatButton(onPressed: (){
                      curUser.id= driver? 2: 1;
                      curUser.username= "MUHD";
                      curUser.password= passwordEditingController.text;
                      curUser.userrole= driver? userRole.driver: userRole.passenger;
                      curUser.birthDate= DateTime.parse("1969-07-20 20:18:04");
                      curUser.userImg="";
                      curUser.email= emailEditingController.text;
                    print("here");
                    if(driver){  
                      Navigator.of(context).pushNamed("/d");
                    }else{
                      Navigator.of(context).pushNamed("/c");

                    }
                    }, child: Text("submit"))

                  ]
                )), 
                
              ),
                          Container(
              color: Colors.lime,
              child: Center(

                child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,

                  children:<Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                    child:TextField(
                      decoration: InputDecoration(
                        
                        filled: true,
                        border:InputBorder.none,
                        fillColor: Colors.white,
                        hintText: "Email",
                      )
                      ,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailEditingController)),
                  Padding(
                      padding: EdgeInsets.all(5),
                    child:TextField(
                      decoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        hintText: "Password",
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordEditingController,)),
                    
                                   // CheckboxListTile(
                      //   key: Key("isDriver"),
                      //   value: driver,
                      //   onChanged:(value){
                          
                      //   setState((){ driver =value;
                      
                      //   emailEditingController.text = emailEditingController.text;
                      //   passwordEditingController.text = passwordEditingController.text;  });
                      //     print(driver.toString());                  
                      //                        }
                      //                        ,
                      //   title: Text("driver"),
                      //   controlAffinity: ListTileControlAffinity.leading,
                        
                      // ),
                    FlatButton(onPressed: (){
                      curUser.id= driver? 2: 1;
                      curUser.username= "MUHD";
                      curUser.password= passwordEditingController.text;
                      curUser.userrole= driver? userRole.driver: userRole.passenger;
                      curUser.birthDate= DateTime.parse("1969-07-20 20:18:04");
                      curUser.userImg="";
                      curUser.email= emailEditingController.text;
                    print("here");
                    if(driver){  
                      Navigator.of(context).pushNamed("/d");
                    }else{
                      Navigator.of(context).pushNamed("/c");

                    }
                    }, child: Text("Login"))

                  ]
                )), 
                
              ),
          ],
            
          controller: pageController,
          scrollDirection: Axis.horizontal,
          pageSnapping: true,
          onPageChanged: (number){
            print("page $number");
          },
        ),
        );
     }

  }
