import 'package:nlu/domain/subject.dart';

class Schedule {
  int total_items;
  int total_pages;
  bool trong_thoi_gian_dang_ky;
  bool trong_thoi_gian_duyet_kqdk;
  bool hien_cot_tach_phieu_nop_tien;
  bool addin_duyet_kqdk;
  bool hien_cot_hoc_phi;
  bool hien_cot_ma_lop;
  bool hien_thi_cot_lich_thi;
  String message_tietbd;
  bool is_show_tietbd;
  String message_so_tiet;
  List<Subject> ds_nhom_to;

  Schedule({
    required this.total_items,
    required this.total_pages,
    required this.trong_thoi_gian_dang_ky,
    required this.trong_thoi_gian_duyet_kqdk,
    required this.hien_cot_tach_phieu_nop_tien,
    required this.addin_duyet_kqdk,
    required this.hien_cot_hoc_phi,
    required this.hien_cot_ma_lop,
    required this.hien_thi_cot_lich_thi,
    required this.message_tietbd,
    required this.is_show_tietbd,
    required this.message_so_tiet,
    required this.ds_nhom_to,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      total_items: json['total_items'],
      total_pages: json['total_pages'],
      trong_thoi_gian_dang_ky: json['trong_thoi_gian_dang_ky'],
      trong_thoi_gian_duyet_kqdk: json['trong_thoi_gian_duyet_kqdk'],
      hien_cot_tach_phieu_nop_tien: json['hien_cot_tach_phieu_nop_tien'],
      addin_duyet_kqdk: json['addin_duyet_kqdk'],
      hien_cot_hoc_phi: json['hien_cot_hoc_phi'],
      hien_cot_ma_lop: json['hien_cot_ma_lop'],
      hien_thi_cot_lich_thi: json['hien_thi_cot_lich_thi'],
      message_tietbd: json['message_tietbd'],
      is_show_tietbd: json['is_show_tietbd'],
      message_so_tiet: json['message_so_tiet'],
      ds_nhom_to: List<Subject>.from(json['ds_nhom_to'].map((x) => Subject.fromJson(x))),
    );
  }
}
