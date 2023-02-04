import 'package:flutter/material.dart';
import 'package:nlu/provider/dkmh_provider.dart';
import 'package:nlu/screen/profile/components/info_tile.dart';
import 'package:provider/provider.dart';

import '../../components/custom_app_bar.dart';
import '../../config/size_config.dart';
import '../../domain/user.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isInit = true;
  User? user;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      user = Provider.of<DKMHProvider>(context).user;
      setState(() {
        _isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: getProportionateScreenHeight(20),
              ),
              child: const CustomAppBar(
                title: "Thông tin cá nhân",
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            _isInit
                ? const Center(child: CircularProgressIndicator())
                : Flexible(
                    fit: FlexFit.loose,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: getProportionateScreenWidth(20),
                              right: getProportionateScreenWidth(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(10)),
                                  child: Text(
                                    "Thông tin sinh viên",
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                        fontSize: getProportionateScreenWidth(22), fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).shadowColor.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      InfoTile(
                                        title: "Mã sinh viên",
                                        value: user!.ma_sv,
                                      ),
                                      SizedBox(height: getProportionateScreenHeight(15)),
                                      InfoTile(
                                        title: "Họ và tên",
                                        value: user!.ten_day_du,
                                      ),
                                      SizedBox(height: getProportionateScreenHeight(15)),
                                      InfoTile(
                                        title: "Ngày sinh",
                                        value: user!.ngay_sinh,
                                      ),
                                      SizedBox(height: getProportionateScreenHeight(15)),
                                      InfoTile(
                                        title: "Giới tính",
                                        value: user!.gioi_tinh,
                                      ),
                                      SizedBox(height: getProportionateScreenHeight(15)),
                                      InfoTile(
                                        title: "Email",
                                        value: user!.email,
                                      ),
                                      SizedBox(height: getProportionateScreenHeight(15)),
                                      InfoTile(
                                        title: "Nơi sinh",
                                        value: user!.noi_sinh,
                                      ),
                                      SizedBox(height: getProportionateScreenHeight(15)),
                                      InfoTile(
                                        title: "Dân tộc",
                                        value: user!.dan_toc,
                                      ),
                                      SizedBox(height: getProportionateScreenHeight(15)),
                                      InfoTile(
                                        title: "Hiện diện",
                                        value: user!.hien_dien_sv,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          Container(
                            margin: EdgeInsets.only(
                              left: getProportionateScreenWidth(20),
                              right: getProportionateScreenWidth(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(10)),
                                  child: Text(
                                    "Thông tin khoá học",
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                        fontSize: getProportionateScreenWidth(22), fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).shadowColor.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      InfoTile(
                                        title: "Lớp",
                                        value: user!.lop,
                                      ),
                                      SizedBox(height: getProportionateScreenHeight(15)),
                                      InfoTile(
                                        title: "Ngành",
                                        value: user!.nganh,
                                      ),
                                      SizedBox(height: getProportionateScreenHeight(15)),
                                      InfoTile(
                                        title: "Chuyên ngành",
                                        value: user!.chuyen_nganh,
                                      ),
                                      SizedBox(height: getProportionateScreenHeight(15)),
                                      InfoTile(
                                        title: "Khoa",
                                        value: user!.khoa,
                                      ),
                                      SizedBox(height: getProportionateScreenHeight(15)),
                                      InfoTile(
                                        title: "Bậc hệ đào tạo",
                                        value: user!.bac_he_dao_tao,
                                      ),
                                      SizedBox(height: getProportionateScreenHeight(15)),
                                      InfoTile(
                                        title: "Niên khóa",
                                        value: user!.nien_khoa,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
