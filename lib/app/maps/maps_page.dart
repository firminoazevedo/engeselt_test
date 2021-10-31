import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late GoogleMapController mapController;
  bool showAppBar = false;

  LatLng? position;
  void selectPosition(LatLng pos) {
    print('54545');
    position = pos;
    print(position);
    showAppBar = true;
    setState(() {});
  }

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: Text('Local selecionado'),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop(position);
                    },
                    icon: Icon(Icons.check))
              ],
            )
          : null,
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        onTap: selectPosition,
        initialCameraPosition: CameraPosition(zoom: 11, target: _center),
        markers: position == null
            ? Set()
            : {
                Marker(
                  position: position!,
                  markerId: MarkerId('p1'),
                )
              }.toSet(),
      ),
    );
  }
}
