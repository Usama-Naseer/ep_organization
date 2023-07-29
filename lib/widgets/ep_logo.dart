import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/ep_colors.dart';

class EPLogo extends StatelessWidget {
  const EPLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: EPColors.kSecondaryColor,
      ),
      padding: EdgeInsets.all(16.h),
      child: Text(
        'EP',
        style: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
          color: EPColors.kPrimaryColor,
        ),
      ),
    );
  }
}
