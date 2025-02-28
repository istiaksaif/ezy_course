import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/utils/app_color.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/utils/app_image.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function? onChanged;
  final Function? onSubmitted;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final bool? password;
  final String? preFixIcon;
  final double? preFixRightMargin;
  final double? surFixRightMargin;
  final Color? preFixColor;
  final Color? surFixColor;
  final String? surFixIcon;
  final Function? onTapSurFixIcon;
  final Function? onTapPreFixIcon;
  final Function? onTap;
  final bool? isTapSurFix;
  final int? maxLines;
  final Color? bgColor;
  final Color? borderColor;
  final double? paddingVertical;
  final double? paddingHor;
  final double borderWidth;
  final double? fixedWidth;
  final bool? readOnly;
  final TextStyle? textStyle;
  final double? textFont;
  final TextStyle? hintStyle;
  final Color? hintColor;
  final double? hintFontSize;
  final TextStyle? labelStyle;
  final TextCapitalization? textCapitalization;
  final String? countryDialCode;
  final bool? isPhone;
  final InputBorder? inputBorder;
  final TextInputAction? textInputAction;
  final String? errorText;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool showCounter;
  final FloatingLabelBehavior? floatingLabelBehavior;

  const CustomTextField({super.key,
    required this.hintText,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.keyboardType,
    this.textAlign,
    this.password,
    this.bgColor,
    this.paddingVertical,
    this.preFixIcon,
    this.maxLines,
    this.labelText,
    this.surFixIcon,
    this.onTapSurFixIcon,
    this.readOnly,
    this.textCapitalization,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.countryDialCode,
    this.isPhone,
    this.fixedWidth,
    this.inputBorder,
    this.paddingHor,
    this.onTap,
    this.textInputAction,
    this.preFixRightMargin,
    this.preFixColor,
    this.errorText,
    this.maxLength,
    this.onTapPreFixIcon,
    this.surFixColor,
    this.borderColor,
    this.inputFormatters,
    this.showCounter = false,
    this.borderWidth = 1.22,
    this.hintColor,
    this.textFont,
    this.hintFontSize,
    this.surFixRightMargin,
    this.isTapSurFix,
    this.floatingLabelBehavior,
    this.onSubmitted});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _passWord = false;
  int currentLength = 0;

  @override
  void initState() {
    super.initState();
    _passWord = widget.password ?? false;

    setState(() {});
    if (widget.controller != null) {
      widget.controller!.addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  @override
  void dispose() {
    if (widget.controller != null) {
      widget.controller!.removeListener(() {
        setState(() {});
      });
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          readOnly: widget.readOnly ?? false,
          controller: widget.controller,
          focusNode: widget.focusNode,
          maxLines: widget.maxLines ?? 1,
          maxLength: widget.maxLength,
          buildCounter: (BuildContext context,
              {int? currentLength, int? maxLength, bool? isFocused}) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  this.currentLength = currentLength ?? 0;
                });
              }
            });
            return const SizedBox.shrink();
          },
          textCapitalization:
          widget.textCapitalization ?? TextCapitalization.none,
          textAlign: widget.textAlign ?? TextAlign.start,
          textInputAction: widget.textInputAction,
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!();
            }
          },
          decoration: InputDecoration(
            error: (widget.errorText != null && widget.errorText!.isNotEmpty)
                ? SizedBox.shrink()
                : null,
            floatingLabelBehavior:
            widget.floatingLabelBehavior ?? FloatingLabelBehavior.never,
            filled: true,
            fillColor: widget.bgColor ?? AppColor.white.withValues(alpha: 0.1),
            alignLabelWithHint: true,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ??
                figTreeReg.copyWith(
                  fontSize: widget.hintFontSize,
                  color:
                  (widget.errorText != null && widget.errorText!.isNotEmpty)
                      ? AppColor.red
                      : widget.hintColor ??
                      AppColor.lightWhite.withValues(alpha: 0.5),
                ),
            contentPadding: EdgeInsets.fromLTRB(
                widget.paddingHor ?? 14.6.w,
                widget.paddingVertical ?? 9.75.h,
                widget.paddingHor ?? 14.6.w,
                widget.paddingVertical ?? 9.75.h),
            border: widget.inputBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.borderColor??AppColor.cardStockColor.withValues(alpha: 0.2),
                    width: widget.borderWidth,
                  ),
                  borderRadius: BorderRadius.circular(9.r),
                ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor??AppColor.cardStockColor.withValues(alpha: 0.2),
                width: widget.borderWidth,
              ),
              borderRadius: BorderRadius.circular(9.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor??AppColor.cardStockColor.withValues(alpha: 0.2),
                width: widget.borderWidth,
              ),
              borderRadius: BorderRadius.circular(9.r),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                widget.errorText != null ? AppColor.red : Colors.transparent,
                width: widget.borderWidth,
              ),
              borderRadius: BorderRadius.circular(9.r),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                widget.errorText != null ? AppColor.red : Colors.transparent,
                width: widget.borderWidth,
              ),
              borderRadius: BorderRadius.circular(9.r),
            ),
            prefixIconConstraints: BoxConstraints(
              maxWidth: widget.preFixIcon != null
                  ? 65
                  : widget.isPhone != null
                  ? 60
                  : 15,
              maxHeight: 24,
            ),
            suffixIcon: widget.password != null
                ? InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                setState(() {
                  _passWord = !_passWord;
                });
              },
              child: SvgPicture.asset(
                _passWord ? AppImage.icShow : AppImage.icHide,
                height: _passWord?null:19.5,
              ),
            )
                : widget.surFixIcon != null
                ? InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                if (widget.onTapSurFixIcon != null) {
                  widget.onTapSurFixIcon!();
                } else if (widget.onTap != null &&
                    (widget.isTapSurFix ?? false)) {
                  widget.onTap!();
                }
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    0, 0, widget.surFixRightMargin ?? 0, 0),
                child: SvgPicture.asset(
                  widget.surFixIcon!,
                  fit: BoxFit.scaleDown,
                ),
              ),
            )
                : const SizedBox(),
            suffixIconConstraints: BoxConstraints(
              minWidth: widget.paddingHor ??
                  (widget.password != null
                      ? 52.w
                      : widget.surFixIcon != null
                      ? 39.w
                      : 16.w),
            ),
          ),
          style: widget.textStyle ??
              figTreeReg.copyWith(
                color:
                (widget.errorText != null && widget.errorText!.isNotEmpty)
                    ? AppColor.red
                    : null,
                fontSize: widget.textFont,
              ),
          obscureText: _passWord,
          cursorColor: AppColor.textColor,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
              setState(() {});
            }
            // widget.onChanged();
          },
          onSubmitted: (value) {
            if (widget.onSubmitted != null) {
              widget.onSubmitted!();
            }
          },
        ),
        SizedBox(
          height: widget.showCounter ||
              (widget.errorText != null && widget.errorText!.isNotEmpty)
              ? 7.h
              : 0,
        ),
        Row(
          children: [
            Expanded(
              child: Visibility(
                visible:
                (widget.errorText != null && widget.errorText!.isNotEmpty),
                child: Text(
                  widget.errorText ?? '',
                  style:
                  figTreeReg.copyWith(color: AppColor.red, fontSize: 14.sp),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
