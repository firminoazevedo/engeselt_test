// ignore_for_file: prefer_const_constructors

import 'package:engeselt_teste/app/maps/maps_page.dart';
import 'package:engeselt_teste/app/pages/home/components/custom_drop_down.dart';
import 'package:engeselt_teste/app/pages/home/components/custom_text_field_component.dart';
import 'package:engeselt_teste/app/store/local_store.dart';
import 'package:engeselt_teste/app/utils/location_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class FormBottomSheet extends StatefulWidget {
  final LocalStore localStore;
  const FormBottomSheet({
    Key? key,
    required this.localStore,
  }) : super(key: key);

  @override
  _FormBottomSheetState createState() => _FormBottomSheetState();
}

class _FormBottomSheetState extends State<FormBottomSheet> {
  late GoogleMapController mapController;

  //Text controllers
  TextEditingController textLatLangEditingController = TextEditingController();
  TextEditingController textDescriptionEditingController =
      TextEditingController();
  TextEditingController textTypeEditingController = TextEditingController();
  TextEditingController textDataEditingController = TextEditingController();
  TextEditingController textObservationsEditingController =
      TextEditingController();
  TextEditingController textPhotosEditingController = TextEditingController();

  String? _previewUrlImage;
  LatLng? _latLng;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> getCurrentLocation() async {
    final locData = await Location().getLocation();
    _previewUrlImage = LocationUtils.generateLocationPreviewImage(
        locData.latitude, locData.longitude);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Text("Selecionar Localização"),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: getCurrentLocation,
                    child: Text('Localização atual')),
                InkWell(
                    onTap: () async {
                      _latLng = await Navigator.push(context,
                          MaterialPageRoute(builder: (contex) => MapsPage()));
                      if (_latLng != null) {
                        _previewUrlImage =
                            LocationUtils.generateLocationPreviewImage(
                                _latLng!.latitude, _latLng!.longitude);
                        setState(() {});
                      }
                    },
                    child: Text('Selecionar no mapa')),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _previewUrlImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(85)),
                      child: Image.network(_previewUrlImage!)),
                )
              : Container(),
          CustomTextField(
            hint: 'Descrição',
            icon: Icons.text_snippet,
            textEditingController: textDescriptionEditingController,
          ),
          CustomDropDowm(),
          CustomTextField(
            hint: 'Data',
            icon: Icons.calendar_today,
            textEditingController: textDataEditingController,
          ),
          CustomTextField(
            hint: 'Observações',
            icon: Icons.text_snippet,
            textEditingController: textObservationsEditingController,
          ),
          CustomTextField(
              hint: 'Url photo',
              icon: Icons.photo,
              textEditingController: textPhotosEditingController),
          ElevatedButton(
              style: ButtonStyle(alignment: Alignment.center),
              onPressed: () {
                widget.localStore.addLocal(
                  type: textTypeEditingController.text,
                  description: textDescriptionEditingController.text,
                  data: textDataEditingController.text,
                  latLang: textLatLangEditingController.text,
                  observations: textObservationsEditingController.text,
                  photos: [textPhotosEditingController.text],
                );
                setState(() {});
              },
              child: Text('Adicionar Local'))
        ],
      ),
    );
  }
}
