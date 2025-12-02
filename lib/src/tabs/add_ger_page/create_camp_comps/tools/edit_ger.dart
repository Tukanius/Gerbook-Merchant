// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/provider/camp_create_provider.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/tabs/add_ger_page/create_camp_comps/create_ger_comps/create_ger_pages.dart';
import 'package:provider/provider.dart';

class EditGer extends StatefulWidget {
  const EditGer({super.key});

  @override
  State<EditGer> createState() => _EditGerState();
}

class _EditGerState extends State<EditGer> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final translateKey = Provider.of<LocalizationProvider>(context);
    final campProvider = Provider.of<CampCreateProvider>(context, listen: true);

    return Container(
      width: mediaQuery.size.width,
      // height: mediaQuery.size.height * 0.9,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 6),
          Center(
            child: Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: gray800,
              ),
            ),
          ),
          SizedBox(height: 6),
          Container(
            padding: EdgeInsets.all(14),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: SizedBox(
                    height: 72,
                    width: 72,
                    child: BlurHash(
                      color: gray100,
                      hash: '${campProvider.gerMainImage.blurhash}',
                      image: '${campProvider.gerMainImage.url}',
                      imageFit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${campProvider.gerName}',
                        style: TextStyle(
                          color: gray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          SvgPicture.asset('assets/svg/ger_bed.svg'),
                          SizedBox(width: 2),
                          Text(
                            '${campProvider.gerBedCount}',
                            style: TextStyle(
                              color: gray600,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 12),
                          SvgPicture.asset('assets/svg/ger_person.svg'),
                          SizedBox(width: 2),
                          Text(
                            '${campProvider.gerMaxPerson}',
                            style: TextStyle(
                              color: gray600,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Text(
                        '₮${campProvider.gerPrice}',
                        style: TextStyle(
                          color: primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).popAndPushNamed(
                CreateGerPages.routeName,
                arguments: CreateGerPagesArguments(
                  campUpdate: false,
                  campId: '',
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  SizedBox(width: 16),
                  SvgPicture.asset('assets/svg/edit.svg'),
                  SizedBox(width: 8),
                  Text(
                    '${translateKey.translate('zasah')}',
                    style: TextStyle(
                      color: gray800,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              campProvider.clearGer();
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  SizedBox(width: 16),
                  SvgPicture.asset('assets/svg/delete_ger.svg'),
                  SizedBox(width: 8),
                  Text(
                    '${translateKey.translate('delete')}',
                    style: TextStyle(
                      color: gray800,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 150),
        ],
      ),
    );
  }
}
