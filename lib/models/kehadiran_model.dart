class KehadiranModel {
  int? id;
  int employeeId;
  String status;
  String tanggal;
  String jamMasuk;

  KehadiranModel({
    this.id,
    required this.employeeId,
    required this.status,
    required this.tanggal,
    required this.jamMasuk,
  });

  Map<String, dynamic> toMap() {
    return {
      'employee_id': employeeId,
      'status': status,
      'tanggal': tanggal,
      'jam_masuk': jamMasuk,
    };
  }

  factory KehadiranModel.fromMap(Map<String, dynamic> map) {
    return KehadiranModel(
      id: map['id'],
      employeeId: map['employee_id'],
      status: map['status'],
      tanggal: map['tanggal'],
      jamMasuk: map['jam_masuk'],
    );
  }
}
