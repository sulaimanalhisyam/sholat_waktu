import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sholt_waktu_app/model/ResponseWaktu.dart';
import 'package:sholt_waktu_app/style_text.dart';

class ListJadwal extends StatelessWidget {
  ResponseWaktu data;

  ListJadwal(this.data);

  Widget containerWaktu(String waktu, String jam) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        height: 70.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 4.0)],
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xfffc00ff), Color(0xff00dbde)])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(jam, style: styleListText),
            Text(waktu, style: styleListText)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        containerWaktu(data.results.datetime[0].times.Fajr, 'Imsak'),
        containerWaktu(data.results.datetime[0].times.Fajr, 'Subuh'),
        containerWaktu(data.results.datetime[0].times.Dhuhr, 'Zuhur'),
        containerWaktu(data.results.datetime[0].times.Asr, 'Asar'),
        containerWaktu(data.results.datetime[0].times.Maghrib, 'Maghrib'),
        containerWaktu(data.results.datetime[0].times.Isha, 'Isya'),
      ],
    );
  }
}
