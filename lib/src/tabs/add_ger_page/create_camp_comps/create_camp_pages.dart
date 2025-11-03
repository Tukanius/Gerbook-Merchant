import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/src/tabs/add_ger_page/create_camp_comps/create_camp_photo.dart';

class CreateCampPages extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('data')],
          ),
        ),
        centerTitle: true,
        title: Text(
          'create camp',
          style: TextStyle(
            color: black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        // title: Row(
        //   children: [
        //     _currentPage != 0
        //         ? Row(
        //             children: [
        //               GestureDetector(
        //                 onTap: () {
        //                   _pageController.previousPage(
        //                     duration: Duration(microseconds: 1000),
        //                     curve: Curves.ease,
        //                   );
        //                 },
        //                 child: SvgPicture.asset('assets/svg/back_button.svg'),
        //               ),
        //               SizedBox(width: 12),
        //             ],
        //           )
        //         : SizedBox(),
        //     Expanded(
        //       flex: _currentPage == 0 ? 2 : 1,
        //       child: AnimatedContainer(
        //         duration: const Duration(milliseconds: 300),
        //         height: 5,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(12),
        //           color: primary,
        //         ),
        //       ),
        //     ),
        //     const SizedBox(width: 4),
        //     Expanded(
        //       flex: _currentPage == 1 ? 2 : 1,
        //       child: AnimatedContainer(
        //         duration: const Duration(milliseconds: 300),
        //         height: 5,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(12),
        //           color: _currentPage >= 1 ? primary : primary50,
        //         ),
        //       ),
        //     ),
        //     const SizedBox(width: 4),
        //     Expanded(
        //       flex: _currentPage == 2 ? 2 : 1,
        //       child: AnimatedContainer(
        //         duration: const Duration(milliseconds: 300),
        //         height: 5,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(12),
        //           color: _currentPage == 2 ? primary : primary50,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
      body: CreateCampPhoto(pageController: _pageController),
      // PageView(
      //   controller: _pageController,
      //   physics: NeverScrollableScrollPhysics(),
      //   onPageChanged: (int page) {
      //     setState(() {
      //       _currentPage = page;
      //     });
      //   },
      //   children: [
      //     RegisterInfoPage(
      //       pageController: _pageController,
      //     ),
      //     RegisterGenderPage(
      //       pageController: _pageController,
      //     ),
      //     RegisterAddressPage(),
      //   ],
      // ),
    );
  }
}
