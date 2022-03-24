class Mahasiswa {
  final int id;
  final String nama;
  final String jenjang;
  final String prodi;
 
  Mahasiswa(
      {this.id,
      this.nama,
      this.jenjang,
      this.prodi});
 
  factory Mahasiswa.fromMap(Map<String, dynamic> json) => Mahasiswa(
        id: json['id'],
        nama: json['nama'],
        jenjang: json['jenjang'],
        prodi: json['prodi'],
      );
 
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'jenjang': jenjang,
      'prodi': prodi,
    };
  }
}
