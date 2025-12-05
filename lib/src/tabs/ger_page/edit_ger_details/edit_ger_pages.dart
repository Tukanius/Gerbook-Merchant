import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/tabs/ger_page/edit_ger_details/edit_ger_info.dart';
import 'package:merchant_gerbook_flutter/src/tabs/ger_page/edit_ger_details/edit_ger_photo.dart';
import 'package:provider/provider.dart';

class EditGerPagesArguments {
  final String campId;
  final String propertyId;

  EditGerPagesArguments({required this.campId, required this.propertyId});
}

class EditGerPages extends StatefulWidget {
  final String campId;
  final String propertyId;

  static const routeName = "EditGerPages";
  const EditGerPages({
    super.key,
    required this.campId,
    required this.propertyId,
  });

  @override
  State<EditGerPages> createState() => _EditGerPagesState();
}

class _EditGerPagesState extends State<EditGerPages>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();

  List<String>? gerPhotoList; // Зургуудын жагсаалт (URLs эсвэл Paths)
  String? mainGerImage; // Үндсэн зургийн path/URL

  // 🚩 2. Өгөгдлийг шинэчлэх функц
  void updateGerPhotos({
    required List<String>? photos,
    required String? mainImage,
  }) {
    setState(() {
      gerPhotoList = photos;
      mainGerImage = mainImage;
    });
    print('Photos updated in EditGerPages: Main Image is $mainGerImage');
  }

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
          EditGerPhoto(
            pageController: _pageController,
            onPhotosUpdated: updateGerPhotos,
          ),
          EditGerInfo(
            pageController: _pageController,
            campId: widget.campId,
            gerPhotoList: gerPhotoList, // Өгөгдлийг дамжуулж байна
            mainGerImage: mainGerImage,
            propertyId: widget.propertyId,
          ),
        ],
      ),
    );
  }
}
