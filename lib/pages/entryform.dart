import 'package:flutter/material.dart';
import '../models/datarawatjalan.dart';

class EntryForm extends StatefulWidget {
  final RawatJalan data;
  EntryForm(this.data);
  @override
  EntryFormState createState() => EntryFormState(this.data);
}

//class controller
class EntryFormState extends State<EntryForm> {
  RawatJalan data;
  EntryFormState(this.data);
  TextEditingController suratController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController diagnosisController = TextEditingController();
  TextEditingController poliController = TextEditingController();
  @override
  Widget build(BuildContext context) {
//kondisi
    if (data != null) {
      suratController.text = data.nosurat.toString();
      namaController.text = data.nama;
      diagnosisController.text = data.diagnosis;
      poliController.text = data.poli;
    }
//rubah
    return Scaffold(
        appBar: AppBar(
          title: data == null ? Text('Tambah') : Text('Ubah'),
          leading: Icon(Icons.keyboard_arrow_left),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
// nama
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: suratController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'No Surat',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),
// harga
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: namaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: diagnosisController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Diagnosis',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: poliController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Poli',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),
// tombol button
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
// tombol simpan
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (data == null) {
// tambah data
                            data = RawatJalan(
                                int.parse(suratController.text),
                                namaController.text,
                                diagnosisController.text,
                                poliController.text);
                          } else {
// ubah data
                            data.nosurat = int.parse(suratController.text);
                            data.nama = namaController.text;
                            data.diagnosis = diagnosisController.text;
                            data.poli = poliController.text;
                          }
// kembali ke layar sebelumnya dengan membawa objek item
                          Navigator.pop(context, data);
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
// tombol batal
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
