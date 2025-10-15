import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/ger_card%20list.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/ger_card.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/order_card.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/components/ui/form_textfield.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';

class GerPage extends StatefulWidget {
  const GerPage({super.key});

  @override
  State<GerPage> createState() => _GerPageState();
}

class _GerPageState extends State<GerPage> {
  ScrollController scrollController = ScrollController();
  final items = List.generate(400, (index) => '$index');
  int filterIndex = 0;
  bool filter = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final translateKey = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        shape: Border(bottom: BorderSide(color: gray200, width: 2)),
        elevation: 0,
        centerTitle: false,
        backgroundColor: white,
        automaticallyImplyLeading: false,
        title: Text(
          '${translateKey.translate('my_ger')[0].toUpperCase()}${translateKey.translate('my_ger').substring(1)}',
          style: TextStyle(
            color: gray800,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              print('==testset==');
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 14,
                    top: 8,
                    bottom: 8,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: gray300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        translateKey.translate('create_listing'),
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: gray700,
                        ),
                      ),
                      SizedBox(width: 8),
                      SvgPicture.asset('assets/svg/plus.svg'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
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
                        SvgPicture.asset('assets/svg/search.svg', height: 20),
                        SizedBox(width: 8),
                      ],
                    ),
                    hintText:
                        "${translateKey.translate('ger')} ${translateKey.translate('search').toLowerCase()}",
                    hintTextColor: gray500,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    print('Working');
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: white,
                      border: Border.all(color: gray300),
                    ),
                    child: filter == true
                        ? Center(
                            child: SvgPicture.asset('assets/svg/calendar.svg'),
                          )
                        : Stack(
                            children: [
                              Center(
                                child: SvgPicture.asset(
                                  'assets/svg/calendar.svg',
                                ),
                              ),
                              Positioned(
                                top: 3,
                                right: 3,
                                child: Container(
                                  height: 12,
                                  width: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                    border: Border.all(
                                      color: white,
                                      width: 2,
                                      strokeAlign: BorderSide.strokeAlignInside,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [1, 2, 3, 4, 5]
                          .map(
                            (item) => Column(
                              children: [GerCardList(), SizedBox(height: 12)],
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: mediaQuery.padding.bottom + 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
