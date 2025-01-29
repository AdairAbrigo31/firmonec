
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tesis_firmonec/theme/theme.dart';

class CancelButton extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const CancelButton({
    super.key,
    required this.text,
    this.height = 50.0, // Altura por defecto
    this.width,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      width: width ?? double.infinity,

      height: height,

      child: ElevatedButton(

        onPressed: (){

          if(context.mounted){
            context.pop();
          }

        },
        
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
          
          ),
        ),
        child: Text(
          text,
          style: AppTypography.button.copyWith(color: Theme.of(context).colorScheme.error),
        ),
      ),
    );
  }
}