class Wood {
  int? id;
  String namaKayu;
  String kategori;
  int stok;

  Wood({
    this.id,
    required this.namaKayu,
    required this.kategori,
    required this.stok,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'namakayu': namaKayu, 'kategori': kategori, 'stok': stok};
  }

  factory Wood.fromMap(Map<String, dynamic> map) {
    return Wood(
      id: map['id'],
      namaKayu: map['namakayu'],
      kategori: map['kategori'],
      stok: map['stok'],
    );
  }
}
