import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/tabs/add_ger_page/create_camp_comps/create_ger_comps/create_ger_info.dart';
import 'package:merchant_gerbook_flutter/src/tabs/add_ger_page/create_camp_comps/create_ger_comps/create_ger_photo.dart';
import 'package:provider/provider.dart';

class CreateGerPages extends StatefulWidget {
  static const routeName = "CreateGerPages";
  const CreateGerPages({super.key});

  @override
  State<CreateGerPages> createState() => _CreateGerPagesState();
}

class _CreateGerPagesState extends State<CreateGerPages>
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
          translateKey.translate('create_listing'),
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
          CreateGerPhoto(pageController: _pageController),
          CreateGerInfo(pageController: _pageController),
        ],
      ),
    );
  }
}
