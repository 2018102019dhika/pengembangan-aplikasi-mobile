import 'package:tugas_10_dhika/model/pelanggan_model.dart';
import 'package:tugas_10_dhika/services/pelanggan_service.dart';
import 'package:flutter/material.dart';

class AddPelanggan extends StatefulWidget {
  const AddPelanggan({Key? key}) : super(key: key);

  @override
  State<AddPelanggan> createState() => _AddPelangganState();
}

class _AddPelangganState extends State<AddPelanggan> {
  final _pelangganNamaController = TextEditingController();
  final _pelangganAlamatController = TextEditingController();
  final _pelangganTeleponController = TextEditingController();
  final _pelangganEmailController = TextEditingController();
  bool _validateNamaPelanggan = false;
  bool _validateAlamatPelanggan = false;
  bool _validateTeleponPelanggan = false;
  bool _validateEmailPelanggan = false;
  final _pelangganService = PelangganService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pelanggan"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tambah Data Pelanggan Baru',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _pelangganNamaController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Masukan Nama Pelanggan',
                    labelText: 'Nama Pelanggan',
                    errorText: _validateNamaPelanggan
                        ? 'Name Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _pelangganAlamatController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Masukan Alamat Pelanggan',
                    labelText: 'Alamat Pelanggan',
                    errorText: _validateAlamatPelanggan
                        ? 'Contact Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _pelangganTeleponController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Masukan Nomor Telepon Pelanggan',
                    labelText: 'Nomor Telepon',
                    errorText: _validateTeleponPelanggan
                        ? 'Description Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _pelangganEmailController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Masukan Email Pelanggan',
                    labelText: 'Email',
                    errorText: _validateEmailPelanggan
                        ? 'Description Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          _pelangganNamaController.text.isEmpty
                              ? _validateNamaPelanggan = true
                              : _validateNamaPelanggan = false;
                          _pelangganAlamatController.text.isEmpty
                              ? _validateAlamatPelanggan = true
                              : _validateAlamatPelanggan = false;
                          _pelangganTeleponController.text.isEmpty
                              ? _validateTeleponPelanggan = true
                              : _validateTeleponPelanggan = false;
                          _pelangganEmailController.text.isEmpty
                              ? _validateEmailPelanggan = true
                              : _validateEmailPelanggan = false;
                        });
                        if (_validateNamaPelanggan == false &&
                            _validateAlamatPelanggan == false &&
                            _validateTeleponPelanggan == false &&
                            _validateEmailPelanggan == false) {
                          // print("Good Data Can Save");
                          var _pelanggan = PelangganModel();
                          _pelanggan.namaPelanggan =
                              _pelangganNamaController.text;
                          _pelanggan.alamatPelanggan =
                              _pelangganAlamatController.text;
                          _pelanggan.teleponPelanggan =
                              _pelangganTeleponController.text;
                          _pelanggan.emailPelanggan =
                              _pelangganEmailController.text;
                          var result =
                              await _pelangganService.savePelanggan(_pelanggan);
                          Navigator.pop(context, result);
                        }
                      },
                      child: const Text('Save Data')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.orange,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        _pelangganNamaController.text = '';
                        _pelangganAlamatController.text = '';
                        _pelangganTeleponController.text = '';
                        _pelangganEmailController.text = '';
                      },
                      child: const Text('Clear Data'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
