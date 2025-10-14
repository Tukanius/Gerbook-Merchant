import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:provider/provider.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';

class GerCard extends StatefulWidget {
  const GerCard({super.key});

  @override
  State<GerCard> createState() => _GerCardState();
}

class _GerCardState extends State<GerCard> {
  bool status = true;
  @override
  Widget build(BuildContext context) {
    final translateKey = Provider.of<LocalizationProvider>(context);
    final mediaQuery = MediaQuery.of(context);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: mediaQuery.size.width,
            height: 178,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://placehold.co/178x178/gray5/gray50/png",
                ),
                fit: BoxFit.cover,
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: gray200),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Mongolian traditional house Ger',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Lato',
              color: gray900,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Text(
                translateKey.translate('merchant') + ':',
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: gray800,
                  fontSize: 12,
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
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : Text(
                      translateKey.translate('inactive'),
                      style: TextStyle(
                        fontFamily: 'Lato',
                        color: errorText,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
            ],
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Text(
                translateKey.translate('system_side') + ':',
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: gray800,
                  fontSize: 12,
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
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : Text(
                      translateKey.translate('inactive'),
                      style: TextStyle(
                        fontFamily: 'Lato',
                        color: errorText,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
            ],
          ),
          SizedBox(height: 2),
          Row(
            children: [
              SvgPicture.asset(
                'assets/svg/star_filled.svg',
                width: 14,
                height: 14,
              ),
              SizedBox(width: 2),
              Text(
                '4.5',
                style: TextStyle(
                  color: gray600,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: 2),
          IntrinsicHeight(
            child: Row(
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
                      'assets/svg/star.svg',
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
          ),
          SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '2,500,000₮',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: primary,
                ),
              ),
              SizedBox(width: 4),
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
        ],
      ),
    );
  }
}
