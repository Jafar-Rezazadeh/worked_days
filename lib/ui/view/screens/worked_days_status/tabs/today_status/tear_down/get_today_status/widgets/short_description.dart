import 'package:flutter/material.dart';

class GetDescription extends StatefulWidget {
  final ValueChanged<String> onTextChanged;
  const GetDescription({super.key, required this.onTextChanged});

  @override
  State<GetDescription> createState() => _GetDescriptionState();
}

class _GetDescriptionState extends State<GetDescription> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextField(
        textDirection: TextDirection.rtl,
        onChanged: widget.onTextChanged,
        decoration: const InputDecoration(
          hintTextDirection: TextDirection.rtl,
          hintText: "توضیحات",
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
