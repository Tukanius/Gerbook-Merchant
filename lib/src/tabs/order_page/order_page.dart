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
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final translateKey = Provider.of<LocalizationProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: false,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: Text(
          '${translateKey.translate('order')[0].toUpperCase()}${translateKey.translate('order').substring(1)}',
          style: TextStyle(
            color: gray800,
            fontSize: 18,
            fontWeight: FontWeight.w700,
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
                  width: 47,
                  height: 47,
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
                child: Column(
                  children: [1, 2, 3, 4, 5]
                      .map(
                        (item) => Column(
                          children: [OrderCard(), SizedBox(height: 12)],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
