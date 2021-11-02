import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

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
    position = pos;
    showAppBar = true;
    setState(() {});
  }

  LatLng? _center;

  Future<void> getCurrentLocation() async {
    final locData = await Location().getLocation();
    _center = LatLng(locData.latitude!, locData.longitude!);
    setState(() {});
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
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
      body: _center == null
          ? Center(
              child: Text('Carregando'),
            )
          : GoogleMap(
              onMapCreated: _onMapCreated,
              onTap: selectPosition,
              initialCameraPosition: CameraPosition(zoom: 11, target: _center!),
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
