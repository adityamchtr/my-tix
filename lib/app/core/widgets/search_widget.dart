import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/core/values/app_values.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key,
    this.controller,
    this.hintText,
    this.showSearchIcon = true,
    this.onChanged,
    this.onSubmitted,
    this.onPressedClear,
  });

  final TextEditingController? controller;
  final String? hintText;
  final bool showSearchIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onPressedClear;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {

  late TextEditingController searchTextController;

  @override
  void initState() {
    super.initState();

    searchTextController = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    searchTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: StatefulBuilder(
        builder: (context, setState) {
          return TextField(
            controller: searchTextController,
            textInputAction: TextInputAction.search,
            style: const TextStyle(
              fontSize: 18.0
            ),
            onChanged: (value) {
              setState(() {});
              if (widget.onChanged != null) widget.onChanged!(value);
            },
            onSubmitted: widget.onSubmitted,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppValues.smallRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppValues.smallRadius),
                borderSide: const BorderSide(
                  width: 1.5
                )
              ),
              isDense: true,
              contentPadding: widget.showSearchIcon ? EdgeInsets.zero : null,
              prefixIcon: widget.showSearchIcon ? SvgPicture.asset(icSearch,
                fit: BoxFit.scaleDown,
              ) : null,
              suffixIcon: searchTextController.text.isNotEmpty ? IconButton(
                onPressed: () {
                  setState(() {
                    searchTextController.clear();
                  });
                  if (widget.onPressedClear != null) widget.onPressedClear!.call();
                },
                icon: const Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.circle_rounded),
                    Icon(Icons.close_rounded,
                      color: Colors.white,
                      size: AppValues.iconSmallerSize,
                    ),
                  ],
                ),
                iconSize: AppValues.iconSmallSize,
                color: Colors.grey,
                splashRadius: AppValues.radius,
              ) : null
            ),
          );
        }
      ),
    );
  }
}