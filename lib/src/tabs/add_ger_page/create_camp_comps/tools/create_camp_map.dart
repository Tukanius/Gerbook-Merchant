import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';

class CreateCampMap extends StatefulWidget {
  final Function(LatLng) saveLatLng;
  const CreateCampMap({super.key, required this.saveLatLng});

  @override
  State<CreateCampMap> createState() => _CreateCampMapState();
}

class _CreateCampMapState extends State<CreateCampMap> {
  MapLibreMapController? controller;

  void _onMapCreated(MapLibreMapController mapController) async {
    controller = mapController;

    // PNG icon-г map-д бүртгэж өгнө
    final ByteData bytes = await rootBundle.load('assets/images/map_pin.png');
    final Uint8List list = bytes.buffer.asUint8List();
    await mapController.addImage('custom-marker', list);
  }

  LatLng? selectedLocation;

  void _onMapClick(Point<double> point, LatLng coordinates) async {
    setState(() {
      selectedLocation = coordinates;
    });
    await controller?.clearSymbols();
    await controller?.addSymbol(
      SymbolOptions(
        geometry: coordinates,
        iconImage: 'custom-marker',
        iconSize: 3,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final translateKey = Provider.of<LocalizationProvider>(context);

    return Container(
      width: mediaQuery.size.width,
      height: mediaQuery.size.height * 0.9,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Stack(
        children: [
          Column(
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
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Text(
                  translateKey.translate('mark_on_map'),
                  style: TextStyle(
                    color: gray900,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(16),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: gray300),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: MapLibreMap(
                      styleString: 'assets/map_style.json',
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(47.9189, 106.9170),
                        zoom: 12.0,
                      ),
                      myLocationEnabled: false,
                      compassEnabled: false,
                      zoomGesturesEnabled: true,
                      scrollGesturesEnabled: true,
                      doubleClickZoomEnabled: true,
                      dragEnabled: true,
                      onMapClick: _onMapClick,
                      rotateGesturesEnabled: true,
                      trackCameraPosition: true,
                      tiltGesturesEnabled: true,
                      // attributionButtonMargins: Point(-1000, -1000),
                      attributionButtonMargins: Point(-100, -100),
                      attributionButtonPosition:
                          AttributionButtonPosition.topLeft,
                    ),
                  ),
                ),
              ),
              SizedBox(height: mediaQuery.padding.bottom + 60),
            ],
          ),
          Align(
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
                            Navigator.of(context).pop();
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  translateKey.translate('navigation_back'),
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
                            widget.saveLatLng(selectedLocation!);
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
                              mainAxisAlignment: MainAxisAlignment.center,
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
          ),
        ],
      ),
    );
  }
}
