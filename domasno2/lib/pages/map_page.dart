import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final List<Marker> burgerStores;
  final void Function() toggleMap;

  const MapPage({
    super.key,
    required this.toggleMap,
    required this.burgerStores,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(41.99889343239384, 21.38969315735255);


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  get currentLocationMarker {
    return Marker(
        markerId: const MarkerId('my_location'),
        position: _center,
        infoWindow: const InfoWindow(title: 'Current location'));
  }

  @override
  Widget build(BuildContext context) {
    print(_center);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Map'),
          centerTitle: true,
          leading: IconButton(
            onPressed: widget.toggleMap,
            icon: const Icon(Icons.arrow_back),
          )),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: {currentLocationMarker, ...widget.burgerStores},
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 14.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
