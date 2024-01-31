import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import 'expandable_card_widget.dart';

class SalaryCalcSettingsWidget extends StatefulWidget {
  final int salaryContract;
  final int workDayTimeContractInHours;
  final Function({int? salaryContractAmount_, int? workDayTimeContractInHours_}) onContractsEnter;

  const SalaryCalcSettingsWidget({
    super.key,
    required this.onContractsEnter,
    required this.salaryContract,
    required this.workDayTimeContractInHours,
  });

  @override
  State<SalaryCalcSettingsWidget> createState() => _SalaryCalcSettingsWidgetState();
}

class _SalaryCalcSettingsWidgetState extends State<SalaryCalcSettingsWidget> {
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController tECworkDayTimeContract = TextEditingController();

  @override
  void initState() {
    textEditingController.text = _toSeragam(widget.salaryContract.toString());
    tECworkDayTimeContract.text = widget.workDayTimeContractInHours.toString();
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
          _salaryContractInput(),
          const Divider(height: 30),
          _workDayTimeContractInput(),
        ],
      ),
    );
  }

  String _toSeragam(String value) => value.seRagham().toEnglishDigit();

  Widget _salaryContractInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "حقوق ماهیانه:",
          textDirection: TextDirection.rtl,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 0.6.sw,
          child: TextField(
            controller: textEditingController,
            onTapOutside: (event) {
              if (textEditingController.text.isEmpty) {
                textEditingController.text = _toSeragam(widget.salaryContract.toString());
                widget.onContractsEnter(salaryContractAmount_: widget.salaryContract);
              }
            },
            onChanged: (value) {
              textEditingController.text = _toSeragam(value);
              if (value.isNotEmpty) {
                widget.onContractsEnter(
                  salaryContractAmount_:
                      int.parse(value.extractNumber(toDigit: NumStrLanguage.English)),
                );
              }
            },
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9۰-۹]'))],
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              border: OutlineInputBorder(),
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
        ),
      ],
    );
  }

  Widget _workDayTimeContractInput() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "ساعت کاری:",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 0.6.sw,
              child: TextField(
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    if (int.parse(value) <= 24 && int.parse(value) > 0) {
                      widget.onContractsEnter(workDayTimeContractInHours_: int.tryParse(value));
                    } else {
                      tECworkDayTimeContract.text = 24.toString();
                    }
                  }
                },
                controller: tECworkDayTimeContract,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9۰-۹]'))],
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  border: OutlineInputBorder(),
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "لطفا ساعت کار روزانه را وارد کنید مثال: 10 ساعت",
          style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.black54),
        ),
      ],
    );
  }
}
