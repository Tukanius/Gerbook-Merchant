import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/camp_list_data.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';

class CampCard extends StatefulWidget {
  final CampListData data;
  const CampCard({super.key, required this.data});

  @override
  State<CampCard> createState() => _CampCardState();
}

class _CampCardState extends State<CampCard> {
  @override
  Widget build(BuildContext context) {
    final translateKey = Provider.of<LocalizationProvider>(context);

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            height: 72,
            width: 72,
            child: BlurHash(
              color: gray100,
              hash: '${widget.data.mainImage!.blurhash}',
              image: '${widget.data.mainImage!.url}',
              imageFit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${widget.data.name}',
                      style: TextStyle(
                        color: gray900,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2),
              Text(
                '1234 ${translateKey.translate('ger')}',
                style: TextStyle(
                  color: gray800,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  SvgPicture.asset('assets/svg/map_pin.svg'),
                  SizedBox(width: 2),
                  Expanded(
                    child: Text(
                      '12 ${widget.data.addressString}',
                      style: TextStyle(
                        color: gray600,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
