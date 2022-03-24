import 'home.dart';
import 'package:flutter/material.dart';
import 'mahasiswa.dart';
import 'database_helper.dart';

class InputMahasiswa extends StatefulWidget {
  const InputMahasiswa({Key key}) : super(key: key);

  @override
  _InputMahasiswaState createState() => _InputMahasiswaState();
}

class _InputMahasiswaState extends State<InputMahasiswa> {
  int selectedId;
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
                decoration: InputDecoration(
                  labelText: "Jenjang",
                ),
              ),
              TextFormField(
                controller: prodiController,
                decoration: InputDecoration(
                  labelText: "Prodi",
                ),
              ),
              SizedBox(height: 50,),
              ElevatedButton(onPressed: () async {
                await DatabaseHelper.instance.add(
                  Mahasiswa(
                    nama: namaController.text,
                    jenjang: jenjangController.text,
                    prodi: prodiController.text
                  ),
                );
                Navigator.pushAndRemoveUntil(
                  context, 
                  MaterialPageRoute(builder: (context) => Home()),
                  (Route<dynamic> route) => false,
                  );
                },
                child: Text("Simpan"),
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}