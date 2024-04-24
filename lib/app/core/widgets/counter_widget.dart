import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mytix/app/core/values/app_values.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key,
    required this.textEditingController,
    this.focusNode,
    this.maxLength
  });

  final TextEditingController textEditingController;
  final FocusNode? focusNode;
  final int? maxLength;

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  late FocusNode focusNode;
  int counter = 1;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
    widget.textEditingController.text = counter.toString();

    widget.textEditingController.addListener(() {
      if (widget.textEditingController.text.isNotEmpty) {
        counter = int.parse(widget.textEditingController.text);
        if (mounted) setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Focus(
      onFocusChange: (value) {
        setState(() {

        });
      },
      child: Material(
        color: Colors.transparent,
        child: Row(
          children: [

            SizedBox.square(
              dimension: 32.0,
              child: InkWell(
                onTap: counter > 0 ? () {
                  counter--;
                  widget.textEditingController.text = counter.toString();
                  focusNode.unfocus();
                } : null,
                borderRadius: BorderRadius.circular(AppValues.smallRadius),
                child: Ink(
                  decoration: BoxDecoration(
                    color: counter > 0 ? theme.colorScheme.primary : theme.disabledColor,
                    borderRadius: BorderRadius.circular(AppValues.smallRadius)
                  ),
                  child: const Icon(Icons.remove_rounded,
                    size: AppValues.iconSmallSize,
                    color: Colors.white
                  ),
                ),
              ),
            ),

            Expanded(
              child: TextFormField(
                focusNode: focusNode,
                controller: widget.textEditingController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                maxLines: 1,
                maxLength: widget.maxLength ?? 1,
                cursorWidth: 1.0,
                cursorColor: theme.colorScheme.primary,
                textAlign: TextAlign.center,
                enabled: false,
                onChanged: (value) {
                  if(value.isNotEmpty) {
                    counter = int.parse(value);
                  }
                },
                onFieldSubmitted: (value) {
                  if (value.isEmpty || value == "0") {
                    counter = 1;
                    widget.textEditingController.text = "1";
                  }
                  FocusScope.of(context).nextFocus();
                },
                decoration: const InputDecoration(
                  isDense: true,
                  fillColor: Colors.transparent,
                  errorStyle: TextStyle(height: 0),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  counterText: "",
                ),
                style: theme.textTheme.bodyMedium,
              ),
            ),

            SizedBox.square(
              dimension: 32.0,
              child: InkWell(
                onTap: counter < 5 ? () {
                  counter++;
                  widget.textEditingController.text = counter.toString();
                  focusNode.unfocus();
                } : null,
                borderRadius: BorderRadius.circular(AppValues.smallRadius),
                child: Ink(
                  decoration: BoxDecoration(
                    color: counter < 5 ? theme.colorScheme.primary : theme.disabledColor,
                    borderRadius:BorderRadius.circular(AppValues.smallRadius)
                  ),
                  child: const Icon(Icons.add_rounded,
                    size: AppValues.iconSmallSize,
                    color: Colors.white
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}