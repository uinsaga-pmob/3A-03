class EmployeeModel {
  int? id;
  String nama;
  String jabatan;
  int gaji;

  EmployeeModel({
    this.id,
    required this.nama,
    required this.jabatan,
    required this.gaji,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'nama': nama, 'jabatan': jabatan, 'gaji': gaji};
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(
      id: map['id'],
      nama: map['nama'] ?? '',
      jabatan: map['jabatan'] ?? '',
      // Menggunakan int.tryParse atau casting aman untuk jaga-jaga jika data di DB berupa string/null
      gaji: map['gaji'] is int
          ? map['gaji']
          : (int.tryParse(map['gaji'].toString()) ?? 0),
    );
  }
}
