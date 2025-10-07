// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:intl/intl.dart';
// import 'package:merchant_gerbook_flutter/components/ui/color.dart';

// class FormDateField extends StatefulWidget {
//   final String name;
//   final String? labelText;
//   final double? width;
//   final bool? filled;
//   final Color? textColor;
//   final Color? labelColor;
//   final Widget? suffixIcon;
//   final Color? bgColor;
//   final EdgeInsetsGeometry? padding;
//   final String? Function(dynamic)? validator;
//   final Color? fillColor;
//   final bool obscureText;
//   final bool hasObscureControl;
//   final TextEditingController? controller;

//   const FormDateField({
//     this.suffixIcon,
//     super.key,
//     required this.name,
//     this.labelText,
//     this.width,
//     this.textColor,
//     this.filled = false,
//     this.labelColor,
//     this.bgColor,
//     this.padding,
//     this.validator,
//     this.fillColor,
//     this.obscureText = false,
//     this.hasObscureControl = false,
//     this.controller,
//   });

//   @override
//   State<FormDateField> createState() => _FormDateFieldState();
// }

// class _FormDateFieldState extends State<FormDateField> {
//   bool isPasswordVisible = false;
//   TextEditingController? controller = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     isPasswordVisible = widget.hasObscureControl;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: widget.width,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ignore: unnecessary_null_comparison
//           widget.labelText != null
//               ? Text(
//                   widget.labelText!,
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                     color: widget.labelColor,
//                   ),
//                 )
//               : SizedBox(),
//           const SizedBox(height: 5),
//           FormBuilderTextField(
//             name: widget.name,
//             validator: widget.validator,
//             controller: controller,
//             obscureText: !widget.obscureText
//                 ? isPasswordVisible
//                 : !isPasswordVisible,
//             style: TextStyle(color: widget.textColor ?? white),
//             decoration: InputDecoration(
//               suffixIcon: widget.obscureText == true
//                   ? IconButton(
//                       onPressed: () {
//                         setState(() {
//                           isPasswordVisible = !isPasswordVisible;
//                         });
//                       },
//                       icon: isPasswordVisible == true
//                           ? Icon(Icons.visibility, color: Colors.grey.shade700)
//                           : Icon(
//                               Icons.visibility_off,
//                               color: Colors.grey.shade700,
//                             ),
//                     )
//                   : widget.suffixIcon,
//               border: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               fillColor: widget.fillColor ?? Colors.transparent,
//               isDense: true,
//               filled: widget.filled,
//               contentPadding:
//                   widget.padding ??
//                   const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
//             ),
//             readOnly: true,
//             onTap: () async {
//               DateTime? pickedDate = await showDatePicker(
//                 context: context,
//                 initialDate:
//                     (controller?.text != null && controller?.text != "")
//                     ? DateTime.parse(controller?.text as String)
//                     : DateTime.now(), //get today's date
//                 firstDate: DateTime(
//                   2000,
//                 ), //DateTime.now() - not to allow to choose before today.
//                 lastDate: DateTime(2101),
//               );

//               if (pickedDate != null) {
//                 setState(() {
//                   controller?.text = DateFormat(
//                     "yyyy-MM-dd",
//                   ).format(pickedDate);
//                 });
//                 // print(
//                 //     pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
//                 // String formattedDate = DateFormat('yyyy-MM-dd').format(
//                 //     pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
//                 // print(
//                 //     formattedDate); //formatted date output using intl package =>  2022-07-04
//                 // //You can format date as per your need

//                 // widget.controller.text =
//                 //     formattedDate; //set foratted date to TextField value.
//               } else {
//                 if (kDebugMode) {
//                   print("Date is not selected");
//                 }
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
