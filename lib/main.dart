import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:catcher/catcher.dart';
import 'package:transpporter_app_test/availableTripsView.dart';
import 'MapAdapter/mapHolder.dart';
import 'Login.dart';
import 'databaseModels/users.dart';
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Set<Marker> markers = {};
  Set<Polyline> polylinePoints = {};
  List<LatLng> routeCoords;
   Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kNasrCityPlex = CameraPosition(
      target: LatLng(30.0324825,31.338229),
      zoom: 7.4746,
    );

    static final CameraPosition _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(30.0324825,31.338229),
        tilt: 59.440717697143555,
        zoom: 1.151926040649414);
      final Geolocator _geolocator = Geolocator();
      GoogleMapPolyline googleMapPolyline =
       new GoogleMapPolyline(apiKey:"AIzaSyCoNs3BnV5cJgNKjuZg9XC7SkHcPg4sNgU");
        // // For storing the current position
      Position _currentPosition ;
      Position startCoordinates;
      Position destinationCoordinates;

      final startAddressController = TextEditingController();
    var _currentAddress;
    var _startAddress;
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

// Container(
//               alignment:Alignment.bottomCenter,
//               height:200,
//               color:Color.fromRGBO(0, 0, 0, 1),
//               child: Row(children: <Widget>[
//                  Center(
//                  child:Ink(
//                       decoration: const ShapeDecoration(
//                           color: Colors.lightBlue,
//                           shape: CircleBorder(),
//                          ),
                         
                                
//                       child:IconButton(
//                           onPressed: (){

//                           },
//                           icon: Icon(Icons.add))
//                           ),
//                      ),
                     
//                    ],),
//             )
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    Map args = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      appBar: AppBar(
        
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Home"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(child: 
               Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Column(
                  children: [
                     Text(curUser.username),

                  ]
                ),
              )
              ),
            Expanded(child: 
             ListView(children: [
                ListTile(
                  
                  title: new Text("Home"),
                ),
                ListTile(
                  title: new Text("Routes"),
                  onTap: () => Navigator.of(context).pushNamed("/a"),
                  
                ),
                ListTile(
                  title: new Text("Your Trips"),
                  onTap: () => Navigator.of(context).pushNamed("/b"),
                ),
           
              ]),
              )
            
          ],
        ),
 
      ),
      body:Wrap(
      children:[
        Container(
        height: MediaQuery.of(context).size.height -200,
        child: GoogleMap(
        
        mapType: MapType.normal,
        initialCameraPosition:  _kNasrCityPlex,
        zoomGesturesEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          print("List:"+ curUser.toString());
           print("check args:"+args.toString());

          if(args != null || args.isEmpty == false )
          {
            if(args["drawRoute"]){
            var s =args["nasrCity_Badr"][0];
            var r = args["drawRoute"];
            Future.delayed(Duration(milliseconds: 2000),(){
             _drawRoute(args["nasrCity_Badr"][1], args["drawRoute"]);

            });
                  
            }
          }
        },
         markers: markers != null ? Set<Marker>.from(markers) : null,
        polylines: polylinePoints != null ? Set<Polyline>.from(polylinePoints) : null,
      ),
      ),
      Positioned(
        bottom: 0,
        child:Container(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.height/9, 5, 5, 5),
          height: 114,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Ink(
              
              width: 48,
            height:48 ,
            decoration: ShapeDecoration(
              shape: CircleBorder(),
              color:Color.fromRGBO(255, 255, 255, 1),
              shadows:[
                 BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius:5,
                  blurRadius: 7,
                  offset: Offset(0, 3)     
                )
                ]
              ),
            child:IconButton(
              alignment: Alignment.center,
              icon: Icon(Icons.add), 
              onPressed: (){
                      Navigator.of(context).pushNamed("/e");
                
              }),
            )
        ]),
      ),
      )]
     )

    
     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
  Future<void> _drawRoute(List points,bool drawRoute) async {
     try {
       _currentPosition = await Geolocator().getCurrentPosition(
         desiredAccuracy: LocationAccuracy.high
       );

    // Places are retrieved using the coordinates
    List<Placemark> p = await _geolocator.placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition.longitude);
    
    // Taking the most probable result
    Placemark place = p[0];

    
    
      // Structuring the address
      _currentAddress =
          "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
      
      // Update the text of the TextField
      startAddressController.text = _currentAddress;

      // Setting the user's present location as the starting address
      _startAddress = _currentAddress;
      List<Placemark> startPlacemark =
          await _geolocator.placemarkFromAddress(_startAddress);
      List<Placemark> destinationPlacemark =
          await _geolocator.placemarkFromAddress("Badr city");

      // Retrieving coordinates
      startCoordinates = startPlacemark[0].position;
      destinationCoordinates = destinationPlacemark[0].position;
        routeCoords = await googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(30.0324825,31.338229),
         destination: LatLng(30.1350694,31.7117137),
          mode: RouteMode.driving);    
  } catch (e) {
    print(e);
  } finally{
    // Getting the placemarks
    
    // Start Location Marker
Marker startMarker = Marker(
  markerId: MarkerId('$startCoordinates'),
  position: LatLng(
    startCoordinates.latitude,
    startCoordinates.longitude,
  ),
  infoWindow: InfoWindow(
    title: 'Start',
    snippet: _startAddress,
  ),
  icon: BitmapDescriptor.defaultMarker,
);
    
    // Destination Location Marker
    Marker destinationMarker = Marker(
      markerId: MarkerId('$destinationCoordinates'),
      position: LatLng(
        destinationCoordinates.latitude,
        destinationCoordinates.longitude,
      ),
      infoWindow: InfoWindow(
        title: 'Destination',
        snippet: "Badr city",
      ),
      icon: BitmapDescriptor.defaultMarker,
    );
    Polyline polylineDraw = 
    Polyline(
      polylineId: PolylineId("route1"),
      points:routeCoords,
      width: 3,
    startCap: Cap.roundCap,
    endCap:Cap.buttCap );
    // Add the markers to the list
    polylinePoints.add(polylineDraw);
    markers.add(startMarker);
    markers.add(destinationMarker);
    print("address:"+routeCoords.toString()+"\n");
     print("routes coords:"+drawRoute.toString()+"\n");
    setState(() {
      
    });
  }

  }
}

// trips Classes


class Trips extends StatelessWidget {
  int _counter = 0;
   
   List<Widget> containers =[
     Container(
       color:Colors.black,

     ),
    Container(
       color:Colors.blue,

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

// routes Classes


class Routes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
          
      ),
      body: Center(
        child:ListView(
          children: [
            ListTile(
                title:Text("nasr city - Badr"),
                onTap: ()=>_route(context),
              
              )
          ],
        )

        ),
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
