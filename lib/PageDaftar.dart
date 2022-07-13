import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mysat/PageLogin.dart';
import 'package:mysat/PageUtama.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'PageLogin.dart';
// ignore_for_file: prefer_const_constructors
class PageDaftar extends StatefulWidget {
  // final Kontak? kontak;

  @override
  _PageDaftarState createState() => _PageDaftarState();
}

class _PageDaftarState extends State<PageDaftar> {
  bool _validateNik = false;
  bool _validateNama = false;
  bool _validateAlamat = false;
  bool _validateEmail = false;
  bool _validatePassword = false;
  bool _validateUlang = false;

  void hapusValid() {
  _validateNik = false;
  _validateNama = false;
  _validateAlamat = false;
  _validateEmail = false;
  _validatePassword = false;
  _validateUlang = false;  
  }
  //nama textfield
  TextEditingController nik = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordulang = TextEditingController();
  Future<void> insertrecord() async {
  if( password.text == passwordulang.text){
    if (nik.text !='' && 
        nama.text !='' && 
        alamat.text !='' && 
        email.text !='' && 
        password.text !='' && 
        passwordulang.text !='') {
      try {
        String uri = "http://satpolpp.bukacode.com/sat-daftar.php";
        var res = await http.post(Uri.parse(uri), body: {
          "nama": nama.text,
          "email": email.text,
          "nik": nik.text,
          "alamat": alamat.text,
          "password": password.text,
        });
        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          //print("Berhasil di simpan");
          //save session;

          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setString("nik", nik.text);
          await pref.setString("nama", nama.text);
          await pref.setString("alamat", alamat.text);
          await pref.setString("email", email.text);
          await pref.setString("password", password.text);
          await pref.setString("passwordulang", passwordulang.text);
          await pref.setBool("is_login", true);


          setState(() {
            Alert(
                context: context,
                title: "Berhasil",
                desc: "Anda berhasil mendaftar",
                type: AlertType.success,
                buttons: [
                  DialogButton(
                      child: Text(
                        "Ok",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                    Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>  PageUtama(),
                          ),
                          (route) => false,
                        );
                      })
                ]).show();
          });
        } else {
          setState(() {
            Alert(
                context: context,
                title: "Error",
                desc: "Ada Kesalahan",
                type: AlertType.success,
                buttons: [
                ]).show();
          });
        }
      } catch (e) {
        print(e);
      }
    } else {
            Alert(
                context: context,
                title: "Error",
                desc: "Ada Kesalahan",
                type: AlertType.success,).show();
    }
    } else {
            Alert(
                context: context,
                title: "Error",
                desc: "Password harus sama degan Ulang Password",
                type: AlertType.success,).show();
    }
 }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login2.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 80),
            child: const Text(
              "Welcome\nBack",
              style: TextStyle(color: Colors.white, fontSize: 33),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height * 0.3),
              child: Column(children: [
                TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'NIK',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorText: _validateNik ? 'Nik tidak boleh kosong' : null,
                  ),
                  controller: nik,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Nama Lengkap',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorText: _validateNama ? 'Nama tidak boleh kosong' : null,
                  ),
                  controller: nama,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Alamat',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorText: _validateAlamat ? 'Alamat tidak boleh kosong' : null,
                  ),
                  controller: alamat,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorText: _validateEmail ? 'Email tidak boleh kosong' : null,
                  ),
                  controller: email,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorText: _validatePassword ? 'Password tidak boleh kosong' : null,
                  ),
                  controller: password,
                  
                ),
                const SizedBox(
                  height: 40,
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Ulangi Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorText: _validateUlang ? 'Ulangi Password tidak boleh kosong' : null,
                  ),
                  controller: passwordulang,
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Daftar',
                      style: TextStyle(
                        color: Color(0xff4c505b),
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xff4c505b),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                        hapusValid();
                        setState(() {
                        if(nik.text.isEmpty){  _validateNik = true ;}
                        if(nama.text.isEmpty){  _validateNama = true ;}
                        if(alamat.text.isEmpty){  _validateAlamat = true ;}
                        if(email.text.isEmpty){  _validateEmail= true ;}
                        if(password.text.isEmpty){  _validatePassword = true ;}
                        if(passwordulang.text.isEmpty){  _validateUlang = true ;}

                        if(nik.text !='' && 
                          nama.text !='' && 
                          alamat.text !='' && 
                          email.text !='' && 
                          password.text !='' && 
                          passwordulang.text !=''){
                          //print("semua benar");
                          insertrecord();
                        }
                        });                   
                        },
                        icon: const Icon(Icons.arrow_forward),
                    ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PageLogin()),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            color: Color(0xff4c505b),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            color: Color(0xff4c505b),
                          ),
                        ),
                      ),
                    ]),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
