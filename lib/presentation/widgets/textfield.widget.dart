import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

class TextfieldWidget extends StatefulWidget {
  const TextfieldWidget({
    required this.controller,
    required this.inputType,
    required this.hint,
    required this.isPassword,
    this.hasIcon,
    this.isPhone,
    this.icon,
    this.maxLength,
    this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType inputType;
  final bool isPassword;
  final bool? hasIcon;
  final bool? isPhone;
  final IconData? icon;
  final int? maxLength;
  final Function(String)? onChanged;
  @override
  State<TextfieldWidget> createState() => _TextfieldWidgetState();
}

class _TextfieldWidgetState extends State<TextfieldWidget> {
  bool isOpen = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.onBackground.withOpacity(.1),
      ),
      child: Stack(
        children: [
          Visibility(
            visible: widget.isPassword,
            child: Positioned(
              right: 14,
              top: 12,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isOpen = !isOpen;
                  });
                },
                child: Icon(
                  isOpen ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.hasIcon ?? false,
            child: Positioned(
              left: 14,
              top: 12,
              child: Icon(
                widget.icon,
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
              ),
            ),
          ),
          // Visibility(
          //   visible: widget.isPhone ?? false,
          //   child: Positioned(
          //     right: 14,
          //     top: 0,
          //     child: DropdownButton(
          //       underline: const SizedBox.shrink(),
          //       value: 'pe',
          //       icon: const SizedBox.shrink(),
          //       onChanged: (value) {},
          //       items: [
          //         DropdownMenuItem(
          //           value: 'pe',
          //           child: SvgPicture.asset('assets/svg/countries/pe.svg',
          //               alignment: Alignment.centerRight, width: 30),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: TextField(
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
              controller: widget.controller,
              obscureText: !isOpen,
              maxLength: widget.maxLength ?? 15,
              keyboardType: widget.inputType,
              textAlign: TextAlign.start,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                counterText: '',
                border: InputBorder.none,
                hintText: widget.hint,
                hintStyle: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
