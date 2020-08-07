import 'package:geolocator/geolocator.dart';
import 'package:transpporter_app_test/interfaces/mapsInterface.dart';
class trips implements MapInterfaces{
  trips({
    this.id,
    this.startPointLat,
    this.startPointLng,
    this.endPointLat,
    this.endPointLng,
    this.routeLength,
    this.price,
    this.tripTime,
    this.driverId,
    this.tripText
  }) {


  }

  final int id;
  String tripText;
  final double startPointLat;
  final double startPointLng;
  final double endPointLat;
  final double endPointLng;
  final double routeLength;
  final double price;
  final DateTime tripTime;
  final int driverId;
  final Geolocator _geolocator = Geolocator();
      Position _currentPosition ;
  
 
 getAddress() async
  {

    List<Placemark> startAddress = await _geolocator.placemarkFromCoordinates(
            startPointLat, startPointLng);
    List<Placemark> endAddress = await _geolocator.placemarkFromCoordinates(
            endPointLat, endPointLng);

    Placemark startPlace = startAddress[0];
    Placemark endPlace = endAddress[0];        

    String startAddressText =
              "${startPlace.locality}"+"," +"${startPlace.subLocality}";
        
    String endAddressText =
              "${endPlace.locality}"+"," +"${startPlace.subLocality}";
      
  this.tripText = startAddressText + " -> " + endAddressText;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'driverId': driverId,
      'startPointLat': startPointLat,
      'startPointLng': startPointLng,
      'endPointLat': endPointLat,
      'endPointLng': endPointLng,
      'tripText':tripText,
      'routeLength': routeLength,
      'tripTime':tripTime,
      'price':price,
    };
  }
}