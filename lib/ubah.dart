import 'dart:ffi';

import 'package:flutter/material.dart';
import 'mahasiswa.dart';
import 'database_helper.dart';
import 'home.dart';

class UbahMahasiswa extends StatefulWidget {
  UbahMahasiswa({Key key, this.id, this.nama, this.jenjang, this.prodi}) : super(key: key);

  int id;
  String nama;
  String jenjang;
  String prodi;

  @override
  _UbahMahasiswaState createState() => _UbahMahasiswaState();
}

class _UbahMahasiswaState extends State<UbahMahasiswa> {
  @override
  Void initState() {
    super.initState();
    namaController.text = widget.nama;
    jenjangController.text = widget.jenjang;
    prodiController.text = widget.prodi;
  }

  final TextEditingController namaController = TextEditingController();
  final TextEditingController jenjangController = TextEditingController();
  final TextEditingController prodiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Database SQLite"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            children: [
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(
                  labelText: "Nama",
                ),
              ),
              TextFormField(
                controller: jenjangController,
                decoration: InputDecoration(labelText: "Jenjang"),
              ),
              TextFormField(
                controller: prodiController,
                decoration: InputDecoration(labelText: "Prodi"),
              ),
              SizedBox(height: 50,
              ),
              ElevatedButton(onPressed: () async {
                await DatabaseHelper.instance.update(
                  Mahasiswa(
                    id: widget.id,
                    nama: namaController.text,
                    jenjang: jenjangController.text,
                    prodi: prodiController.text
                  ),
                );
                Navigator.pushAndRemoveUntil(context, 
                MaterialPageRoute(builder: (context) => Home()),
                (Route<dynamic> route) => false,
                );
              },
              child: Text("Ubah"),
              ),
            ],
          )
        ),
      ),
    );
  }
}