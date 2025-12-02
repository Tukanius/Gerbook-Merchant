import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/camp_list_data.dart';
import 'package:merchant_gerbook_flutter/src/tabs/ger_page/ger_detail_page.dart';
import 'package:merchant_gerbook_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';

class GerCardList extends StatefulWidget {
  final CampListData data;
  const GerCardList({super.key, required this.data});

  @override
  State<GerCardList> createState() => _GerCardListState();
}

class _GerCardListState extends State<GerCardList> {
  bool status = true;
  @override
  Widget build(BuildContext context) {
    final translateKey = Provider.of<LocalizationProvider>(context);
    // final mediaQuery = MediaQuery.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          GerDetailPage.routeName,
          arguments: GerDetailPageArguments(id: widget.data.id!),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: white,
          border: Border.all(color: gray200),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(4),
                        child: SizedBox(
                          height: 104,
                          width: 104,
                          child: BlurHash(
                            color: gray100,
                            hash: '${widget.data.mainImage?.blurhash}',
                            image: '${widget.data.mainImage?.url}',
                            imageFit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${translateKey.translate('${widget.data.status}')}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          color: greenSuccess,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        '${widget.data.name ?? "-"}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          color: gray800,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                // GestureDetector(
                                //   onTap: () {
                                //     print('==testset==');
                                //   },
                                //   child: SvgPicture.asset(
                                //     'assets/svg/horizontal_menu.svg',
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/calendar.svg',
                                  height: 14,
                                  width: 14,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    widget.data.isOpenYearRound == true
                                        ? '${translateKey.translate('open_year_round')}'
                                        : '${translateKey.translate('seasonal_operation')}',
                                    style: TextStyle(
                                      color: widget.data.isOpenYearRound == true
                                          ? textBlue
                                          : gray800,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),

                                // Row(
                                //   children: [
                                //     SvgPicture.asset(
                                //       'assets/svg/home.svg',
                                //       width: 14,
                                //       height: 14,
                                //     ),
                                //     SizedBox(width: 2),
                                //     Text(
                                //       '0',
                                //       style: TextStyle(
                                //         fontFamily: 'Lato',
                                //         fontSize: 12,
                                //         fontWeight: FontWeight.w400,
                                //         color: gray600,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(width: 10),
                                // Container(
                                //   width: 1,
                                //   height: 10,
                                //   decoration: ShapeDecoration(
                                //     color: gray600,
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(320),
                                //     ),
                                //   ),
                                // ),
                                // SizedBox(width: 10),
                                // Row(
                                //   children: [
                                //     SvgPicture.asset(
                                //       'assets/svg/heart.svg',
                                //       width: 14,
                                //       height: 14,
                                //     ),
                                //     SizedBox(width: 2),
                                //     Text(
                                //       '0',
                                //       style: TextStyle(
                                //         fontFamily: 'Lato',
                                //         fontSize: 12,
                                //         fontWeight: FontWeight.w400,
                                //         color: gray600,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(width: 10),
                                // Container(
                                //   width: 1,
                                //   height: 10,
                                //   clipBehavior: Clip.antiAlias,
                                //   decoration: ShapeDecoration(
                                //     color: gray600,
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(320),
                                //     ),
                                //   ),
                                // ),
                                // SizedBox(width: 10),
                                // Row(
                                //   children: [
                                //     SvgPicture.asset(
                                //       'assets/svg/star_filled.svg',
                                //       width: 14,
                                //       height: 14,
                                //     ),
                                //     SizedBox(width: 2),
                                //     Text(
                                //       '0',
                                //       style: TextStyle(
                                //         fontFamily: 'Lato',
                                //         fontSize: 12,
                                //         fontWeight: FontWeight.w400,
                                //         color: gray600,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${Utils().formatCurrencyDouble(widget.data.price?.toDouble() ?? 0)}₮',
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: primary,
                                      ),
                                    ),
                                    Text(
                                      translateKey.translate('nights'),
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: gray600,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${translateKey.translate('status')}',
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: gray600,
                                      ),
                                    ),
                                    Text(
                                      // '${translateKey.translate('order')[0].toUpperCase()}${translateKey.translate('order').substring(1)}',
                                      // '${widget.data.status[0].}',
                                      widget.data.status == "CONFIRMED"
                                          ? '${translateKey.translate('confirmed')}'
                                          : widget.data.status == "NEW"
                                          ? '${translateKey.translate('new')}'
                                          : '',
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: gray800,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              decoration: ShapeDecoration(
                color: gray200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(320),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        translateKey.translate('merchant') + ':',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          color: gray800,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 4),
                      widget.data.isActive == true
                          ? Text(
                              translateKey.translate('active'),
                              style: TextStyle(
                                fontFamily: 'Lato',
                                color: greenSuccess,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : Text(
                              translateKey.translate('inactive'),
                              style: TextStyle(
                                fontFamily: 'Lato',
                                color: errorText,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        translateKey.translate('system_side') + ':',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          color: gray800,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 4),
                      widget.data.isAdminActive == true
                          ? Text(
                              translateKey.translate('active'),
                              style: TextStyle(
                                fontFamily: 'Lato',
                                color: greenSuccess,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : Text(
                              translateKey.translate('inactive'),
                              style: TextStyle(
                                fontFamily: 'Lato',
                                color: errorText,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
