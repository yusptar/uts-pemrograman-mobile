class RawatJalan {
  // deklarasi variable class RawatJalan
  int _id;
  int _nosurat;
  String _nama;
  String _diagnosis;
  String _poli;

  // Setters dan Getters variabel diatas
  int get id => _id;

  get nosurat => this._nosurat;
  set nosurat(value) => this._nosurat = value;

  String get nama => this._nama;
  set nama(String value) => this._nama = value;

  String get diagnosis => this._diagnosis;
  set diagnosis(String value) => this._diagnosis = value;

  String get poli => this._poli;
  set poli(String value) => this._poli = value;

// konstruktor versi 1
  RawatJalan(this._nosurat, this._nama, this._diagnosis, this._poli);

// konstruktor versi 2: konversi dari Map ke RawatJalan
  RawatJalan.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nosurat = map['nosurat'];
    this._nama = map['nama'];
    this._diagnosis = map['diagnosis'];
    this._poli = map['poli'];
  }

// konversi dari RawatJalan ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['nosurat'] = this._nosurat;
    map['nama'] = nama;
    map['diagnosis'] = diagnosis;
    map['poli'] = poli;
    return map;
  }
}
