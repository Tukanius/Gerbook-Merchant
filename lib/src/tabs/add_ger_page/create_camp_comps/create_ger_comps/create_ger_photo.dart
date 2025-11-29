import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant_gerbook_flutter/api/auth_api.dart';
import 'package:merchant_gerbook_flutter/components/controller/listen.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/upload_image.dart';
import 'package:merchant_gerbook_flutter/provider/camp_create_provider.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/auth/register_pages/register_stepper.dart/camera_page.dart';
import 'package:provider/provider.dart';

class CreateGerPhoto extends StatefulWidget {
  final PageController pageController;

  const CreateGerPhoto({super.key, required this.pageController});

  @override
  State<CreateGerPhoto> createState() => _CreateGerPhotoState();
}

class _CreateGerPhotoState extends State<CreateGerPhoto> {
  List<File> images = [];
  File? mainImage;

  bool isLoadingButton = false;
  XFile? file;
  final picker = ImagePicker();
  ListenController listenController = ListenController();

  Future showOptions(BuildContext context) async {
    final local = Provider.of<LocalizationProvider>(context, listen: false);
    if (mounted) {
      FocusScope.of(context).unfocus();
    }
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              local.translate('in_gallery'),
              style: TextStyle(
                color: black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              getImage(ImageSource.gallery);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              local.translate('take_photo'),
              style: TextStyle(
                color: black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              camera();
            },
          ),
        ],
      ),
    );
  }

  Future<void> pickImagesFromGallery() async {
    try {
      final List<XFile>? selectedImages = await picker.pickMultiImage(
        imageQuality: 40,
        maxHeight: 1024,
      );

      if (selectedImages != null && selectedImages.isNotEmpty) {
        setState(() {
          images.addAll(selectedImages.map((e) => File(e.path)));
        });
      }
    } catch (e) {
      debugPrint("Gallery image pick error: $e");
    }
  }

  getImage(ImageSource imageSource) async {
    try {
      var res = await picker.pickImage(
        source: imageSource,
        imageQuality: 40,
        maxHeight: 1024,
      );

      if (res != null && mounted) {
        setState(() {
          mainImage = File(res.path);
          file = res;
          // showImageError = false;
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  camera() {
    try {
      print("==============Camera controller==============");
      print(listenController);
      print("=============================================");
      Navigator.of(context).pushNamed(
        CameraPage.routeName,
        arguments: CameraPageArguments(listenController: listenController),
      );
    } catch (e) {
      print("Camera error: $e");
    }
  }

  onSubmit() async {
    if (mainImage != null && images.isNotEmpty) {
      try {
        UploadImage upload = UploadImage();
        UploadImage uploadImages = UploadImage();
        setState(() {
          isLoadingButton = true;
        });
        if (mainImage != null) {
          upload = await AuthApi().upload(mainImage!.path);
          await Provider.of<CampCreateProvider>(
            context,
            listen: false,
          ).updateGerMainPhoto(newGerMainImage: upload);
        }
        if (images.isNotEmpty) {
          List<UploadImage> uploadedUrls = [];

          for (var img in images) {
            uploadImages = await AuthApi().upload(img.path);
            uploadedUrls.add(uploadImages);
          }
          await Provider.of<CampCreateProvider>(
            context,
            listen: false,
          ).updateGerImages(newGerImages: uploadedUrls);
        }
        widget.pageController.nextPage(
          duration: Duration(microseconds: 1000),
          curve: Curves.ease,
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

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final translateKey = Provider.of<LocalizationProvider>(context);
    // final imageTool = Provider.of<CampCreateProvider>(context);
    return Scaffold(
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
                            translateKey.translate('insert_picture'),
                            style: TextStyle(
                              color: gray800,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '${translateKey.translate('please_insert_camp_picture')}',
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
                        '1/2',
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
                        mainImage == null
                            ? Container(
                                height: 267,
                                child: DottedBorder(
                                  options: RoundedRectDottedBorderOptions(
                                    dashPattern: [10, 5],
                                    strokeWidth: 1,
                                    radius: Radius.circular(16),
                                    color: gray400,
                                  ),
                                  child: Container(
                                    width: mediaQuery.size.width,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 50),
                                        SvgPicture.asset(
                                          'assets/svg/upload_image.svg',
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          translateKey.translate(
                                            'Ковер зураг нэмэх',
                                          ),
                                          style: TextStyle(
                                            color: primary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'PNG, JPG ${translateKey.translate('format')}',
                                          style: TextStyle(
                                            color: gray600,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        // SizedBox(height: 2),
                                        // Text(
                                        //   translateKey.translate(
                                        //     ' (Зургын хэмжээ томдоо 1200x1200)',
                                        //   ),
                                        //   style: TextStyle(
                                        //     color: gray600,
                                        //     fontSize: 12,
                                        //     fontWeight: FontWeight.w400,
                                        //   ),
                                        // ),
                                        SizedBox(height: 16),
                                        GestureDetector(
                                          onTap: () {
                                            showOptions(context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: primary,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 10,
                                            ),
                                            child: Text(
                                              translateKey.translate(
                                                'insert_picture',
                                              ),
                                              style: TextStyle(
                                                color: white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 50),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(16),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: mediaQuery.size.width,
                                      height: 267,
                                      child: Image.file(
                                        mainImage!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 12,
                                      right: 12,
                                      child: GestureDetector(
                                        onTap: isLoadingButton == true
                                            ? () {}
                                            : () {
                                                setState(() {
                                                  mainImage = null;
                                                });
                                              },
                                        child: SvgPicture.asset(
                                          'assets/svg/close_image.svg',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        SizedBox(height: 16),
                        images.isEmpty
                            ? DottedBorder(
                                options: RoundedRectDottedBorderOptions(
                                  dashPattern: [10, 5],
                                  strokeWidth: 1,
                                  radius: Radius.circular(16),
                                  color: gray400,
                                ),
                                child: Container(
                                  width: mediaQuery.size.width,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 50),
                                      SvgPicture.asset(
                                        'assets/svg/upload_image.svg',
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        translateKey.translate(
                                          'add_camp_image',
                                        ),
                                        style: TextStyle(
                                          color: primary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'PNG, JPG ${translateKey.translate('format')}',
                                        style: TextStyle(
                                          color: gray600,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      // SizedBox(height: 2),
                                      // Text(
                                      //   translateKey.translate(
                                      //     ' (Зургын хэмжээ томдоо 1200x1200)',
                                      //   ),
                                      //   style: TextStyle(
                                      //     color: gray600,
                                      //     fontSize: 12,
                                      //     fontWeight: FontWeight.w400,
                                      //   ),
                                      // ),
                                      SizedBox(height: 16),
                                      GestureDetector(
                                        onTap: () {
                                          pickImagesFromGallery();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: primary,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 10,
                                          ),
                                          child: Text(
                                            translateKey.translate(
                                              'insert_picture',
                                            ),
                                            style: TextStyle(
                                              color: white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 50),
                                    ],
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  Stack(
                                    children: [
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: images.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 14,
                                              mainAxisSpacing: 14,
                                              childAspectRatio: 1,
                                            ),
                                        itemBuilder: (context, index) {
                                          return Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.file(
                                                  images[index],
                                                  fit: BoxFit.cover,
                                                  width: mediaQuery.size.width,
                                                  height:
                                                      mediaQuery.size.height,
                                                ),
                                              ),
                                              Positioned(
                                                top: 8,
                                                right: 8,
                                                child: GestureDetector(
                                                  onTap: isLoadingButton == true
                                                      ? () {}
                                                      : () {
                                                          setState(() {
                                                            images.removeAt(
                                                              index,
                                                            );
                                                          });
                                                        },
                                                  child: SvgPicture.asset(
                                                    'assets/svg/close_image.svg',
                                                    height: 32,
                                                    width: 32,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: isLoadingButton == true
                                                  ? () {}
                                                  : () =>
                                                        pickImagesFromGallery(),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: white,
                                                  border: Border.all(
                                                    color: gray300,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        100,
                                                      ),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 10,
                                                    ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/svg/add_camp_info.svg',
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      translateKey.translate(
                                                        'add_more_images',
                                                      ),
                                                      style: const TextStyle(
                                                        color: gray700,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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
                  GestureDetector(
                    onTap: mainImage == null && images.isEmpty
                        ? () {}
                        : () {
                            onSubmit();
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        color: mainImage == null || images.isEmpty
                            ? primary200
                            : primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isLoadingButton == true
                              ? CustomLoader(loadColor: white)
                              : Text(
                                  translateKey.translate('continue'),
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                        ],
                      ),
                    ),
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
