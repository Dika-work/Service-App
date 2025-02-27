// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:service/constant/custom_size.dart';
// import 'package:service/utils/theme/app_colors.dart';

// class DropDownWidget extends StatelessWidget {
//   const DropDownWidget({
//     super.key,
//     required this.value,
//     this.onChanged,
//     required this.items,
//     this.widthDropdownValue = 200,
//   });

//   final String? value;
//   final void Function(String?)? onChanged;
//   final List<String> items;
//   final double? widthDropdownValue;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<String>(
//         isExpanded: true,
//         items: items
//             .map((String item) => DropdownMenuItem<String>(
//                   value: item,
//                   child: Text(
//                     item,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: CustomSize.fontSizeSm,
//                       color: AppColors.textPrimary,
//                       fontFamily: 'Urbanist',
//                     ),
//                   ),
//                 ))
//             .toList(),
//         value: value,
//         onChanged: onChanged != null ? (value) => onChanged!(value) : null,
//         buttonStyleData: ButtonStyleData(
//           height: 55,
//           width: MediaQuery.of(context).size.width,
//           padding: const EdgeInsets.symmetric(horizontal: CustomSize.md),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(CustomSize.inputFieldRadius),
//             border: Border.all(
//               width: 1,
//               color: AppColors.borderPrimary,
//             ),
//             color: AppColors.primaryBackground,
//           ),
//           elevation: 2,
//         ),
//         iconStyleData: const IconStyleData(
//           icon: Icon(Icons.arrow_forward_ios_outlined),
//           iconSize: 14,
//           iconEnabledColor: AppColors.darkGrey,
//           iconDisabledColor: Colors.grey,
//         ),
//         dropdownStyleData: DropdownStyleData(
//           maxHeight: 200,
//           width: widthDropdownValue ?? 200, // default to 200 if null
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(CustomSize.inputFieldRadius),
//             border: Border.all(
//               width: 1,
//               color: AppColors.borderPrimary,
//             ),
//           ),
//           offset: const Offset(-20, 0),
//           scrollbarTheme: ScrollbarThemeData(
//             radius: const Radius.circular(40),
//             thickness: WidgetStateProperty.all(6),
//             thumbVisibility: WidgetStateProperty.all(true),
//           ),
//         ),
//         menuItemStyleData: const MenuItemStyleData(
//           height: 40,
//           padding: EdgeInsets.only(left: 14, right: 14),
//         ),
//       ),
//     );
//   }
// }
