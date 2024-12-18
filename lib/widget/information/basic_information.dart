import 'package:flutter/material.dart';

class BasicInformation extends StatelessWidget {
  const BasicInformation({
    Key? key,
    required this.title,
    required this.subtitle,
    this.trailingIcon,
    this.trailingOnTap,
    this.alternateSubtitle,
  }) : super(key: key);
  final String title;
  final Widget? alternateSubtitle;
  final String subtitle;
  final IconData? trailingIcon;
  final Function()? trailingOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Theme.of(context).unselectedWidgetColor,
          width: 0.25,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                alternateSubtitle == null
                    ? Text(
                        subtitle,
                        style: const TextStyle(fontSize: 14),
                      )
                    : alternateSubtitle!
              ],
            ),
          ),
          if (trailingIcon != null)
            Material(
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: InkWell(
                  onTap: trailingOnTap,
                  child: Icon(
                    trailingIcon,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
