class LaporanModel {
  int? id;
  String jenisProduk;
  String? foto;
  String? filePath;
  String tanggal;

  LaporanModel({
    this.id,
    required this.jenisProduk,
    this.foto,
    this.filePath,
    required this.tanggal,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jenis_produk': jenisProduk,
      'foto': foto,
      'file_path': filePath,
      'tanggal': tanggal,
    };
  }

  factory LaporanModel.fromMap(Map<String, dynamic> map) {
    return LaporanModel(
      id: map['id'],
      jenisProduk: map['jenis_produk'],
      foto: map['foto'],
      filePath: map['file_path'],
      tanggal: map['tanggal'],
    );
  }
}
