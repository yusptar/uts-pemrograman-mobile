import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:uts/dbhelper/dbhelper.dart';
import 'entryform.dart';
import 'datarawatjalan.dart'; //pendukung program asinkron

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<RawatJalan> dataList;
  @override
  Widget build(BuildContext context) {
    if (dataList == null) {
      dataList = List<RawatJalan>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pasien Rawat Jalan'),
      ),
      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              child: Text("Tambah Data"),
              onPressed: () async {
                var rawatjalan = await navigateToEntryForm(context, null);
                if (rawatjalan != null) {
                  // Fungsi untuk Insert ke DB
                  int result = await dbHelper.insert(rawatjalan);
                  if (result > 0) {
                    updateListView();
                  }
                }
              },
            ),
          ),
        ),
      ]),
    );
  }

  Future<RawatJalan> navigateToEntryForm(
      BuildContext context, RawatJalan rawatjalan) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      //return EntryForm(rawatjalan);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.ad_units),
            ),
            title: Text(
              this.dataList[index].nama,
              style: textStyle,
            ),
            subtitle: Text(this.dataList[index].poli.toString()),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                deleteListItem(dataList[index]);
              },
            ),
            onTap: () async {
              var data =
                  await navigateToEntryForm(context, this.dataList[index]);
              //TODO 4 Panggil Fungsi untuk Edit data
              if (data != null) {
                int result = await dbHelper.update(data);
                if (result > 0) {
                  updateListView();
                }
              }
            },
          ),
        );
      },
    );
  }

// delete list item
  void deleteListItem(RawatJalan object) async {
    int result = await dbHelper.delete(object.id);
    if (result > 0) {
      updateListView();
    }
  }

//update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
//TODO 1 Select data dari DB
      Future<List<RawatJalan>> dataListFuture = dbHelper.getItemList();
      dataListFuture.then((dataList) {
        setState(() {
          this.dataList = dataList;
          this.count = dataList.length;
        });
      });
    });
  }
}
