import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:sholt_waktu_app/header_content.dart';
import 'package:sholt_waktu_app/list_jadwal.dart';
import 'package:sholt_waktu_app/model/ResponseWaktu.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHomeScreen(),
  ));
}

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  TextEditingController _locationController = TextEditingController();

  Future<ResponseWaktu> getJadwal({String location}) async {
    String url =
        'https://api.pray.zone/v2/times/today.json?city=${location}&school=9';
    final response = await http.get(url);
    final jsonResponse = json.decode(response.body);
    return ResponseWaktu.fromJsonMap(jsonResponse);
  }

  @override
  void initState() {
    if (_locationController.text.isEmpty || _locationController.text == null) {
      _locationController.text = 'bogor';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final header = Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.width - 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 6.0,
                    offset: Offset(0.0, 2.0),
                    color: Colors.black38)
              ],
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://media.suara.com/pictures/970x544/2017/06/24/25359-masjidil-haram-mekkah.jpg"))),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Tooltip(
                message: 'Ubah Lokasi',
                child: IconButton(
                    color: Colors.red,
                    icon: Icon(Icons.location_on),
                    onPressed: () {
                      _showDialogEditLocation(context);
                    }),
              ),
            ],
          ),
        ),
        FutureBuilder(
            future: getJadwal(
                location: _locationController.text.toLowerCase().toString()),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return HeaderContent(snapshot.data);
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Positioned.fill(
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Data Tidak Tersedia',
                          style: TextStyle(color: Colors.white),
                        )));
              }
              return Positioned.fill(
                  child: Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ));
            })
      ],
    );
    final body = Expanded(
        child: FutureBuilder(
            future: getJadwal(
                location: _locationController.text.toLowerCase().toString()),
            builder: (context, snaphot) {
              if (snaphot.hasData) {
                return ListJadwal(snaphot.data);
              } else if (snaphot.hasError) {
                print(snaphot.error);
                return Center(child: Text('Data Tidak Tersedia'));
              }
              return Center(child: CircularProgressIndicator());
            }));
    return Scaffold(
      body: Column(
        children: <Widget>[header, body],
      ),
    );
  }

  void _showDialogEditLocation(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ubah Lokasi'),
            content: TextField(
              controller: _locationController,
              decoration: InputDecoration(hintText: 'Lokasi'),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text('Batal', style: TextStyle(color: Colors.red)),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.pop(context, () {
                    setState(() {
                      getJadwal(
                          location: _locationController.text
                              .toLowerCase()
                              .toString());
                    });
                  });
                },
                child: new Text('OK', style: TextStyle(color: Colors.green)),
              ),
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
          );
        });
  }
}
