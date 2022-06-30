import 'package:tugas_10_dhika/db_helper/repository.dart';
import 'package:tugas_10_dhika/model/pelanggan_model.dart';

class PelangganService {
  late Repository _repository;
  PelangganService() {
    _repository = Repository();
  }

  // Simpan Data pelanggan
  savePelanggan(PelangganModel pelanggan) async {
    return await _repository.insertData(
        'tbl_pelanggan', pelanggan.pelangganMap());
  }

  // Baca Semua Data Pelanggan
  readAllDataPelanggan() async {
    return await _repository.readData('tbl_pelanggan');
  }

  // Edit Data Pelanggan
  updatePelanggan(PelangganModel pelanggan) async {
    return await _repository.updateData(
        'tbl_pelanggan', pelanggan.pelangganMap());
  }

  // Delete Data Pelanggan
  deletePelanggan(pelangganId) async {
    return await _repository.deleteDataById('tbl_pelanggan', pelangganId);
  }
}
