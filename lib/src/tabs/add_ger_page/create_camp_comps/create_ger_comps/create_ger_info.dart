// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/components/ui/form_textfield.dart';
import 'package:merchant_gerbook_flutter/models/camp_create_model.dart';

import 'package:merchant_gerbook_flutter/models/camp_data_edit.dart';
import 'package:merchant_gerbook_flutter/models/create_camp_property.dart';
import 'package:merchant_gerbook_flutter/provider/camp_create_provider.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';

class CreateGerInfo extends StatefulWidget {
  final bool updateCamp;
  final String campId;

  final PageController pageController;

  const CreateGerInfo({
    super.key,
    required this.pageController,
    required this.updateCamp,
    required this.campId,
  });

  @override
  State<CreateGerInfo> createState() => _CreateGerInfoState();
}

class _CreateGerInfoState extends State<CreateGerInfo> with AfterLayoutMixin {
  bool isLoadingPage = true;
  CampDataEdit data = CampDataEdit();

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      if (widget.updateCamp == true) {
        data = await ProductApi().getCampData(widget.campId);
        print('===test====');
        print(widget.updateCamp);
        print(widget.campId);
        print(data.name);
        print('===test====');
      }

      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = false;
      });
    }
  }

  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();

  TextEditingController gerNameController = TextEditingController();
  TextEditingController gerDescriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController originalPriceController = TextEditingController();

  TextEditingController bedController = TextEditingController(text: '0');
  TextEditingController maxPersonController = TextEditingController(text: '0');
  TextEditingController quantityController = TextEditingController(text: '0');

  bool isLoading = false;
  int bedsCount = 0;
  // hymdral ni price
  int price = 0;
  // orig une ni originalPrice
  int originalPrice = 0;
  int maxPersonCount = 0;
  int quantity = 0;
  bool isLoadingButton = false;

  bool quantityError = false;
  bool bedError = false;
  bool maxPersonError = false;

  onSubmit() async {
    if (quantity == 0) {
      setState(() {
        quantityError = true;
      });
    } else {
      setState(() {
        quantityError = false;
      });
    }
    if (bedsCount == 0) {
      setState(() {
        bedError = true;
      });
    } else {
      setState(() {
        bedError = false;
      });
    }
    if (maxPersonCount == 0) {
      setState(() {
        maxPersonError = true;
      });
    } else {
      setState(() {
        maxPersonError = false;
      });
    }

    if (fbkey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isLoadingButton = true;
        });
        await Provider.of<CampCreateProvider>(
          context,
          listen: false,
        ).updateGerName(newGerName: gerNameController.text);

        await Provider.of<CampCreateProvider>(
          context,
          listen: false,
        ).updateGerDescription(
          newGerDescription: gerDescriptionController.text,
        );

        await Provider.of<CampCreateProvider>(
          context,
          listen: false,
        ).updateGerPrice(newGerPrice: num.parse(priceController.text));

        await Provider.of<CampCreateProvider>(
          context,
          listen: false,
        ).updateOriginalPrice(
          newGerOriginalPrice: num.parse(originalPriceController.text),
        );

        await Provider.of<CampCreateProvider>(
          context,
          listen: false,
        ).updateGerBed(newGerBed: bedController.text);
        await Provider.of<CampCreateProvider>(
          context,
          listen: false,
        ).updateGerMaxPerson(newGerMaxPerson: maxPersonController.text);

        await Provider.of<CampCreateProvider>(
          context,
          listen: false,
        ).updateGerQuantity(newGerQuantity: quantityController.text);

        Navigator.of(context).pop();
        setState(() {
          isLoadingButton = false;
        });
      } catch (e) {
        setState(() {
          isLoadingButton = false;
        });
      }
    }
  }

  onSubmitUpdateCamp() async {
    if (quantity == 0) {
      setState(() {
        quantityError = true;
      });
    } else {
      setState(() {
        quantityError = false;
      });
    }
    if (bedsCount == 0) {
      setState(() {
        bedError = true;
      });
    } else {
      setState(() {
        bedError = false;
      });
    }
    if (maxPersonCount == 0) {
      setState(() {
        maxPersonError = true;
      });
    } else {
      setState(() {
        maxPersonError = false;
      });
    }

    if (fbkey.currentState!.saveAndValidate()) {
      final translateKey = Provider.of<LocalizationProvider>(
        context,
        listen: false,
      );

      try {
        setState(() {
          isLoadingButton = true;
        });
        final createCampRoot = Provider.of<CampCreateProvider>(
          context,
          listen: false,
        );
        CampCreateModel campData = CampCreateModel();

        await Provider.of<CampCreateProvider>(
          context,
          listen: false,
        ).updateGerName(newGerName: gerNameController.text);

        await Provider.of<CampCreateProvider>(
          context,
          listen: false,
        ).updateGerDescription(
          newGerDescription: gerDescriptionController.text,
        );

        await Provider.of<CampCreateProvider>(
          context,
          listen: false,
        ).updateGerPrice(
          newGerPrice: priceController.text != ''
              ? num.parse(priceController.text)
              : 0,
        );

        await Provider.of<CampCreateProvider>(
          context,
          listen: false,
        ).updateOriginalPrice(
          newGerOriginalPrice: originalPriceController.text != ''
              ? num.parse(originalPriceController.text)
              : 0,
        );

        await Provider.of<CampCreateProvider>(
          context,
          listen: false,
        ).updateGerBed(newGerBed: bedController.text);
        await Provider.of<CampCreateProvider>(
          context,
          listen: false,
        ).updateGerMaxPerson(newGerMaxPerson: maxPersonController.text);

        await Provider.of<CampCreateProvider>(
          context,
          listen: false,
        ).updateGerQuantity(newGerQuantity: quantityController.text);

        print('====yesy====');
        print('${data.properties?.length}');
        // print(
        //   data.properties!.map((p) {
        //     print(p.id);
        //     // return CreateCampProperty(
        //     //   id: p.id,
        //     //   name: p.name,
        //     //   description: p.description,
        //     //   images: p.images != null || p.images != []
        //     //       ? p.images!
        //     //             .map((tagObject) => tagObject.url)
        //     //             .cast<String>()
        //     //             .toList()
        //     //       : [],
        //     //   mainImage: p.mainImage?.url ?? null,
        //     //   bedsCount: p.bedsCount?.toInt(),
        //     //   price: p.price,
        //     //   originalPrice: p.originalPrice,
        //     //   maxPersonCount: p.maxPersonCount,
        //     //   quantity: p.quantity,
        //     // );
        //   }),
        // );
        print('====yesy====');

        campData.properties = [
          ...data.properties!.map((p) {
            return CreateCampProperty(
              id: p.id,
              name: p.name,
              description: p.description,
              images: p.images != null || p.images != []
                  ? p.images!
                        .map((tagObject) => tagObject.url)
                        .cast<String>()
                        .toList()
                  : [],
              mainImage: p.mainImage?.url ?? null,
              bedsCount: p.bedsCount?.toInt(),
              price: p.price,
              originalPrice: p.originalPrice,
              maxPersonCount: p.maxPersonCount,
              quantity: p.quantity,
            );
          }),
          /*
          {
      "_id": "692e83a93359a0b08b913652",
      "name": "ger test update",
      "description": "gers",
      "images": [
        "https://gerbook.s3.ap-southeast-1.amazonaws.com/3195ae77-0c29-490d-a00e-0c3a63d505c3-1024.jpg"
      ],
      "mainImage": "https://gerbook.s3.ap-southeast-1.amazonaws.com/3195ae77-0c29-490d-a00e-0c3a63d505c3-1024.jpg",
      "bedsCount": 1,
      "price": 133,
      "originalPrice": 1234,
      "maxPersonCount": 1,
      "quantity": 1
    },
           */
          CreateCampProperty(
            name: createCampRoot.gerName,
            description: createCampRoot.gerDescription,
            images: createCampRoot.gerImages
                .map((tagObject) => tagObject.url)
                .cast<String>()
                .toList(),
            mainImage: createCampRoot.gerMainImage.url,
            bedsCount: int.tryParse(createCampRoot.gerBedCount),
            price: createCampRoot.gerPrice,
            originalPrice: createCampRoot.gerOriginalPrice,
            maxPersonCount: int.tryParse(createCampRoot.gerMaxPerson),
            quantity: int.tryParse(createCampRoot.gerQuantity),
          ),
        ];

        await ProductApi().putProperty(campData, widget.campId);

        await showCreateSuccess(
          context,
          '${translateKey.translate('listing_created_successfully')}',
        );
        setState(() {
          isLoadingButton = false;
        });
      } catch (e) {
        setState(() {
          isLoadingButton = false;
        });
      }
    }
  }

  showCreateSuccess(context, String text) async {
    final local = Provider.of<LocalizationProvider>(context, listen: false);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SvgPicture.asset('assets/svg/success1.svg'),
                Text(
                  local.translate('successful'),
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '$text',
                  style: TextStyle(
                    color: gray600,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
                ButtonBar(
                  buttonMinWidth: 100,
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                      ),
                      child: Text(
                        local.translate('close'),
                        style: TextStyle(
                          color: black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final translateKey = Provider.of<LocalizationProvider>(context);
    final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(
      context,
    );
    String? discountedPriceValidator(String? discountedPrice) {
      // 1. Үндсэн үнийн контроллероос утгыг авна.
      final originalPriceText = originalPriceController.text;

      // 2. Утгуудыг тоонд хөрвүүлнэ (null эсвэл хоосон бол 0 гэж үзье).
      final double originalPrice = double.tryParse(originalPriceText) ?? 0.0;
      final double discountPrice =
          double.tryParse(discountedPrice ?? '') ?? 0.0;

      // 3. Заавал бөглөх шалгалт (required)
      if (discountedPrice == null || discountedPrice.isEmpty) {
        // Таны 'required' алдааны текстийг буцаана.
        return translateKey.translate('ta_uuriyn_medeelliyg_65b43f00');
      }

      // 4. Үндсэн харьцуулалт
      if (discountPrice >= originalPrice) {
        // Хэрэв хямдралтай үнэ үндсэн үнээс их байвал алдааг буцаана.
        return translateKey.translate(
          'discounted_price_cannot_be_original_price',
        );
      }

      // 5. Зөв бол null буцаана.
      return null;
    }

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
                              translateKey.translate('ger'),
                              style: TextStyle(
                                color: gray800,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '${translateKey.translate('ta_uuriyn_medeelliyg_65b43f00')}',
                              style: TextStyle(
                                color: gray600,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: white,
                          border: Border.all(color: gray300),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '2/2',
                          style: TextStyle(
                            color: gray800,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
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
                        children: [
                          SizedBox(height: 16),
                          FormBuilder(
                            key: fbkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormTextField(
                                  inputType: TextInputType.text,
                                  controller: gerNameController,
                                  colortext: black,
                                  name: 'name',
                                  color: white,
                                  hintText: "${translateKey.translate('name')}",
                                  hintTextColor: gray500,
                                  labelColor: gray700,
                                  labelText:
                                      "${translateKey.translate('name')} ",
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                      errorText: translateKey.translate(
                                        'ta_uuriyn_medeelliyg_65b43f00',
                                      ),
                                    ),
                                  ]),
                                ),
                                SizedBox(height: 16),
                                FormTextField(
                                  inputType: TextInputType.text,
                                  controller: gerDescriptionController,
                                  colortext: black,
                                  name: 'description',
                                  color: white,
                                  suffixIcon: null,
                                  hintText:
                                      "${translateKey.translate('description')}",
                                  hintTextColor: gray500,
                                  labelColor: gray700,
                                  labelText:
                                      "${translateKey.translate('description')}",
                                  maxLines: 5,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                      errorText: translateKey.translate(
                                        'ta_uuriyn_medeelliyg_65b43f00',
                                      ),
                                    ),
                                  ]),
                                ),
                                SizedBox(height: 16),
                                FormTextField(
                                  inputType: TextInputType.number,
                                  controller: originalPriceController,
                                  colortext: black,
                                  name: 'originalPrice',
                                  color: white,
                                  hintText:
                                      "${translateKey.translate('original_price')}",
                                  hintTextColor: gray500,
                                  labelColor: gray700,
                                  labelText:
                                      "${translateKey.translate('original_price')} ",

                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                      errorText: translateKey.translate(
                                        'ta_uuriyn_medeelliyg_65b43f00',
                                      ),
                                    ),
                                  ]),
                                ),

                                SizedBox(height: 16),
                              ],
                            ),
                          ),

                          FormTextField(
                            inputType: TextInputType.number,
                            controller: priceController,
                            colortext: black,
                            name: 'price',
                            color: white,
                            hintText:
                                "${translateKey.translate('discounted_price')}",
                            hintTextColor: gray500,
                            labelColor: gray700,
                            labelText:
                                "${translateKey.translate('discounted_price')}",
                            validator: (value) =>
                                discountedPriceValidator(value),
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    translateKey.translate('ger_count'),
                                    style: TextStyle(
                                      color: gray700,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: white,
                                      border: Border.all(color: gray300),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              quantity++;
                                              quantityController.text = quantity
                                                  .toString();
                                            });
                                          },
                                          child: SvgPicture.asset(
                                            'assets/svg/plus.svg',
                                            height: 24,
                                            width: 24,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Container(
                                          width: 60,
                                          child: TextField(
                                            controller: quantityController,
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: gray800,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                int parsed =
                                                    int.tryParse(value) ?? 0;
                                                if (parsed < 0) parsed = 0;
                                                quantity = parsed;
                                                quantityController.text =
                                                    quantity.toString();
                                                quantityController.selection =
                                                    TextSelection.fromPosition(
                                                      TextPosition(
                                                        offset:
                                                            quantityController
                                                                .text
                                                                .length,
                                                      ),
                                                    );
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (quantity > 0) {
                                                quantity--;
                                                quantityController.text =
                                                    quantity.toString();
                                              }
                                            });
                                          },
                                          child: SvgPicture.asset(
                                            'assets/svg/minus.svg',
                                            height: 24,
                                            width: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              quantityError == true
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${translateKey.translate('this_field_is_required')}',
                                          style: TextStyle(
                                            color: redButton,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                      ],
                                    )
                                  : SizedBox(),
                            ],
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    translateKey.translate('bed_numbers'),
                                    style: TextStyle(
                                      color: gray700,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: white,
                                      border: Border.all(color: gray300),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      children: [
                                        // ➕ Нэмэх товч
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              bedsCount++;
                                              bedController.text = bedsCount
                                                  .toString();
                                            });
                                          },
                                          child: SvgPicture.asset(
                                            'assets/svg/plus.svg',
                                            height: 24,
                                            width: 24,
                                          ),
                                        ),

                                        SizedBox(width: 8),

                                        // Тоо харуулах input
                                        Container(
                                          width: 60,
                                          child: TextField(
                                            controller: bedController,
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: gray800,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                int parsed =
                                                    int.tryParse(value) ?? 0;
                                                if (parsed < 0) parsed = 0;
                                                bedsCount = parsed;
                                                bedController.text = bedsCount
                                                    .toString();
                                                bedController.selection =
                                                    TextSelection.fromPosition(
                                                      TextPosition(
                                                        offset: bedController
                                                            .text
                                                            .length,
                                                      ),
                                                    );
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (bedsCount > 0) {
                                                bedsCount--;
                                                bedController.text = bedsCount
                                                    .toString();
                                              }
                                            });
                                          },
                                          child: SvgPicture.asset(
                                            'assets/svg/minus.svg',
                                            height: 24,
                                            width: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              bedError == true
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${translateKey.translate('this_field_is_required')}',
                                          style: TextStyle(
                                            color: redButton,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                      ],
                                    )
                                  : SizedBox(),
                            ],
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    translateKey.translate('number_of_people'),
                                    style: TextStyle(
                                      color: gray700,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: white,
                                      border: Border.all(color: gray300),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              maxPersonCount++;
                                              maxPersonController.text =
                                                  maxPersonCount.toString();
                                            });
                                          },
                                          child: SvgPicture.asset(
                                            'assets/svg/plus.svg',
                                            height: 24,
                                            width: 24,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Container(
                                          width: 60,
                                          child: TextField(
                                            controller: maxPersonController,
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: gray800,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                int parsed =
                                                    int.tryParse(value) ?? 0;
                                                if (parsed < 0) parsed = 0;
                                                maxPersonCount = parsed;
                                                maxPersonController.text =
                                                    maxPersonCount.toString();
                                                maxPersonController.selection =
                                                    TextSelection.fromPosition(
                                                      TextPosition(
                                                        offset:
                                                            maxPersonController
                                                                .text
                                                                .length,
                                                      ),
                                                    );
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (maxPersonCount > 0) {
                                                maxPersonCount--;
                                                maxPersonController.text =
                                                    maxPersonCount.toString();
                                              }
                                            });
                                          },
                                          child: SvgPicture.asset(
                                            'assets/svg/minus.svg',
                                            height: 24,
                                            width: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              maxPersonError == true
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${translateKey.translate('this_field_is_required')}',
                                          style: TextStyle(
                                            color: redButton,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                      ],
                                    )
                                  : SizedBox(),
                            ],
                          ),
                          SizedBox(height: mediaQuery.padding.bottom + 80),
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
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: isLoadingButton == true
                                      ? () {}
                                      : () {
                                          widget.updateCamp == true
                                              ? onSubmitUpdateCamp()
                                              : onSubmit();
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
