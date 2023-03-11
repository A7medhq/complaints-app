import 'package:flutter/material.dart';

class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;

  final Widget? title;
  final ValueChanged<T?> onChanged;
  final Color? color;

  const MyRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.title,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        height: 56,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (color != null)
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(12)),
              ),
            if (title != null) title,
            _customRadioButton,
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return isSelected ? Icon(Icons.check) : Container();
  }
}
