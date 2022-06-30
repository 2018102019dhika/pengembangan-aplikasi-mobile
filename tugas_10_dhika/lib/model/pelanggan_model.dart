class PelangganModel {
  int? idPelanggan;
  String? namaPelanggan;
  String? alamatPelanggan;
  String? teleponPelanggan;
  String? emailPelanggan;

  pelangganMap() {
    var mapping = <String, dynamic>{};
    mapping['id_pelanggan'] = idPelanggan;
    mapping['nama_pelanggan'] = namaPelanggan!;
    mapping['alamat'] = alamatPelanggan!;
    mapping['telepon'] = teleponPelanggan!;
    mapping['email'] = emailPelanggan!;
    return mapping;
  }
}
