// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'package:engeselt_teste/app/models/local_model.dart';
import 'package:engeselt_teste/app/pages/home/components/form_bottom_sheet_modal.dart';
import 'package:engeselt_teste/app/pages/local_details/local_details.dart';
import 'package:engeselt_teste/app/pages/saved_locals/saved_locals_page.dart';
import 'package:engeselt_teste/app/store/local_store.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController mapController;
  LatLng? _center;
  Future<void> getCurrentLocation() async {
    final locData = await Location().getLocation();
    _center = LatLng(locData.latitude!, locData.longitude!);
    setState(() {});
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  LocalStore localStore = LocalStore();

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text('Pontos de interesse'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SavedLocals(localStore: localStore)));
              },
              icon: Icon(Icons.map))
        ],
      ),
      body: _center == null
          ? Center(child: Text('Carregando'))
          : ValueListenableBuilder<Set<Marker>>(
              valueListenable: localStore.markers,
              builder: (context, markers, child) {
                return GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition:
                        CameraPosition(zoom: 11, target: _center!),
                    markers: markers);
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext contex) {
                return FormBottomSheet(localStore: localStore);
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
