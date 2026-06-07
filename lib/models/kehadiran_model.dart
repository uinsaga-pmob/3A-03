class KehadiranModel {
  int? id;
  String namaKaryawan;
  String status;
  String tanggal;
  String jamMasuk;

  KehadiranModel({
    this.id,
    required this.namaKaryawan,
    required this.status,
    required this.tanggal,
    required this.jamMasuk,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama_karyawan': namaKaryawan,
      'status': status,
      'tanggal': tanggal,
      'jam_masuk': jamMasuk,
    };
  }
}
