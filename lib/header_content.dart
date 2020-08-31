import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sholt_waktu_app/model/ResponseWaktu.dart';
import 'package:sholt_waktu_app/style_text.dart';

class HeaderContent extends StatelessWidget {
  ResponseWaktu responseWaktu;

  HeaderContent(this.responseWaktu);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 30.0,
      bottom: 30.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            responseWaktu.results.location.city,
            style: styleCityHeader,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.location_on,
                color: Colors.white,
                size: 30.0,
              ),
              Text(
                responseWaktu.results.location.country,
                style: styleAddresHeader,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              )
            ],
          )
        ],
      ),
    );
  }
}
