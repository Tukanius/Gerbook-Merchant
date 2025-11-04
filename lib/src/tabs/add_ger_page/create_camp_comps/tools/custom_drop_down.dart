import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/address.dart';

class CustomDropDown extends StatefulWidget {
  final String titleText;
  final String hintText;
  final Function(String) countId;
  final Function(String) textController;
  final List<Address> countyData;
  final Function(String) onQueryChanged;

  const CustomDropDown({
    super.key,
    required this.titleText,
    required this.hintText,
    required this.countId,
    required this.textController,
    required this.countyData,
    required this.onQueryChanged,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.titleText,
            style: TextStyle(
              color: gray700,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: DropdownSearch<Address>(
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  // suffixProps: ,
                  mode: Mode.custom,
                  dropdownBuilder: (ctx, selectedItem) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: white,
                      border: Border.all(color: gray300),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${selectedItem != null ? selectedItem.nameEng : widget.hintText}',
                            style: TextStyle(
                              color: selectedItem != null ? gray900 : gray500,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                        ),
                        SvgPicture.asset('assets/svg/drop_down.svg'),
                      ],
                    ),
                  ),

                  items: (filter, loadProps) {
                    return widget.countyData
                        .where(
                          (item) => item.nameEng!.toLowerCase().contains(
                            filter.toLowerCase(),
                          ),
                        )
                        .toList();
                  },

                  itemAsString: (Address u) => u.nameEng!,
                  onChanged: (Address? data) {
                    setState(() {
                      widget.countId(data!.id!);
                      widget.textController(data.nameEng!);
                      // selectedCountry. = data?.id;
                      // textController.text = data?.nameEng ?? '';
                    });
                  },
                  compareFn: (item1, item2) => item1.id == item2.id,
                  popupProps: PopupProps.menu(
                    showSearchBox: true,
                    showSelectedItems: true,
                    fit: FlexFit.loose,
                    scrollbarProps: ScrollbarProps(
                      thumbColor: transparent,
                      trackColor: transparent,
                      trackBorderColor: transparent,
                    ),
                    searchFieldProps: TextFieldProps(
                      autocorrect: false,
                      // onChanged: (value) async {
                      //   await listCountry(page, limit, query: value, level0: 0);
                      // },
                      onChanged: (value) async {
                        widget.onQueryChanged(value);
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: gray300),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: gray300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: gray300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: gray300),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: gray300),
                        ),
                        border: InputBorder.none,
                        hintText: widget.hintText,
                        hintMaxLines: 1,
                        hintStyle: TextStyle(
                          color: gray500,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                        ),
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
