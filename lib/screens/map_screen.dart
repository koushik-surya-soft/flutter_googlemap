import 'package:flutter/material.dart';
// import 'dart:async';
import 'dart:html';
import 'package:google_maps/google_maps.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:ui' as ui;

class GoMap extends StatefulWidget {
  @override
  _GoMapState createState() => _GoMapState();
}

class _GoMapState extends State<GoMap> {
  // Completer<GoogleMapController> _controller = Completer();

  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );

  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maps Implementation',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            height: 400.0,
            width: 800.0,
            child: GetMap(),
            // GoogleMap(
            //   mapType: MapType.hybrid,
            //   initialCameraPosition: _kGooglePlex,
            //   onMapCreated: (GoogleMapController controller) {
            //     _controller.complete(controller);
            //   },
            // ),
          ),
        ),
      ),
    );
  }
}

class GetMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String htmlId = "7";

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      // final myLatlng = LatLng(12.919663, 77.575819);
      // final b = LatLng(12.948183335341936, 77.57991767949433);
      // final c = LatLng(12.970457, 77.537143);
      // final d = LatLng(12.917106, 77.520504);

      final mapOptions = MapOptions()
        ..zoom = 13
        ..center = LatLng(12.919663, 77.575819);

      final elem = DivElement()
        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = 'none';

      final map = GMap(elem, mapOptions);

      // final route = [myLatlng, b, c, d];

      Polyline poly = Polyline(PolylineOptions()
        ..geodesic = true
        ..strokeColor = "#FF0000"
        ..strokeOpacity = 1.0
        ..strokeWeight = 2)
        ..map = map;

      void addMarker(MapMouseEvent e) {
        poly.path..push(e.latLng);
        Marker(MarkerOptions()
          ..position = e.latLng
          ..map = map
          ..title = 'Hello World!'
          ..draggable = true);
      }

      map.onClick.listen(addMarker);

      // addMarker(myLatlng);
      // addMarker(b);
      // addMarker(c);
      // addMarker(d);
      // polyline.set('hello world', map);

      // Marker(MarkerOptions()
      //   ..position = myLatlng
      //   ..map = map
      //   ..title = 'Hello World!');

      return elem;
    });

    return HtmlElementView(viewType: htmlId);
  }
}
