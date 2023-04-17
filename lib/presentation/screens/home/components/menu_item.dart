import '../../../theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MenuItemWidget extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final IconData? icon;
  final Color? iconColor;
  final int? number;

  const MenuItemWidget(
      {Key? key,
      this.onTap,
      required this.title,
      this.icon = Ionicons.folder,
      this.iconColor = ColorsApp.blueLight,
      this.number = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          const SizedBox(width: 10.0),
          Icon(icon, color: iconColor),
          const SizedBox(width: 10.0),
          Text(title),
          const SizedBox(width: 10.0),
          Text(
            "$number",
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          // Spacer()
        ],
      ),
    );
  }
}
