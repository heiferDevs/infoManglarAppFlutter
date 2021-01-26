import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapLeaflet extends StatelessWidget{

  final double lat;
  final double long;
  final double zoom;

  MapLeaflet({
    this.lat,
    this.long,
    this.zoom = 7.0,
  });

  Widget build(BuildContext context) {
    return new FlutterMap(
      options: new MapOptions(
        center: new LatLng(lat, long),
        zoom: zoom,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken': 'pk.eyJ1Ijoic2N1ZW5jYSIsImEiOiJjazFmOXpmaXAwanhiM25sYjJ3Z21kcWF6In0.buUj2rV6sKoi8PdKfelkdA',
            'id': 'mapbox.streets',
          },
        ),
        new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 100.0,
              height: 100.0,
              point: new LatLng(lat, long),
              builder: (ctx) =>
              new Container(
                child: Icon(Icons.pin_drop),
              ),
            ),
          ],
        ),
      ],
    );
  }

}