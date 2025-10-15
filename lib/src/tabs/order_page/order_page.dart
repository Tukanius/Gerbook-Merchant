import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/order_card.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/components/ui/form_textfield.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int filterIndex = 0;

  TextEditingController searchController = TextEditingController();
  final List<String> tabs = [
    'Бүгд',
    'Хуваарилагдсан',
    'Агуулахаас гарсан',
    'Хүлээн авсан',
  ];
  final Map<String, String> tabFilters = {
    'Бүгд': "",
    'Хуваарилагдсан': "NEW",
    'Агуулахаас гарсан': "PENDING",
    'Хүлээн авсан': "DONE",
  };
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final translateKey = Provider.of<LocalizationProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        shape: Border(bottom: BorderSide(color: gray200, width: 2)),
        elevation: 0,
        centerTitle: false,
        backgroundColor: white,
        automaticallyImplyLeading: false,
        title: Text(
          '${translateKey.translate('order')[0].toUpperCase()}${translateKey.translate('order').substring(1)}',
          style: TextStyle(
            color: gray800,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(32),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 16),
                  Row(
                    children: List.generate(tabs.length, (index) {
                      final bool isSelected = filterIndex == index;
                      return GestureDetector(
                        onTap: () async {
                          setState(() {
                            filterIndex = index;
                          });
                          // final selectedTab = tabs[filterIndex];
                          // final filter = tabFilters[selectedTab];
                          scrollController.animateTo(
                            scrollController.position.minScrollExtent,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeOut,
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: isSelected ? primary : white,
                            border: Border.all(
                              color: isSelected ? primary : white,
                            ),
                          ),
                          child: Text(
                            tabs[index],
                            style: TextStyle(
                              color: isSelected ? white : gray800,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: FormTextField(
                    inputType: TextInputType.text,
                    controller: searchController,
                    colortext: black,
                    name: 'userName',
                    color: white,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 10),
                        SvgPicture.asset('assets/svg/search.svg'),
                        SizedBox(width: 8),
                      ],
                    ),
                    hintText:
                        "${translateKey.translate('ger')}, ${translateKey.translate('search').toLowerCase()}",
                    hintTextColor: gray500,
                  ),
                ),
                SizedBox(width: 12),

                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: white,
                    border: Border.all(color: gray300),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: SvgPicture.asset('assets/svg/calendar.svg'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Column(
                      children: [1, 2, 3, 4, 5]
                          .map(
                            (item) => Column(
                              children: [OrderCard(), SizedBox(height: 12)],
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: mediaQuery.padding.bottom + 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
