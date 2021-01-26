import './zoombuttons_plugin_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'dart:math' as Math;

import '../constants.dart';

class GeoJsonPage extends StatefulWidget {

  final Map<String, dynamic> geojson;

  GeoJsonPage({
    @required this.geojson,
  });
  @override
  _GeoJsonPageState createState() => _GeoJsonPageState();
}

class _GeoJsonPageState extends State<GeoJsonPage> {

  MapController mapController;
  static const double GLOBE_WIDTH = 256; // a constant in Google's map projection
  static const double ZOOM_MAX = 21;
  Map<String, Polygon> _namedPolygons = {};
  double rotation = 0.0;
  LatLng center;
  double zoom;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    _namedPolygons = _getPolygonsNamed();
    center = _getCenter(_namedPolygons, true);
    zoom = _getZoom(_namedPolygons, true);
  }

  @override
  Widget build(BuildContext context) {

    final Widget _rotation = Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Text('Rotación:'),
          Expanded(
            child: Slider(
              value: rotation,
              min: 0.0,
              max: 360,
              onChanged: (degree) {
                setState(() {
                  rotation = degree;
                });
                mapController.rotate(degree);
              },
            ),
          )
        ],
      ),
    );

    final Widget _map = FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: center,
        zoom: zoom,
        plugins: [
          ZoomButtonsPlugin(),
        ],
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken': 'pk.eyJ1Ijoic2N1ZW5jYSIsImEiOiJjazFmOXpmaXAwanhiM25sYjJ3Z21kcWF6In0.buUj2rV6sKoi8PdKfelkdA',
            'id': 'mapbox.streets',
          },
          tileProvider: NonCachingNetworkTileProvider(), // WORKS ON WEB
          opacity: Constants.isWeb ? 0.7 : 1.0,
        ),
        PolygonLayerOptions(
          polygons: _namedPolygons.values.toList(),
        ),
        MarkerLayerOptions(
          markers: _markerFromPolygons(),
        ),
        ZoomButtonsPluginOption(
          minZoom: 4,
          maxZoom: 19,
          mini: true,
          padding: 10,
          alignment: Alignment.bottomRight,
        ),
      ],
    );

    return Container(
      child: Column(
        children: <Widget>[
          _rotation,
          Flexible( child: _map ),
        ],
      ),
    );

  }

  List<Marker> _markerFromPolygons(){
    List<Marker> results = [];
    _namedPolygons.forEach((String name, Polygon polygon){
      Map<String, dynamic> properties = _getProperties(name);
      results.add(Marker(
        point: _getCenter({name: polygon}, false),
        width: 80,
        height: 60,
        builder: (BuildContext context) => Container(
          padding: EdgeInsets.only(top: 15),
          child: Column(
            children: <Widget>[
              Text(_getLabelName(name, properties), style: _getTextStyle(12)),
              Text(_getCountDetail(properties), style: _getTextStyle(10)),
            ],
          ),
        ),
      ));
    });
    return results;
  }

  _getTextStyle(double fontSize){
    return TextStyle(
      fontSize: fontSize,
      color: Colors.black,
      shadows: <Shadow>[
        Shadow(
          offset: Offset(0.3, 0.3),
          blurRadius: 4.0,
          color: Colors.white,
        ),
        Shadow(
          offset: Offset(-0.3, -0.3),
          blurRadius: 4.0,
          color: Colors.white,
        ),
      ],
    );
  }

  LatLng _getCenter(Map<String, Polygon> namedPolygons, ignoreLimits) {
    List<LatLng> nAs = _getNorthAndSouth(namedPolygons, ignoreLimits);
    LatLng nw = nAs.asMap()[0];
    LatLng so = nAs.asMap()[1];
    return new LatLng((nw.latitude + so.latitude)/2, (nw.longitude + so.longitude)/2);
  }

  List<LatLng> _getNorthAndSouth(Map<String, Polygon> namedPolygons, ignoreLimits){
    List<LatLng> points = [];
    namedPolygons.forEach((String name, Polygon polygon){
      if (!ignoreLimits || !_isLimit(_getProperties(name))){
        points.addAll(polygon.points);
      }
    });
    double latitudeNorth;
    double longitudeNorth;
    double latitudeSouth;
    double longitudeSouth;
    for (LatLng point in points) {
      if (latitudeNorth == null) {
        latitudeNorth = latitudeSouth = point.latitude;
        longitudeNorth = longitudeSouth = point.longitude;
      } else {
        if (point.latitude > latitudeNorth) {
          latitudeNorth = point.latitude;
        }
        if (point.latitude < latitudeSouth) {
          latitudeSouth = point.latitude;
        }
        if (point.longitude > longitudeNorth) {
          longitudeNorth = point.longitude;
        }
        if (point.longitude < longitudeSouth) {
          longitudeSouth = point.longitude;
        }
      }
    }
    LatLng northeast = new LatLng(latitudeNorth, longitudeNorth);
    LatLng southwest = new LatLng(latitudeSouth, longitudeSouth);
    return [northeast, southwest];
  }

  double _getZoom(Map<String, Polygon> namedPolygons, ignoreLimits) {
    List<LatLng> nAs = _getNorthAndSouth(namedPolygons, ignoreLimits);
    LatLng nw = nAs.asMap()[0];
    LatLng so = nAs.asMap()[1];
    return getBoundsZoomLevel(nw, so, 200, 200);
  }

  double getBoundsZoomLevel(LatLng northeast,LatLng southwest,
      double width, double height) {
    double latFraction = (latRad(northeast.latitude) - latRad(southwest.latitude)) / Math.pi;
    double lngDiff = northeast.longitude - southwest.longitude;
    double lngFraction = ((lngDiff < 0) ? (lngDiff + 360) : lngDiff) / 360;
    double latZoom = zoomF(height, GLOBE_WIDTH, latFraction);
    double lngZoom = zoomF(width, GLOBE_WIDTH, lngFraction);
    double zoom = Math.min(Math.min(latZoom, lngZoom), ZOOM_MAX);
    //return zoom.toInt();
    return zoom;
  }
  double latRad(double lat) {
    double sin = Math.sin(lat * Math.pi / 180);
    double radX2 = Math.log((1 + sin) / (1 - sin)) / 2;
    return Math.max(Math.min(radX2, Math.pi), -Math.pi) / 2;
  }

  double zoomF(double mapPx, double worldPx, double fraction) {
    final double ln2 = .693147180559945309417;
    return (Math.log(mapPx / worldPx / fraction) / ln2);
  }


  Color _getColor(Map<String, dynamic> properties, bool isBorder){
    if (_isLimit(properties)) {
      return Color.fromRGBO(255, 211, 0, isBorder ? 1 : 0.5);
    }
    double variation = 1.0;
    if (properties != null && properties['count'] != null && properties['max'] != null) {
      variation = properties['count'] / properties['max'];
    }
    // green r0 g255 b0
    // red r255 g0 b0
    int varia = (255.0 * variation).toInt(); // si 1 255 si 0 0
    return Color.fromRGBO(255 - varia, 0 + varia, 0, 1);
  }

  String _getCountDetail(Map<String, dynamic> properties){
    if (_isLimit(properties)) return '';
    if (properties != null && properties['detail'] != null) {
      return properties['detail'].toString();
    }
    return '';
  }

  String _getLabelName(name, Map<String, dynamic> properties){
    if (_isLimit(properties)) return '';
    return name;
  }

  _isLimit(Map<String, dynamic> properties) {
    return properties != null && properties['detail'] != null && properties['detail'] == 'limite';
  }

  Map<String, dynamic> _getProperties(String name){
    Map<String, dynamic> result;
    try{
      widget.geojson['features'].forEach((feature){
        Map<String, dynamic> properties = feature['properties'];
        if (properties['name'] == name) {
          result = properties;
        }
      });
    } catch(e) {
      print('NO PROPERTIES FOR $name');
    }
    return result;
  }

  Map<String, Polygon> _getPolygonsNamed(){
    Map<String, Polygon> result = {};
    try{
      widget.geojson['features'].forEach((feature){
        print('feautre $feature');
        Map<String, dynamic> geometry = feature['geometry'];
        Map<String, dynamic> properties = feature['properties'];

        String name = properties['name'];
        print('will fill polygon $name');
        if (name == null || geometry == null) {
          return;
        }
        if (geometry['type'] == 'Polygon') {
          List<LatLng> points = [];
          geometry['coordinates'][0].forEach( (coordinate) {
            double longitude = coordinate[0];
            double latitude = coordinate[1];
            points.add(LatLng(latitude, longitude));
          });
          result[name] = Polygon(
            points: points,
            color: _getColor(properties, false),
            borderStrokeWidth: Constants.isWeb ? 0.0 : 1.0, // CAUSE ERROR ON WEB
            borderColor: _getColor(properties, true),
          );
        }
        if (geometry['type'] == 'MultiPolygon') {
          List<LatLng> points = [];
          geometry['coordinates'][0][0].forEach( (coordinate) {
            double longitude = coordinate[0];
            double latitude = coordinate[1];
            points.add(LatLng(latitude, longitude));
          });
          result[name] = Polygon(
            points: points,
            color: _getColor(properties, false),
            borderStrokeWidth: Constants.isWeb ? 0.0 : 1.0, // CAUSE ERROR ON WEB
            borderColor: _getColor(properties, true),
          );
        }
      });
    } catch(e) {
      print('ERROR GET POLYGONS $e');
    }
    print('return $result');
    return result;
  }

  @override
  void dispose() {
    super.dispose();
  }

}
