import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_text_styles.dart';

class CustomTextButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  const CustomTextButton({
    this.onPressed,
    this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: this.onPressed,
      child: Text(
        this.title,
        style: AppTextStyle.h4TitleTextStyle(
          color: AppColor.primaryColor,
          
        ),
        
      ),
    );
  }
}
