class Post {
  final String id;
  final String ky_hieu;
  final bool is_hien_thi;
  final String tieu_de;
  final String tom_tat;
  final String noi_dung;
  final String video;
  final String hinh_dai_dien;
  final String ngay_dang_tin;
  final String nguoi_dang_tin;
  final String ngay_hieu_chinh;
  final int do_uu_tien;

  Post({
    required this.id,
    required this.ky_hieu,
    required this.is_hien_thi,
    required this.tieu_de,
    required this.tom_tat,
    required this.noi_dung,
    required this.video,
    required this.hinh_dai_dien,
    required this.ngay_dang_tin,
    required this.nguoi_dang_tin,
    required this.ngay_hieu_chinh,
    required this.do_uu_tien,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      ky_hieu: json['ky_hieu'],
      is_hien_thi: json['is_hien_thi'],
      tieu_de: json['tieu_de'],
      tom_tat: json['tom_tat'],
      noi_dung: json['noi_dung'],
      video: json['video'],
      hinh_dai_dien: json['hinh_dai_dien'],
      ngay_dang_tin: json['ngay_dang_tin'],
      nguoi_dang_tin: json['nguoi_dang_tin'],
      ngay_hieu_chinh: json['ngay_hieu_chinh'],
      do_uu_tien: json['do_uu_tien'],
    );
  }
}
