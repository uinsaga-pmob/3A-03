class EmployeeModel {
  int? id;
  String nama;
  String jabatan;
  int gaji;
  String tanggalLahir;
  String alamat;

  EmployeeModel({
    this.id,
    required this.nama,
    required this.jabatan,
    required this.gaji,
    required this.tanggalLahir,
    required this.alamat,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'jabatan': jabatan,
      'gaji': gaji,
      'tanggal_lahir': tanggalLahir,
      'alamat': alamat,
    };
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(
      id: map['id'],
      nama: map['nama'] ?? '',
      jabatan: map['jabatan'] ?? '',
      gaji: map['gaji'] is int
          ? map['gaji']
          : (int.tryParse(map['gaji'].toString()) ?? 0),

      tanggalLahir: map['tanggal_lahir'] ?? '',
      alamat: map['alamat'] ?? '',
    );
  }
}
