import 'package:geolocator/geolocator.dart';

class GeolocatorApp{

  static Future<String> getCurrentPosition() async {

    Map<String, double> result = await getCurrentPositionLatLong();

    if ( result == null ) return 'no_geo_permission';

    return '${result['latitude'].toString()}/${result['longitude'].toString()}';
  }

  static Future<Map<String, double>> getCurrentPositionLatLong() async {

    GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();

    if ( geolocationStatus == null ) return null;

    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    double latitude = position.latitude;
    double longitude = position.longitude;

    return <String, double>{
      'latitude': latitude,
      'longitude': longitude,
    };
  }

}