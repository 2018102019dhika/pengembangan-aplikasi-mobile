import 'package:tugas_10_dhika/model/pelanggan_model.dart';
import 'package:tugas_10_dhika/services/pelanggan_service.dart';
import 'package:flutter/material.dart';

class EditPelanggan extends StatefulWidget {
  final PelangganModel pelanggan;
  const EditPelanggan({Key? key, required this.pelanggan}) : super(key: key);

  @override
  State<EditPelanggan> createState() => _EditPelangganState();
}

class _EditPelangganState extends State<EditPelanggan> {
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
  void initState() {
    setState(() {
      _pelangganNamaController.text = widget.pelanggan.namaPelanggan ?? '';
      _pelangganAlamatController.text = widget.pelanggan.alamatPelanggan ?? '';
      _pelangganTeleponController.text =
          widget.pelanggan.teleponPelanggan ?? '';
      _pelangganEmailController.text = widget.pelanggan.emailPelanggan ?? '';
    });
    super.initState();
  }

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
                'Edit Data Pelanggan',
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
                        ? 'Nama Tidak Boleh Kosong'
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
                        ? 'Alamat Tidak Boleh Kosong'
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
                        ? 'Nomor Telepon Tidak Boleh Kosong'
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
                    labelText: 'Email Pelanggan',
                    errorText: _validateEmailPelanggan
                        ? 'Email Tidak Boleh Kosong'
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
                          _pelanggan.idPelanggan = widget.pelanggan.idPelanggan;
                          _pelanggan.namaPelanggan =
                              _pelangganNamaController.text;
                          _pelanggan.alamatPelanggan =
                              _pelangganAlamatController.text;
                          _pelanggan.teleponPelanggan =
                              _pelangganTeleponController.text;
                          _pelanggan.emailPelanggan =
                              _pelangganTeleponController.text;
                          var result = await _pelangganService
                              .updatePelanggan(_pelanggan);
                          Navigator.pop(context, result);
                        }
                      },
                      child: const Text('Update Data')),
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
