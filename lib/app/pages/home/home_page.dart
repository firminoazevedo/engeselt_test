import 'package:engeselt_teste/app/maps/maps_page.dart';
import 'package:engeselt_teste/app/models/local_model.dart';
import 'package:engeselt_teste/app/pages/home/components/custom_drop_down.dart';
import 'package:engeselt_teste/app/pages/local_details/local_details.dart';
import 'package:engeselt_teste/app/store/local_store.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'components/custom_text_field_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LatLng? _latLng;
  TextEditingController textLatLangEditingController = TextEditingController();
  TextEditingController textDescriptionEditingController =
      TextEditingController();
  TextEditingController textTypeEditingController = TextEditingController();
  TextEditingController textDataEditingController = TextEditingController();
  TextEditingController textObservationsEditingController =
      TextEditingController();
  TextEditingController textPhotosEditingController = TextEditingController();
  late GoogleMapController mapController;
  LocalStore localStore = LocalStore();

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps Sample'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.list))],
      ),
      body: ValueListenableBuilder<List<LocalModel>>(
        valueListenable: localStore.locals,
        builder: (context, locals, child) {
          return ListView.builder(
            itemCount: locals.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LocalDetailsPage(
                                localModel: locals[i],
                              )));
                },
                child: ListTile(
                  title: Text(locals[i].type ?? 'Type'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext contex) {
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
                            Text('Localização atual'),
                            InkWell(
                                onTap: () async {
                                  _latLng = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (contex) => MapsPage()));
                                },
                                child: Text('Selecionar no mapa')),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hint: 'Descrição',
                        icon: Icons.text_format,
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
                        icon: Icons.local_activity,
                        textEditingController:
                            textObservationsEditingController,
                      ),
                      CustomTextField(
                          hint: 'Url photo',
                          icon: Icons.local_activity,
                          textEditingController: textPhotosEditingController),
                      ElevatedButton(
                          onPressed: () {
                            localStore.addLocal(
                              type: textTypeEditingController.text,
                              description:
                                  textDescriptionEditingController.text,
                              data: textDataEditingController.text,
                              latLang: textLatLangEditingController.text,
                              observations:
                                  textObservationsEditingController.text,
                              photos: [textPhotosEditingController.text],
                            );
                            setState(() {});
                          },
                          child: Text('Adicionar Local'))
                    ],
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
