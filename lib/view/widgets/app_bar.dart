import 'package:flutter/material.dart';
import 'package:nmims_leave_portal/theme/color_constants.dart';

Widget customAppBar(scaffoldKey) {
  return Container(
    margin: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 20,
    ),
    child: Row(
      children: [
        Image.asset(
          'assets/nmims_logo.png',
          height: 100,
          filterQuality: FilterQuality.high,
          fit: BoxFit.cover,
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(
            Icons.menu,
            color: ColorConstants.icongrey,
            size: 40,
          ),
          onPressed: () {
            scaffoldKey.currentState?.openEndDrawer();
          },
        ),
      ],
    ),
  );
}
