import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

TextStyle get figTreeReg {
  return GoogleFonts.figtree(
      fontWeight: FontWeight.w400,
      fontSize: 19.5.sp,
      color: AppColor.lightWhite,
      height: 1.5.h);
}

TextStyle get figTreeMedium {
  return GoogleFonts.figtree(
      fontWeight: FontWeight.w500,
      fontSize: 17.sp,
      color: AppColor.lightWhite.withValues(alpha: 0.5),
      height: 1.435.h);
}

TextStyle get figTreeSemiBold {
  return GoogleFonts.figtree(
      fontWeight: FontWeight.w600,
      fontSize: 18.sp,
      color: Colors.white,
      height: 1.21.h);
}

TextStyle get figTreeBold {
  return GoogleFonts.figtree(
      fontWeight: FontWeight.w700,
      fontSize: 12.sp,
      color: AppColor.darkCyan1,
      height: 1.17.h);
}
