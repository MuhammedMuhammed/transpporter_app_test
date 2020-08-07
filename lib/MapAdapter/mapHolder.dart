import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
class MyMap {
  Set<Marker> markers = {};
  Set<Polyline> polylinePoints = {};
  List<LatLng> routeCoords;
  Completer<GoogleMapController> _controller = Completer();

  Geolocator _geolocator = Geolocator();
  GoogleMapPolyline googleMapPolyline =
       new GoogleMapPolyline(apiKey:"AIzaSyCoNs3BnV5cJgNKjuZg9XC7SkHcPg4sNgU");
  Position _currentPosition ;
  Position startCoordinates;
  Position destinationCoordinates;
    var _currentAddress;
    var _startAddress;

  pemissionRequest() async
  {
    var status = await Permission.location.status;
    if(status.isUndetermined || status.isDenied)
    {
      Permission.location.request();
    }

    if(status.isRestricted)
    {

    }
    if(status.isGranted)
    {

    }
    
    return status;
  }

  getCurrentPos() async
  {
    Position curPos = await Geolocator().getCurrentPosition(
         desiredAccuracy: LocationAccuracy.high
       );
    this._currentPosition = curPos;   
       return curPos;
  }
  

  cameraPos(double bearings,LatLng targets,double tilts,double zooms)
  {
       CameraPosition camPosition = CameraPosition(
        bearing: bearings,
        target: targets,
        tilt: tilts,
        zoom: zooms);


        return camPosition;
  }
  
  drawMarker(double lat,double lng,
  String id,String title,
  String address,BitmapDescriptor icon){
    Marker marker = Marker(
      markerId: MarkerId(id),
      position: LatLng(
        lat,
        lng,
      ),
      infoWindow: InfoWindow(
        title: title,
        snippet: address,
      ),
      icon: icon,
    );   
    return marker; 
  }

  drawMultiMarkers(List<LatLng> points,List<String> id
    ,List<String> titles, List<String> addresses,List<BitmapDescriptor> icons)
  {
    this.markers = {};
    for (int p =0; p< points.length;p++) {
    Marker marker = Marker(
      markerId: MarkerId(id[p]),
      position: points[p],
      infoWindow: InfoWindow(
        title: titles[p],
        snippet: addresses[p],
      ),
      icon: icons[p],
    );
    this.markers.add(marker);
    }

    return markers;
  }


  addMarkersToList(Marker marker)
  {
    this.markers.add(marker);
    return this.markers;
  }

  drawPolyline(List<LatLng> mRouteCoords,String id,int width,Cap sCap,Cap eCap)
  {
    Polyline polylineDraw = 
    Polyline(
      polylineId: PolylineId(id),
      points:mRouteCoords,
      width: 3,
    startCap: sCap,
    endCap:eCap );
   return polylineDraw; 
  }

  drawMultiPoltlines(List<List<LatLng>> mLRouteCoords,List<String> ids,
  List<int> widths,List<Cap> sCaps,List<Cap> eCaps)
  {
    this.polylinePoints = {};
    for(int i =0;i<=mLRouteCoords.length ;i++)
    {
    Polyline polylineDraw = 
    Polyline(
      polylineId: PolylineId(ids[i]),
      points:mLRouteCoords[i],
      width: widths[i],
      startCap: sCaps[i],
      endCap:eCaps[i] );
    this.polylinePoints.add(polylineDraw);
    }
    return this.polylinePoints;
  }

  Future<void> _goToPOS(CameraPosition camPos) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(camPos));
  }

  getPlaceWithCoords(double lat, double lng)async
  {
    List<Placemark> coordPlace = await _geolocator.placemarkFromCoordinates(
        lat, lng);
    return coordPlace;
  }

  getPlaceWithAddress(String address)async
  {
     List<Placemark> addressPlacemark =
          await _geolocator.placemarkFromAddress(address);
    return addressPlacemark;
  }

  setRoutCoords(double oLat,double oLng,
   double dLat, double dLng,
   RouteMode routeMode) async
  {
        routeCoords = await googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(oLat,oLng),
         destination: LatLng(dLat,dLng),
          mode: routeMode);    

    return routeCoords;
  }

}