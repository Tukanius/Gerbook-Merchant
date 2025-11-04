import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/tabs/add_ger_page/create_camp_comps/create_camp_confirm.dart';
import 'package:merchant_gerbook_flutter/src/tabs/add_ger_page/create_camp_comps/create_camp_location.dart';
import 'package:merchant_gerbook_flutter/src/tabs/add_ger_page/create_camp_comps/create_camp_name.dart';
import 'package:merchant_gerbook_flutter/src/tabs/add_ger_page/create_camp_comps/create_camp_photo.dart';
import 'package:merchant_gerbook_flutter/src/tabs/add_ger_page/create_camp_comps/create_camp_tags.dart';
import 'package:provider/provider.dart';

class CreateCampPages extends StatefulWidget {
  static const routeName = "CreateCampPages";
  const CreateCampPages({super.key});

  @override
  State<CreateCampPages> createState() => _CreateCampPagesState();
}

class _CreateCampPagesState extends State<CreateCampPages>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {});
    });
  }

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final translateKey = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            _pageController.page == 0
                ? Navigator.of(context).pop()
                : _pageController.previousPage(
                    duration: Duration(microseconds: 1000),
                    curve: Curves.ease,
                  );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SvgPicture.asset('assets/svg/chevron_left.svg')],
          ),
        ),
        centerTitle: false,
        title: Text(
          translateKey.translate('create_camp'),
          style: TextStyle(
            color: gray800,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          InkWell(
            highlightColor: transparent,
            splashColor: transparent,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                SvgPicture.asset('assets/svg/close.svg'),
                SizedBox(width: 16),
              ],
            ),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (int page) {
          setState(() {
            currentPage = page;
          });
        },
        children: [
          CreateCampPhoto(pageController: _pageController),
          CreateCampName(pageController: _pageController),
          CreateCampLocation(pageController: _pageController),
          CreateCampTags(pageController: _pageController),
          CreateCampConfirm(pageController: _pageController),
        ],
      ),
    );
  }
}
