import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:blitix/app/core/values/app_constants.dart';
import 'package:blitix/app/core/values/app_values.dart';
import 'package:blitix/app/core/widgets/dash_line_widget.dart';

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
        systemNavigationBarColor: isBackground ? theme.colorScheme.surface : theme.scaffoldBackgroundColor,
      ),
      child: child
    );
  }
}

class ButtonPrimaryWidget extends StatelessWidget {
  const ButtonPrimaryWidget({super.key,
    required this.title,
    this.height = 50.0,
    this.onPressed,
    this.icon,
    this.backgroundColor,
    this.disabledForegroundColor,
    this.disabledBackgroundColor,
    this.isOutlined = false,
    this.textStyle,
  });

  final String title;
  final double height;
  final VoidCallback? onPressed;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? disabledForegroundColor;
  final Color? disabledBackgroundColor;
  final bool isOutlined;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      height: height,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppValues.smallRadius),
            side: isOutlined ? BorderSide(color: backgroundColor ?? theme.colorScheme.primary) : BorderSide.none
          ),
          foregroundColor: isOutlined ? (backgroundColor ?? theme.colorScheme.primary) : Colors.white,
          backgroundColor: isOutlined ? theme.colorScheme.surface : backgroundColor ?? theme.colorScheme.primary,
          disabledForegroundColor: disabledForegroundColor,
          disabledBackgroundColor: isOutlined ? null : disabledBackgroundColor ?? theme.dividerColor,
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
      backgroundColor: theme.colorScheme.surface,
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

class FilterChipWidget extends StatelessWidget {
  const FilterChipWidget({super.key,
    required this.title,
    required this.isSelected,
    this.backgroundColor,
    this.onSelected
  });

  final String title;
  final bool isSelected;
  final Color? backgroundColor;
  final ValueChanged<bool>? onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(right: AppValues.padding),
      child: ChoiceChip(
        label: Text(title,
          style: TextStyle(
            color: isSelected ? Colors.white : null,
            fontSize: 16.0,
          )
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppValues.smallPadding,
          vertical: AppValues.smallPadding
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppValues.smallRadius)),
        selectedColor: theme.colorScheme.primary,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        pressElevation: 0,
        selected: isSelected,
        onSelected: onSelected,
      ),
    );
  }
}

class ExpansionWidget extends StatelessWidget {
  const ExpansionWidget({super.key,
    required this.title,
    required this.children,
    this.isExpanded = false,
    this.initiallyExpanded = false,
    this.backgroundColor,
    this.onExpansionChanged,
    this.controller,
  });

  final String title;
  final bool isExpanded;
  final bool initiallyExpanded;
  final Color? backgroundColor;
  final ValueChanged<bool>? onExpansionChanged;
  final List<Widget> children;
  final ExpansionTileController? controller;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ExpansionTile(
      controller: controller,
      title: Text(title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18.0
        ),
      ),
      trailing: SvgPicture.asset(isExpanded ? icRadioOn : icRadioOff),
      initiallyExpanded: initiallyExpanded,
      backgroundColor: backgroundColor ?? theme.scaffoldBackgroundColor,
      collapsedBackgroundColor: backgroundColor ?? theme.scaffoldBackgroundColor,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppValues.smallRadius),
        borderSide: BorderSide(
          width: 1.0,
          color: theme.dividerColor
        )
      ),
      collapsedShape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppValues.smallRadius),
        borderSide: BorderSide(
          width: 1.0,
          color: theme.dividerColor
        )
      ),
      onExpansionChanged: onExpansionChanged,
      childrenPadding: const EdgeInsets.only(
        bottom: AppValues.halfPadding
      ),
      children: children,
    );
  }
}

class DividerCutterWidget extends StatelessWidget {
  const DividerCutterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(24.0),
              bottomRight: Radius.circular(24.0)
            ),
            color: theme.scaffoldBackgroundColor,
          ),
          child: const SizedBox(
            width: 12.0,
            height: 24.0,
          ),
        ),
        const Expanded(
          child: DashLineWidget()
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              bottomLeft: Radius.circular(24.0)
            ),
            color: theme.scaffoldBackgroundColor,
          ),
          child: const SizedBox(
            width: 12.0,
            height: 24.0,
          ),
        )
      ],
    );
  }
}