import 'package:flutter/material.dart';
import 'package:nlu/config/size_config.dart';
import 'package:nlu/constant/timeline.dart';
import 'package:nlu/domain/subject.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.subject,
    required this.color,
  });

  final Subject subject;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject.ten_mon,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Text(
                  subject.gv,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
            child: VerticalDivider(
              color: Colors.white70,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                subject.phong,
                style:
                    Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Text(
                timeline[subject.tbd]!.format(context),
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
