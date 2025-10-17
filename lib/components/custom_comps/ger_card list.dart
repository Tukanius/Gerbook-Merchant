import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:provider/provider.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';

class GerCardList extends StatefulWidget {
  const GerCardList({super.key});

  @override
  State<GerCardList> createState() => _GerCardListState();
}

class _GerCardListState extends State<GerCardList> {
  bool status = true;
  @override
  Widget build(BuildContext context) {
    final translateKey = Provider.of<LocalizationProvider>(context);
    // final mediaQuery = MediaQuery.of(context);

    return Container(
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
                      child: Container(
                        height: 91,
                        width: 104,
                        child: Image.network(
                          'https://placehold.co/104x91/black10/gray50/png',
                          fit: BoxFit.cover,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      translateKey.translate('confirmed'),
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
                                      'Imperial Mount Resort in Terelj, Mongolia',
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
                              GestureDetector(
                                onTap: () {
                                  print('==testset==');
                                },
                                child: SvgPicture.asset(
                                  'assets/svg/horizontal_menu.svg',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: <Widget>[
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/home.svg',
                                    width: 14,
                                    height: 14,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    '1',
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: gray600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                              Container(
                                width: 1,
                                height: 10,
                                decoration: ShapeDecoration(
                                  color: gray600,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(320),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/heart.svg',
                                    width: 14,
                                    height: 14,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    '1',
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: gray600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                              Container(
                                width: 1,
                                height: 10,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: gray600,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(320),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/star_filled.svg',
                                    width: 14,
                                    height: 14,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    '1',
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: gray600,
                                    ),
                                  ),
                                ],
                              ),
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
                                    '2,500,000₮',
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
                                    '12',
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: gray800,
                                    ),
                                  ),
                                  Text(
                                    '${translateKey.translate('order')[0].toUpperCase()}${translateKey.translate('order').substring(1)}',
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: gray600,
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
                    status == false
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
                    status == true
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
    );
  }
}
