import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/app_image.dart';

class GradientColorPicker extends StatefulWidget {
  final List<List<int>> rgbColors;
  final Function tapResult;

  const GradientColorPicker({super.key, required this.rgbColors, required this.tapResult});

  @override
  State<GradientColorPicker> createState() => _GradientColorPickerState();
}

class _GradientColorPickerState extends State<GradientColorPicker> {
  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 26.w,
          height: 26.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(
                    widget.rgbColors[selectedColor][0],
                    widget.rgbColors[selectedColor][1],
                    widget.rgbColors[selectedColor][2],
                    1.0),
                Color.fromRGBO(
                    widget.rgbColors[selectedColor][3],
                    widget.rgbColors[selectedColor][4],
                    widget.rgbColors[selectedColor][5],
                    1.0),
              ],
            ),
          ),
          child: Center(
            child: SvgPicture.asset(AppImage.icArrow),
          ),
        ),
        SizedBox(width: 5.w),
        ...widget.rgbColors.asMap().entries.map((entry) {
          int index = entry.key;
          List<int> rgbPair = entry.value;
          return Padding(
            padding: EdgeInsets.only(right: 5.w),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                widget.tapResult(index);
                setState(() {
                  selectedColor = index;
                });
              },
              child: Container(
                width: 26.w,
                height: 26.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.r),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(rgbPair[0], rgbPair[1], rgbPair[2], 1.0),
                      Color.fromRGBO(rgbPair[3], rgbPair[4], rgbPair[5], 1.0),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
