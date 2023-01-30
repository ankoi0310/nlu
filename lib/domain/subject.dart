class Subject {
  String id_to_hoc;
  String id_mon;
  String ma_mon;
  String ten_mon;
  String so_tc;
  double so_tc_so;
  bool is_vuot;
  String nhom_to;
  String lop;
  List<String> ds_lop;
  bool is_kdk;
  int sl_dk; // số lượng đăng ký
  int sl_cp; // số lượng cho phép
  int sl_cl; // số lượng còn lại
  String tkb; // thời khóa biểu (thứ, tiết, giáo viên, thời gian)
  bool is_hl;
  bool enable;
  bool hauk;
  bool is_dk;
  bool is_rot;
  bool is_ctdt;
  bool is_chctdt;
  bool is_kg_lt;
  int thu; // thứ
  int tbd; // tiết bắt đầu
  int so_tiet; // số tiết
  String tu_gio;
  String den_gio;
  String phong;
  String gv;
  String gc_to_hoc;

  Subject({
    required this.id_to_hoc,
    required this.id_mon,
    required this.ma_mon,
    required this.ten_mon,
    required this.so_tc,
    required this.so_tc_so,
    required this.is_vuot,
    required this.nhom_to,
    required this.lop,
    required this.ds_lop,
    required this.is_kdk,
    required this.sl_dk,
    required this.sl_cp,
    required this.sl_cl,
    required this.tkb,
    required this.is_hl,
    required this.enable,
    required this.hauk,
    required this.is_dk,
    required this.is_rot,
    required this.is_ctdt,
    required this.is_chctdt,
    required this.is_kg_lt,
    required this.thu,
    required this.tbd,
    required this.so_tiet,
    required this.tu_gio,
    required this.den_gio,
    required this.phong,
    required this.gv,
    required this.gc_to_hoc,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id_to_hoc: json['id_to_hoc'],
      id_mon: json['id_mon'],
      ma_mon: json['ma_mon'],
      ten_mon: json['ten_mon'],
      so_tc: json['so_tc'],
      so_tc_so: json['so_tc_so'],
      is_vuot: json['is_vuot'],
      nhom_to: json['nhom_to'],
      lop: json['lop'],
      ds_lop: List<String>.from(json['ds_lop'].map((x) => x)),
      is_kdk: json['is_kdk'],
      sl_dk: json['sl_dk'],
      sl_cp: json['sl_cp'],
      sl_cl: json['sl_cl'],
      tkb: json['tkb'],
      is_hl: json['is_hl'],
      enable: json['enable'],
      hauk: json['hauk'],
      is_dk: json['is_dk'],
      is_rot: json['is_rot'],
      is_ctdt: json['is_ctdt'],
      is_chctdt: json['is_chctdt'],
      is_kg_lt: json['is_kg_lt'],
      thu: json['thu'],
      tbd: json['tbd'],
      so_tiet: json['so_tiet'],
      tu_gio: json['tu_gio'],
      den_gio: json['den_gio'],
      phong: json['phong'],
      gv: json['gv'],
      gc_to_hoc: json['gc_to_hoc'],
    );
  }
}
