// ignore_for_file: prefer_const_constructors
import 'package:engeselt_teste/app/maps/maps_page.dart';
import 'package:engeselt_teste/app/models/local_model.dart';
import 'package:engeselt_teste/app/pages/home/components/custom_drop_down.dart';
import 'package:engeselt_teste/app/pages/home/components/form_bottom_sheet_modal.dart';
import 'package:engeselt_teste/app/pages/local_details/local_details.dart';
import 'package:engeselt_teste/app/store/local_store.dart';
import 'package:engeselt_teste/app/utils/location_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'components/custom_text_field_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocalStore localStore = LocalStore();

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
                  leading: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  locals[i].photos![0],
                                ))),
                        width: 50,
                        height: 50,
                        child: Text('IMG')),
                  ),
                  title: Text(locals[i].description!),
                  subtitle: Text(locals[i].observations!),
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
                return FormBottomSheet(localStore: localStore);
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
