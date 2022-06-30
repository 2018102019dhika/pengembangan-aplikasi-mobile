import 'package:flutter/material.dart';
import 'package:tugas_10_dhika/model/pelanggan_model.dart';
import 'package:tugas_10_dhika/services/pelanggan_service.dart';
import 'package:tugas_10_dhika/view/pelanggan/add_pelanggan.dart';
import 'package:tugas_10_dhika/view/pelanggan/edit_pelanggan.dart';
import 'package:tugas_10_dhika/view/pelanggan/view_pelanggan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD PELANGGAN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<PelangganModel> _pelangganList = <PelangganModel>[];
  final _pelangganService = PelangganService();

  getAllDataPelanggan() async {
    var pelangganData = await _pelangganService.readAllDataPelanggan();
    _pelangganList = <PelangganModel>[];
    pelangganData.forEach((pelanggan) {
      setState(() {
        var pelangganModel = PelangganModel();
        pelangganModel.idPelanggan = pelanggan['id_pelanggan'];
        pelangganModel.namaPelanggan = pelanggan['nama_pelanggan'];
        pelangganModel.alamatPelanggan = pelanggan['alamat'];
        pelangganModel.teleponPelanggan = pelanggan['telepon'];
        pelangganModel.emailPelanggan = pelanggan['email'];
        _pelangganList.add(pelangganModel);
      });
    });
  }

  @override
  void initState() {
    getAllDataPelanggan();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, pelangganId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Apakah anda yakin ingin hapus data ini ?',
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.red),
                  onPressed: () async {
                    var result =
                        await _pelangganService.deletePelanggan(pelangganId);
                    if (result != null) {
                      Navigator.pop(context);
                      getAllDataPelanggan();
                      _showSuccessSnackBar('Data Pelanggan Berhasil Dihapus');
                    }
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.orange),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD PELANGGAN"),
      ),
      body: ListView.builder(
          itemCount: _pelangganList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewPelanggan(
                                pelanggan: _pelangganList[index],
                              )));
                },
                leading: const Icon(Icons.person),
                title: Text(_pelangganList[index].namaPelanggan ?? ''),
                subtitle: Text(_pelangganList[index].alamatPelanggan ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditPelanggan(
                                        pelanggan: _pelangganList[index],
                                      ))).then((data) {
                            if (data != null) {
                              getAllDataPelanggan();
                              _showSuccessSnackBar(
                                  'Data Pelanggan Berhasil Diubah');
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.red,
                        )),
                    IconButton(
                        onPressed: () {
                          _deleteFormDialog(
                              context, _pelangganList[index].idPelanggan);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.orange,
                        ))
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddPelanggan()))
              .then((data) {
            if (data != null) {
              getAllDataPelanggan();
              _showSuccessSnackBar('Data Pelanggan Berhasil Disimpan');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
