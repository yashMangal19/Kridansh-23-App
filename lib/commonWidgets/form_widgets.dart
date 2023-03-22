import 'package:flutter/material.dart';

class KridanshFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextInputAction inputAction;
  final bool readOnly;
  final void Function()? onTap;
  final void Function(String)? onSumbit;
  final bool floatLabel;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? labelTextColor;

  const KridanshFormField({
    Key? key,
    required this.textEditingController,
    required this.labelText,
    this.validator,
    this.inputAction=TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.floatLabel = true,
    this.onTap,
    this.onSumbit,
    this.suffixIcon,
    this.fillColor,
    this.labelTextColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: fillColor,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          isDense: true,
          floatingLabelBehavior: (!floatLabel)? FloatingLabelBehavior.never : null,
          floatingLabelStyle: TextStyle(
            shadows: [Shadow(color: labelTextColor??Colors.black, offset: const Offset(-13, -8))],
            color: Colors.transparent,
            fontSize: 14,
          ),
          suffixIcon: suffixIcon,
        ),
        keyboardType: keyboardType,
        controller: textEditingController,
        validator: validator,
        readOnly: readOnly,
        textInputAction: inputAction,
        onTap: onTap,
        onFieldSubmitted: onSumbit,
      ),
    );
  }
}


// InputDecoration propzingInputDecoration(String labelText) => InputDecoration(
//   labelText: labelText,
//   filled: true,
//   fillColor: PropzingTheme.secondaryBgColor,
//   border: const OutlineInputBorder(
//     borderSide: BorderSide.none,
//   ),
//   contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4),
//   isDense: true,
//   floatingLabelStyle: TextStyle(
//     shadows: [Shadow(color: PropzingTheme.tertiaryTextColor, offset: const Offset(-3, -10))],
//     color: Colors.transparent,
//   ),
// );


class FormButton extends StatelessWidget {
  final Size pageSize;
  final double widthScale;
  final double fontSize;
  final Color bgColor;
  final Color textColor;
  final String text;
  final void Function()? onPressed;

  const FormButton({
    Key? key,
    required this.pageSize,
    this.fontSize=20,
    this.widthScale = 0.3,
    required this.bgColor,
    required this.textColor,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
      ),
      child: SizedBox(
        width: pageSize.width*widthScale,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: fontSize, color: textColor),
        ),
      ),
    );
  }
}

class FormRadioButtons extends StatefulWidget {
  final String questionText;
  final List<Widget> radioButtons;
  final String? Function(dynamic)? validator;
  const FormRadioButtons({
    Key? key,
    required this.questionText,
    required this.radioButtons,
    this.validator,
  }) : super(key: key);

  @override
  State<FormRadioButtons> createState() => _FormRadioButtonsState();
}

class _FormRadioButtonsState extends State<FormRadioButtons> {
  @override
  Widget build(BuildContext context) {
    return FormField(builder: (FormFieldState<dynamic> state){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.questionText,
              style: const TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.radioButtons,
              ),
            ),
            state.hasError?Text(
              state.errorText!,
              style: const TextStyle(
                  color: Colors.red
              ),
            ) :
            const SizedBox(),
          ],
        ),
      );
    },
      validator: widget.validator,
    );
  }
}
