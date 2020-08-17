import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:transpporter_app_test/availableTripsView.dart';
import 'package:transpporter_app_test/databaseModels/trips.dart';
import 'package:transpporter_app_test/databaseModels/userTrips.dart';
import 'Login.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:geolocator/geolocator.dart';



List<usertrips> usersOfAtrip =[
new usertrips(id: 1,
tripId: 1,
userId:1,
passengerNum:1,
amount:22,
isfinished:false,
hasDiscount:false)
];

class DriverMain extends StatelessWidget{
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
     @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    var curTime =  DateTime.now();
    List<trips> nextDriverTrips =avaialableTrips.where((element) => (element.driverId == curUser.id 
    && 0<((element.tripTime.millisecondsSinceEpoch-curTime.millisecondsSinceEpoch)/1000/60) 
    && ((element.tripTime.millisecondsSinceEpoch-curTime.millisecondsSinceEpoch)/1000/60) <=30)).toList();
    trips trip=nextDriverTrips.length>0? nextDriverTrips.first:null;
    var numOfPassengers= trip!= null? usersOfAtrip.where((element) => element.tripId == trip.id).toList():[];
    var totalCost =0.0;

    for (var t in numOfPassengers) {
      totalCost += t.amount;
    }

    Widget driverW = Container();
    
    if(trip != null )
    {
      driverW = Container(child: AlertDialog(        
                              title: Text("next Trip"),
                              actions:[
                            MaterialButton(
                              elevation: 5.0,
                              onPressed: (){
                                _route(context, [trip.startPointLat,trip.startPointLng], [trip.endPointLat,trip.endPointLng]);
                              },
                              child: Text("Submit"),
                              )
                              ],
                              content: Table(
                            children:[
                                      TableRow(
                                        children: [
                                          TableCell(child:Text("Trip:")),
                                          TableCell(child:Text(trip.tripText))
                                        ]
                                      ),
                                          TableRow(

                                        children: [
                                        TableCell(child:Text("trip Time:")),
                                        TableCell(child:  Text(trip.tripTime.toString())),
                                        ]
                                      ),
                                      TableRow(
                                        children: [
                                          TableCell(child:  Text("Passengers:")),
                                          TableCell(child:Text(numOfPassengers.length.toString() + " Passenger")),
                                      ]
                            
                                      ),
                            ]
                          ),

                          ));
                          
                    
    }
      return Scaffold(
      appBar: AppBar(
        
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Home"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            
               
            DrawerHeader(
  
                child: Row(
                  children: [
                     Image(
                        width: 100,
                        height: 100,       
                       image: AssetImage('images/user_icon_png_person_user_profile_icon_20.png')
                       ),
                     Text(curUser.username),

                  ]
                ),
              )
              ,
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
                ListTile(
                  title: new Text("logout"),
                  onTap: () => Navigator.popUntil(context, ModalRoute.withName('/')),
                ),
           
              ]),
              )
            
          ],
        ),
 
      ),
      body:Stack(
        children:[
           GoogleMap(
        
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
     driverW 
        ]
      ),
      );

  }
   Future<void> _route(BuildContext context, List<double> stLatlng,List<double> enLatlng) {
                 Navigator.pushNamed(
                   context,
                   "/d",
                   arguments:{"nasrCity_Badr":[stLatlng,enLatlng],
                   "drawRoute":true});
              //         MaterialPageRoute(builder: (context) => MyHomePage(),
              //                 settings: RouteSettings(
              //             arguments: {"nasrCity_Badr":[[30.0324825,31.338229],[30.1350694,31.7117137]]
              //             ,"drawRoute":true},
              //           ),
              //  ),
              //       ); 
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
    routeCoords[0].latitude,
    routeCoords[0].longitude,
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
        routeCoords[1].latitude,
         routeCoords[1].longitude,
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
  }
  }

}

class DriverForm extends StatelessWidget {
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
                
              
              )
          ],
        )

        ),
    );
  }
 Future<void> _route(BuildContext context) {
                 Navigator.pushNamed(
                   context,
                   "/d",
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
