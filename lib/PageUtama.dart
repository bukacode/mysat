import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mysat/PagePosition.dart';
import 'package:http/http.dart' as http;

//import 'PageLogin.dart';
// ignore_for_file: prefer_const_constructors
class PageUtama extends StatefulWidget {
  // final Kontak? kontak;

  @override
  _PageUtamaState createState() => _PageUtamaState();
}

class _PageUtamaState extends State<PageUtama> {
  Position? _currentPosition;
  late final String posisiokjos;

  void ambilData() {
    //data = MuridService().getMurid();
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        //String posisiokjos = "LAT: ${_currentPosition!.latitude}, LNG: ${_currentPosition!.longitude}";
      });
    }).catchError((e) {
      print(e);
    });
  }
  //initState adalah sebuah fungsi yang dibaca pertama kali
  void initState() {
    ambilData();
    super.initState();
  }

  Future<void> Kirimposisi() async {
    try {
      if (_currentPosition != null) ;
      String posisi =
          "${_currentPosition!.latitude}*${_currentPosition!.longitude}";
      String uri = "http://satpolpp.bukacode.com/sat-adddata.php";
      var res = await http.post(Uri.parse(uri), body: {"posisi": posisi});
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("record ok");
      } else {
        print("gagal");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*
            Text("LAT: ${_currentPosition!.latitude}, LNG: ${_currentPosition!.longitude}"),
           
            if (_currentPosition != null) 
            Text(
              "LAT: ${_currentPosition!.latitude}, LNG: ${_currentPosition!.longitude}"
            ),
            */

            ElevatedButton(
              child: Text("Cek"),
              onPressed: () {
                Kirimposisi();
              },
            ),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}
