import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:match/app/core/values/app_values.dart';

class SystemUiOverlayWidget extends StatelessWidget {
  const SystemUiOverlayWidget({super.key,
    required this.child,
    this.isBackground = false
  });

  final Widget child;
  final bool isBackground;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: isBackground ? theme.colorScheme.background : theme.scaffoldBackgroundColor,
      ),
      child: child
    );
  }
}

class ButtonPrimaryWidget extends StatelessWidget {
  const ButtonPrimaryWidget({super.key,
    required this.title,
    this.onPressed,
    this.icon,
    this.backgroundColor,
    this.isOutlined = false,
    this.textStyle,
  });

  final String title;
  final VoidCallback? onPressed;
  final Widget? icon;
  final Color? backgroundColor;
  final bool isOutlined;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      height: 50.0,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppValues.smallRadius),
            side: isOutlined ? BorderSide(color: backgroundColor ?? theme.colorScheme.primary) : BorderSide.none
          ),
          foregroundColor: isOutlined ? (backgroundColor ?? theme.colorScheme.primary) : Colors.white,
          backgroundColor: isOutlined ? theme.colorScheme.background : backgroundColor ?? theme.colorScheme.primary,
          disabledBackgroundColor: isOutlined ? null : theme.dividerColor,
          textStyle: textStyle ?? const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18.0
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            if (icon != null) const SizedBox(
              width: AppValues.extraSmallPadding,
            ),
            if (icon != null) icon!,
          ],
        ),
      ),
    );
  }
}

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({super.key,
    required this.title,
    this.subTitle,
    this.image,
    this.onConfirm,
    this.textConfirm,
  });

  final String title;
  final String? subTitle;
  final Widget? image;
  final VoidCallback? onConfirm;
  final String? textConfirm;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Dialog(
      backgroundColor: theme.colorScheme.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppValues.radius))
      ),
      child: IntrinsicWidth(
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              //Image
              if (image != null) image!,

              //Title
              Padding(
                padding: const EdgeInsets.only(
                  left: AppValues.padding,
                  right: AppValues.padding,
                ),
                child: Text(title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),

              //Subtitle
              if (subTitle != null) Padding(
                padding: const EdgeInsets.only(
                  top: AppValues.padding,
                  left: AppValues.padding,
                  right: AppValues.padding,
                ),
                child: Text(subTitle!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.disabledColor,
                    fontSize: 16.0,
                  ),
                ),
              ),

              //Button Confirm
              Padding(
                padding: const EdgeInsets.all(AppValues.padding),
                child: ButtonPrimaryWidget(
                  title: textConfirm ?? "Oke",
                  onPressed: onConfirm,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}