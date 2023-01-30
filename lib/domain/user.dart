class User {
  String ma_sv;
  String ten_day_du;
  String gioi_tinh;
  String ngay_sinh;
  String noi_sinh;
  String dan_toc;
  String email;
  String lop;
  String nganh;
  String chuyen_nganh;
  String khoa;
  String bac_he_dao_tao;
  String nien_khoa;
  String hien_dien_sv;

  User({
    required this.ma_sv,
    required this.ten_day_du,
    required this.gioi_tinh,
    required this.ngay_sinh,
    required this.noi_sinh,
    required this.dan_toc,
    required this.email,
    required this.lop,
    required this.nganh,
    required this.chuyen_nganh,
    required this.khoa,
    required this.bac_he_dao_tao,
    required this.nien_khoa,
    required this.hien_dien_sv,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      ma_sv: json['ma_sv'],
      ten_day_du: json['ten_day_du'],
      gioi_tinh: json['gioi_tinh'],
      ngay_sinh: json['ngay_sinh'],
      noi_sinh: json['noi_sinh'],
      dan_toc: json['dan_toc'],
      email: json['email'],
      lop: json['lop'],
      nganh: json['nganh'],
      chuyen_nganh: json['chuyen_nganh'],
      khoa: json['khoa'],
      bac_he_dao_tao: json['bac_he_dao_tao'],
      nien_khoa: json['nien_khoa'],
      hien_dien_sv: json['hien_dien_sv'],
    );
  }
}
