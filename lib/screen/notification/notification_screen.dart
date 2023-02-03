import 'package:flutter/material.dart';
import 'package:nlu/domain/post.dart';
import 'package:nlu/provider/dkmh_provider.dart';
import 'package:nlu/utils/app_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../components/custom_app_bar.dart';
import '../../config/size_config.dart';

class NotificationScreen extends StatefulWidget {
  static String routeName = "/notification";
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isInit = true;
  late DKMHProvider provider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    provider = Provider.of<DKMHProvider>(context, listen: false);
    // if (isInit) {
    //   provider.fetchPosts().then((_) {
    //     setState(() {
    //       isInit = false;
    //     });
    //   });
    // }
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
                title: "Thông báo",
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            FutureBuilder(
                future: provider.fetchPosts(),
                builder: (context, sapshot) {
                  List<Post> posts = provider.posts;
                  return Flexible(
                    child: Container(
                      margin: EdgeInsets.only(
                        left: getProportionateScreenWidth(20),
                        right: getProportionateScreenWidth(20),
                        bottom: getProportionateScreenHeight(100),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: posts
                              .map(
                                (post) => GestureDetector(
                                  onTap: () {
                                    launchUrlString(
                                      createPostUri(id: post.id),
                                      mode: LaunchMode.externalApplication,
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      bottom: getProportionateScreenHeight(20),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: getProportionateScreenWidth(20),
                                      vertical: getProportionateScreenHeight(20),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.notifications,
                                              size: getProportionateScreenWidth(30),
                                              color: Colors.blue,
                                            ),
                                            Flexible(
                                              child: Text(
                                                post.tieu_de,
                                                maxLines: 3,
                                                style: TextStyle(
                                                  fontSize: getProportionateScreenWidth(16),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: getProportionateScreenHeight(5),
                                        ),
                                        Text(
                                          "Ngày đăng: ${post.ngay_dang_tin}",
                                          style: TextStyle(
                                            fontSize: getProportionateScreenWidth(16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
