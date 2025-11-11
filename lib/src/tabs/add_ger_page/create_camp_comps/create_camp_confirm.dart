import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';

class CreateCampConfirm extends StatefulWidget {
  final PageController pageController;

  const CreateCampConfirm({super.key, required this.pageController});

  @override
  State<CreateCampConfirm> createState() => _CreateCampConfirmState();
}

class _CreateCampConfirmState extends State<CreateCampConfirm> {
  CarouselSliderController carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final translateKey = Provider.of<LocalizationProvider>(context);
    final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(
      context,
    );
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: white,
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset('assets/svg/completed_step.svg'),
                      Expanded(child: Container(height: 2, color: gray200)),
                      SvgPicture.asset('assets/svg/completed_step.svg'),
                      Expanded(child: Container(height: 2, color: gray200)),
                      SvgPicture.asset('assets/svg/completed_step.svg'),
                      Expanded(child: Container(height: 2, color: gray200)),
                      SvgPicture.asset('assets/svg/completed_step.svg'),
                      Expanded(child: Container(height: 2, color: gray200)),
                      SvgPicture.asset('assets/svg/selected_step.svg'),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: gray100)),
                  ),
                  padding: EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              translateKey.translate('confirm'),
                              style: TextStyle(
                                color: gray800,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '${translateKey.translate('please_confirm_entered_info')}',
                              style: TextStyle(
                                color: gray600,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 14),
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(12),
                            child: Container(
                              width: mediaQuery.size.width,
                              height: 245,
                              child: Image.asset(
                                'assets/images/zurag.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // ClipRRect(
                          //   borderRadius: BorderRadius.only(
                          //     bottomLeft: Radius.circular(24),
                          //     bottomRight: Radius.circular(24),
                          //   ),
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       // Navigator.of(context).pushNamed(
                          //       //   FullScreenImage.routeName,
                          //       //   arguments: FullScreenImageArguments(
                          //       //     images: data.images!,
                          //       //   ),
                          //       // );
                          //     },
                          //     child: CarouselSlider(
                          //       carouselController: carouselController,
                          //       items: allImages.map((data) {
                          //         return Container(
                          //           width: MediaQuery.of(context).size.width,
                          //           height: MediaQuery.of(context).size.height *
                          //               0.45,
                          //           child: BlurHash(
                          //             color: gray100,
                          //             hash: '${data.blurhash}',
                          //             image: '${data.url}',
                          //             imageFit: BoxFit.cover,
                          //           ),
                          //         );
                          //         // Container(
                          //         //   width: MediaQuery.of(context).size.width,
                          //         //   height: MediaQuery.of(context).size.height * 0.45,
                          //         //   decoration: BoxDecoration(
                          //         //     image: DecorationImage(
                          //         //       image: NetworkImage(data.url!),
                          //         //       fit: BoxFit.cover,
                          //         //     ),
                          //         //   ),
                          //         //   // child: Container(
                          //         //   //   color: Colors.transparent,
                          //         //   // ),
                          //         // );
                          //       }).toList(),
                          //       options: CarouselOptions(
                          //         height:
                          //             MediaQuery.of(context).size.height * 0.45,
                          //         // enlargeCenterPage: true,
                          //         // autoPlay: true,
                          //         // aspectRatio: 16 / 9,
                          //         viewportFraction: 1,
                          //         onPageChanged: (index, reason) {
                          //           setState(() {
                          //             _currentIndex = index;
                          //           });
                          //         },
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: 16),
                          Text(
                            'NAME',
                            style: TextStyle(
                              color: gray800,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [1, 2, 3]
                                .map(
                                  (qwe) => GestureDetector(
                                    onTap: () {
                                      // setState(() {
                                      //   if (isSelected) {
                                      //     filterTag.remove(item.id);
                                      //     filterTagName.remove(item.name!);
                                      //   } else {
                                      //     filterTag.add(item.id!);
                                      //     filterTagName.add(item.name!);
                                      //   }
                                      // });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                        // border: Border.all(
                                        //   color: isSelected ? primary : gray200,
                                        // ),
                                        border: Border.all(color: gray200),
                                        color: white,
                                        // color: isSelected ? primary : white,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            height: 20,
                                            width: 20,
                                            'assets/images/zurag.png',
                                            fit: BoxFit.contain,
                                          ),
                                          // isSelected
                                          //     ? Image.network(
                                          //         height: 20,
                                          //         width: 20,
                                          //         'assets/images/zurag.png',
                                          //         fit: BoxFit.contain,
                                          //       )
                                          //     : Image.network(
                                          //         height: 20,
                                          //         width: 20,
                                          //         'assets/images/zurag.png',
                                          //         fit: BoxFit.contain,
                                          //       ),
                                          SizedBox(width: 5),
                                          Text(
                                            '123',
                                            // translateKey.translate(
                                            //   '${item.name}',
                                            // ),
                                            // '${item.name}',
                                            style: TextStyle(
                                              // color: isSelected
                                              //     ? white
                                              //     : gray800,
                                              color: gray800,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            //  placeTags.rows!.map((item) {
                            //   bool isSelected = filterTag.contains(item.id);
                            //   return GestureDetector(
                            //     onTap: () {
                            //       setState(() {
                            //         if (isSelected) {
                            //           filterTag.remove(item.id);
                            //           filterTagName.remove(item.name!);
                            //         } else {
                            //           filterTag.add(item.id!);
                            //           filterTagName.add(item.name!);
                            //         }
                            //       });
                            //     },
                            //     child: Container(
                            //       padding: EdgeInsets.symmetric(
                            //         horizontal: 12,
                            //         vertical: 6,
                            //       ),
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(
                            //           100,
                            //         ),
                            //         border: Border.all(
                            //           color: isSelected ? primary : gray200,
                            //         ),
                            //         color: isSelected ? primary : white,
                            //       ),
                            //       child: Row(
                            //         mainAxisSize: MainAxisSize.min,
                            //         children: [
                            //           isSelected
                            //               ? Image.network(
                            //                   height: 20,
                            //                   width: 20,
                            //                   '${item.selectedIcon}',
                            //                   fit: BoxFit.contain,
                            //                 )
                            //               : Image.network(
                            //                   height: 20,
                            //                   width: 20,
                            //                   '${item.icon}',
                            //                   fit: BoxFit.contain,
                            //                 ),
                            //           SizedBox(width: 5),
                            //           Text(
                            //             translateKey.translate(
                            //               '${item.name}',
                            //             ),
                            //             // '${item.name}',
                            //             style: TextStyle(
                            //               color: isSelected
                            //                   ? white
                            //                   : gray800,
                            //               fontSize: 14,
                            //               fontWeight: FontWeight.w400,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   );
                            // }).toList(),
                          ),
                          SizedBox(height: 16),
                          Text(
                            translateKey.translate('description'),
                            style: TextStyle(
                              color: gray900,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Terelj Star Resort is located in Gorkhi-Terelj Natural Park. It works 4 seasons a year and can accommodate 150 people at a time.',
                            style: TextStyle(
                              color: gray400,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translateKey.translate('place_offers'),
                                style: TextStyle(
                                  color: gray700,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 6),
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: [1, 2, 3]
                                    .map(
                                      (qwe) => GestureDetector(
                                        onTap: () {
                                          // setState(() {
                                          //   if (isSelected) {
                                          //     filterOffer.remove(item.id);
                                          //     filterOfferName.remove(item.name);
                                          //   } else {
                                          //     filterOffer.add(item.id!);
                                          //     filterOfferName.add(item.name!);
                                          //   }
                                          // });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                            border: Border.all(
                                              // color: isSelected ? primary : gray200,
                                              color: gray200,
                                            ),
                                            // color: isSelected ? primary : white,
                                            color: white,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                height: 22,
                                                width: 22,
                                                'assets/images/zurag.png',
                                                fit: BoxFit.contain,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                translateKey.translate(
                                                  // '${item.name}',
                                                  '1234',
                                                ),
                                                // '${item.name}',
                                                style: TextStyle(
                                                  // color: isSelected
                                                  //     ? white
                                                  //     : gray800,
                                                  color: gray800,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                //  placeOffers.rows!.map((item) {
                                //   bool isSelected = filterOffer.contains(
                                //     item.id,
                                //   );
                                //   return GestureDetector(
                                //     onTap: () {
                                //       setState(() {
                                //         if (isSelected) {
                                //           filterOffer.remove(item.id);
                                //           filterOfferName.remove(item.name);
                                //         } else {
                                //           filterOffer.add(item.id!);
                                //           filterOfferName.add(item.name!);
                                //         }
                                //       });
                                //     },
                                //     child: Container(
                                //       padding: EdgeInsets.symmetric(
                                //         horizontal: 12,
                                //         vertical: 6,
                                //       ),
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(
                                //           100,
                                //         ),
                                //         border: Border.all(
                                //           color: isSelected ? primary : gray200,
                                //         ),
                                //         color: isSelected ? primary : white,
                                //       ),
                                //       child: Row(
                                //         mainAxisSize: MainAxisSize.min,
                                //         children: [
                                //           Image.network(
                                //             height: 22,
                                //             width: 22,
                                //             '${item.image!.url}',
                                //             fit: BoxFit.contain,
                                //           ),
                                //           SizedBox(width: 8),
                                //           Text(
                                //             translateKey.translate(
                                //               '${item.name}',
                                //             ),
                                //             // '${item.name}',
                                //             style: TextStyle(
                                //               color: isSelected
                                //                   ? white
                                //                   : gray800,
                                //               fontSize: 14,
                                //               fontWeight: FontWeight.w400,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   );
                                // }).toList(),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            '${translateKey.translate('bed_numbers')}:',
                            style: TextStyle(
                              color: gray900,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '2 ${translateKey.translate('beds')}',
                                  style: TextStyle(
                                    color: gray600,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Container(
                            width: mediaQuery.size.width,
                            height: 1,
                            color: gray200,
                          ),
                          SizedBox(height: 16),
                          Text(
                            '${translateKey.translate('address_title')}:',
                            style: TextStyle(
                              color: gray900,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'БЗД, 21-р хороо',
                                  style: TextStyle(
                                    color: gray600,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    
                                  ),
                                  
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Container(
                            width: mediaQuery.size.width,
                            height: 1,
                            color: gray200,
                          ),
                          SizedBox(height: mediaQuery.padding.bottom + 150),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            !isKeyboardVisible
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: gray300)),
                        color: white,
                      ),
                      padding: EdgeInsets.only(
                        bottom: Platform.isIOS
                            ? MediaQuery.of(context).padding.bottom
                            : 16,
                        left: 16,
                        right: 16,
                        top: 16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    widget.pageController.previousPage(
                                      duration: Duration(microseconds: 1000),
                                      curve: Curves.ease,
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: white,
                                      border: Border.all(color: gray300),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          translateKey.translate(
                                            'navigation_back',
                                          ),
                                          style: TextStyle(
                                            color: gray700,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    widget.pageController.nextPage(
                                      duration: Duration(microseconds: 1000),
                                      curve: Curves.ease,
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: primary,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          translateKey.translate('continue'),
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
