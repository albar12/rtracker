import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rtracker/helper/dimensions.dart';

class CustomSwitch extends StatefulWidget {
  final String title;
  final bool value;
  final String activeLabel;
  final String inactiveLabel;
  final Function onChanged;
  final bool readOnly;
  const CustomSwitch({
    Key? key,
    this.title = "",
    this.value = false,
    this.activeLabel = "Yes",
    this.inactiveLabel = "No",
    required this.onChanged,
    required this.readOnly,
  }) : super(key: key);

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CupertinoSwitch(
              value: _value,
              onChanged: (status){
                if (!widget.readOnly) {
                  setState(() {
                    _value = status;
                  });
                  widget.onChanged.call(status);
                }
              },
              activeColor: Theme.of(context).colorScheme.primary,
            ),
            Text(
              _value ? widget.activeLabel : widget.inactiveLabel,
            ),
          ],
        ),
      ],
    );
  }
}
