import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import 'expandable_card_widget.dart';

class SalaryCalcSettingsWidget extends StatefulWidget {
  final int initialSalary;
  final ValueChanged<int> onTextFieldValueChanged;

  const SalaryCalcSettingsWidget({
    super.key,
    required this.onTextFieldValueChanged,
    required this.initialSalary,
  });

  @override
  State<SalaryCalcSettingsWidget> createState() => _SalaryCalcSettingsWidgetState();
}

class _SalaryCalcSettingsWidgetState extends State<SalaryCalcSettingsWidget> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    textEditingController.text = _toSeragam(widget.initialSalary.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableCardWidget(
      header: "حقوق",
      collapsed: Container(),
      expanded: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("حقوق ماهیانه"),
          const SizedBox(height: 10),
          //? salary input
          TextField(
            controller: textEditingController,
            onTapOutside: (event) {
              if (textEditingController.text.isEmpty) {
                textEditingController.text = _toSeragam(widget.initialSalary.toString());
                widget.onTextFieldValueChanged(widget.initialSalary);
              }
            },
            onChanged: (value) {
              textEditingController.text = _toSeragam(value);
              if (value.isNotEmpty) {
                widget.onTextFieldValueChanged(
                  int.parse(value.extractNumber(toDigit: NumStrLanguage.English)),
                );
              }
            },
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9۰-۹]'))],
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              border: OutlineInputBorder(),
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "محاسبه بر اساس روز های کاری",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12.sp,
              ),
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  String _toSeragam(String value) => value.seRagham().toEnglishDigit();
}
