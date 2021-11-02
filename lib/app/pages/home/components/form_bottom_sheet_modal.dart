// ignore_for_file: prefer_const_constructors

import 'package:engeselt_teste/app/pages/home/components/add_photos_widget.dart';
import 'package:engeselt_teste/app/pages/home/components/custom_drop_down.dart';
import 'package:engeselt_teste/app/pages/home/components/custom_text_field_component.dart';
import 'package:engeselt_teste/app/pages/home/components/date_component.dart';
import 'package:engeselt_teste/app/pages/maps/maps_page.dart';
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
  TextEditingController textDescriptionEditingController =
      TextEditingController();
  TextEditingController textTypeEditingController = TextEditingController();
  TextEditingController textDataEditingController = TextEditingController();
  TextEditingController textObservationsEditingController =
      TextEditingController();

  String? _previewUrlImage;
  LatLng? _latLng;
  bool _isLoadingMap = false;
  List<String> imgsPath = [];

  Future<void> getCurrentLocation() async {
    _isLoadingMap = true;
    setState(() {});
    final locData = await Location().getLocation();
    _previewUrlImage = LocationUtils.generateLocationPreviewImage(
        locData.latitude, locData.longitude);
    _latLng = LatLng(locData.latitude!, locData.longitude!);
    _isLoadingMap = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
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

              // SELECIONAR LOCALIZAÇÃO
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
                          _isLoadingMap = true;
                          setState(() {});
                          _previewUrlImage =
                              LocationUtils.generateLocationPreviewImage(
                                  _latLng!.latitude, _latLng!.longitude);
                          _isLoadingMap = false;
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

            // MOSTRA MAPA ESTATICO
            _isLoadingMap
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : _previewUrlImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(85)),
                            child: Image.network(_previewUrlImage!)),
                      )
                    : Container(),
            SizedBox(
              height: 10,
            ),

            // FORMULARIO
            CustomTextField(
              hint: 'Descrição',
              icon: Icons.text_snippet,
              textEditingController: textDescriptionEditingController,
            ),
            SizedBox(
              height: 10,
            ),
            CustomDropDowm(
              textEditingController: textTypeEditingController,
            ),
            SizedBox(
              height: 10,
            ),
            DateComponent(
              hint: 'Data',
              icon: Icons.calendar_today,
              textEditingController: textDataEditingController,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: 'Observações',
              icon: Icons.text_snippet,
              textEditingController: textObservationsEditingController,
            ),
            SizedBox(
              height: 10,
            ),
            AddPhotosWidget(
              photos: imgsPath,
            ),
            SizedBox(
              height: 10,
            ),

            // BOTÃO ADICIONAR LOCAL
            ElevatedButton(
                style: ButtonStyle(alignment: Alignment.center),
                onPressed: () {
                  if (validation()) {
                    widget.localStore.addLocal(
                      type: textTypeEditingController.text,
                      description: textDescriptionEditingController.text,
                      data: textDataEditingController.text,
                      latLng: _latLng,
                      observations: textObservationsEditingController.text,
                      photos: imgsPath,
                    );
                    print('Validado');
                    Navigator.pop(context);
                  }
                  setState(() {});
                },
                child: Text('Adicionar Local'))
          ],
        ),
      ),
    );
  }

  bool validation() {
    return true;
    if (_latLng == null ||
        textDescriptionEditingController.text.length < 3 ||
        textDataEditingController.text.length < 3 ||
        textObservationsEditingController.text.length < 3) {
      return false;
    } else {
      return true;
    }
  }
}
