import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant_gerbook_flutter/api/auth_api.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/controller/listen.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/avatar_upload.dart';
import 'package:merchant_gerbook_flutter/models/upload_image.dart';
import 'package:merchant_gerbook_flutter/models/user.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/auth/register_pages/register_stepper.dart/camera_page.dart';
import 'package:merchant_gerbook_flutter/src/profile_page/profile_page/edit_bank.dart';
import 'package:merchant_gerbook_flutter/src/profile_page/profile_page/edit_email.dart';
import 'package:merchant_gerbook_flutter/src/profile_page/profile_page/edit_name.dart';
import 'package:merchant_gerbook_flutter/src/profile_page/profile_page/edit_socials.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "ProfilePage";

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with AfterLayoutMixin {
  User user = User();
  bool isLoadingPage = true;
  ListenController listenController = ListenController();
  final picker = ImagePicker();

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await callUser();
  }

  callUser() async {
    try {
      setState(() {
        isLoadingPage = true;
      });
      user = await AuthApi().me(false);
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
  }

  File? image;
  XFile? file;

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

  UploadImage upload = UploadImage();

  getImage(ImageSource imageSource) async {
    try {
      var res = await picker.pickImage(
        source: imageSource,
        imageQuality: 40,
        maxHeight: 1024,
      );

      if (res != null && mounted) {
        setState(() {
          image = File(res.path);
          file = res;

          // showImageError = false;
        });
      }
      setState(() {
        isLoadingImage = true;
      });
      User save = User();
      if (image != null) {
        upload = await AuthApi().upload(image!.path);
        save.avatar = upload.url;
        save.firstName = user.firstName ?? '';
        save.lastName = user.lastName ?? '';
        save.registerNo = user.registerNo ?? '';
      }
      await ProductApi().putNames(save);
      setState(() {
        isLoadingImage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingImage = true;
      });
      print("Error picking image: $e");
    }
  }

  bool isLoadingImage = false;
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

  bool isTake = false;
  @override
  void initState() {
    listenController.addListener(() async {
      listenController.value != null
          ? setState(() async {
              isTake = true;
              image = File(listenController.value!);

              setState(() {
                isLoadingImage = true;
              });
              User save = User();
              if (image != null) {
                upload = await AuthApi().upload(image!.path);
                save.avatar = upload.url;
                save.firstName = user.firstName ?? '';
                save.lastName = user.lastName ?? '';
                save.registerNo = user.registerNo ?? '';
              }
              await ProductApi().putNames(save);
              setState(() {
                isLoadingImage = false;
              });
            })
          : setState(() {
              isTake = false;
            });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final translateKey = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        shape: Border(bottom: BorderSide(color: gray200, width: 2)),
        toolbarHeight: 56,
        elevation: 0,
        titleSpacing: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),

              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(true);
                },
                child: SvgPicture.asset(
                  'assets/svg/chevron_left.svg',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          translateKey.translate('Profile'),
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: gray800,
          ),
        ),
      ),
      body: isLoadingPage == true
          ? CustomLoader(loadColor: primary)
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: isLoadingImage == true
                              ? () {}
                              : () {
                                  showOptions(context);
                                },
                          child: Stack(
                            children: [
                              isLoadingImage == true
                                  ? Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                        color: white,
                                        border: Border.all(color: gray200),
                                      ),
                                      child: Center(
                                        child: CustomLoader(loadColor: primary),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child:
                                          user.avatar != null && image == null
                                          ? Image.network(
                                              '${(user.avatar as Avatar).url}',
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover,
                                            )
                                          : image != null
                                          ? Image.file(
                                              image!,
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover,
                                            )
                                          : Container(
                                              width: 100,
                                              height: 100,
                                              color: gray200,
                                              child: Center(
                                                child: SvgPicture.asset(
                                                  'assets/svg/user_photo.svg',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                    ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: SvgPicture.asset(
                                  'assets/svg/camera_add.svg',
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   height: 98,
                        //   width: 98,
                        //   child: Stack(
                        //     clipBehavior: Clip.none,
                        //     fit: StackFit.expand,
                        //     children: [
                        //       CircleAvatar(
                        //         backgroundImage: AssetImage(
                        //           'assets/images/zurag.png',
                        //         ),
                        //       ),
                        //       Positioned(
                        //         bottom: -6,
                        //         right: -26,
                        //         child: RawMaterialButton(
                        //           onPressed: () {
                        //             print('Working');
                        //           },
                        //           elevation: 2,
                        //           fillColor: primary,
                        //           child: SvgPicture.asset(
                        //             'assets/svg/camera-plus.svg',
                        //             height: 20,
                        //           ),
                        //           padding: EdgeInsetsGeometry.all(8),
                        //           shape: CircleBorder(
                        //             side: BorderSide(color: white, width: 2),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          translateKey.translate('first_name'),
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: gray900,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '${user.firstName ?? '-'}',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: gray600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  GestureDetector(
                                    onTap: () async {
                                      final value = await showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                          ),
                                        ),
                                        isDismissible: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) {
                                          return EditName(
                                            name:
                                                "${translateKey.translate('first_name')}",
                                            type: 'firstName',
                                          );
                                        },
                                      );
                                      if (value == true) {
                                        callUser();
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: Text(
                                        translateKey.translate('zasah'),
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Container(
                                width: mediaQuery.size.width,
                                height: 1,
                                color: gray200,
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          translateKey.translate('last_name'),
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: gray900,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '${user.lastName ?? '-'}',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: gray600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  GestureDetector(
                                    onTap: () async {
                                      final value = await showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                          ),
                                        ),
                                        isDismissible: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) {
                                          return EditName(
                                            name:
                                                "${translateKey.translate('last_name')}",
                                            type: 'lastName',
                                          );
                                        },
                                      );
                                      if (value == true) {
                                        callUser();
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: Text(
                                        translateKey.translate('zasah'),
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: primary,
                                        ),
                                      ),
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
                  Container(
                    width: mediaQuery.size.width,
                    height: 2,
                    color: gray200,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translateKey.translate('hereglegchiyn_medeelel'),
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: gray900,
                          ),
                        ),
                        SizedBox(height: 16),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        translateKey.translate('email'),
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: gray900,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '${user.email ?? '-'}',
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: gray600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                GestureDetector(
                                  onTap: () async {
                                    final value = await showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16),
                                        ),
                                      ),
                                      isDismissible: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) {
                                        return EditEmail(type: 'EMAIL');
                                      },
                                    );
                                    if (value == true) {
                                      callUser();
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      translateKey.translate('zasah'),
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primary,
                                      ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      translateKey.translate('phone_number'),
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: gray900,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '${user.phone ?? '-'}',
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: gray600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 16),
                                GestureDetector(
                                  onTap: () async {
                                    final value = await showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16),
                                        ),
                                      ),
                                      isDismissible: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) {
                                        return EditEmail(type: "PHONE");
                                      },
                                    );
                                    if (value == true) {
                                      callUser();
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      translateKey.translate('zasah'),
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primary,
                                      ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      translateKey.translate(
                                        'registration_number',
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: gray900,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '${user.registerNo ?? '-'}',
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: gray600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 16),
                                GestureDetector(
                                  onTap: () async {
                                    final value = await showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16),
                                        ),
                                      ),
                                      isDismissible: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) {
                                        return EditName(
                                          name:
                                              "${translateKey.translate('registration_number')}",
                                          type: 'registerNo',
                                        );
                                      },
                                    );
                                    if (value == true) {
                                      callUser();
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      translateKey.translate('zasah'),
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primary,
                                      ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${translateKey.translate('bank')}',
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: gray900,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '${user.bank ?? '-'}',
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: gray600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                GestureDetector(
                                  onTap: () async {
                                    final value = await showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16),
                                        ),
                                      ),
                                      isDismissible: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) {
                                        return EditBank();
                                      },
                                    );
                                    if (value == true) {
                                      callUser();
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      translateKey.translate('zasah'),
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        translateKey.translate(
                                          'bank_account_number',
                                        ),
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: gray900,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '${user.bankAccount ?? '-'} ',
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: gray600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                GestureDetector(
                                  onTap: () async {
                                    final value = await showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16),
                                        ),
                                      ),
                                      isDismissible: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) {
                                        return EditBank();
                                      },
                                    );
                                    if (value == true) {
                                      callUser();
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      translateKey.translate('zasah'),
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        translateKey.translate(
                                          'bank_account_holder_name',
                                        ),
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: gray900,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '${user.bankAccountName ?? '-'}',
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: gray600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                GestureDetector(
                                  onTap: () async {
                                    final value = await showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16),
                                        ),
                                      ),
                                      isDismissible: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) {
                                        return EditBank();
                                      },
                                    );
                                    if (value == true) {
                                      callUser();
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      translateKey.translate('zasah'),
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Text(
                            //           translateKey.translate('birth_date'),

                            //           style: TextStyle(
                            //             fontFamily: 'Lato',
                            //             fontSize: 16,
                            //             fontWeight: FontWeight.w400,
                            //             color: gray900,
                            //           ),
                            //         ),
                            //         SizedBox(height: 4),
                            //         Text(
                            //           'Data',
                            //           style: TextStyle(
                            //             fontFamily: 'Lato',
                            //             fontSize: 14,
                            //             fontWeight: FontWeight.w400,
                            //             color: gray600,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     SizedBox(width: 16),
                            //     GestureDetector(
                            //       onTap: () {
                            //         print('Working');
                            //       },
                            //       child: Container(
                            //         padding: EdgeInsets.symmetric(vertical: 10),
                            //         child: Text(
                            //           translateKey.translate('zasah'),
                            //           style: TextStyle(
                            //             fontFamily: 'Lato',
                            //             fontSize: 16,
                            //             fontWeight: FontWeight.w600,
                            //             color: primary,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: 16),
                            // Container(
                            //   width: mediaQuery.size.width,
                            //   height: 1,
                            //   clipBehavior: Clip.antiAlias,
                            //   decoration: ShapeDecoration(
                            //     color: gray200,
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(320),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(height: 16),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Text(
                            //           translateKey.translate('gender'),

                            //           style: TextStyle(
                            //             fontFamily: 'Lato',
                            //             fontSize: 16,
                            //             fontWeight: FontWeight.w400,
                            //             color: gray900,
                            //           ),
                            //         ),
                            //         SizedBox(height: 4),
                            //         Text(
                            //           'Data',
                            //           style: TextStyle(
                            //             fontFamily: 'Lato',
                            //             fontSize: 14,
                            //             fontWeight: FontWeight.w400,
                            //             color: gray600,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     SizedBox(width: 16),
                            //     GestureDetector(
                            //       onTap: () {
                            //         print('Working');
                            //       },
                            //       child: Container(
                            //         padding: EdgeInsets.symmetric(vertical: 10),
                            //         child: Text(
                            //           translateKey.translate('zasah'),
                            //           style: TextStyle(
                            //             fontFamily: 'Lato',
                            //             fontSize: 16,
                            //             fontWeight: FontWeight.w600,
                            //             color: primary,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: mediaQuery.size.width,
                    height: 2,
                    color: gray200,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translateKey.translate('soshial_holboosuud'),
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: gray900,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/facebook.png',
                                    height: 28,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Facebook',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: gray900,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          '${user.facebookLink ?? '-'}',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: gray600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12),
                            GestureDetector(
                              onTap: () async {
                                final value = await showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                  ),
                                  isDismissible: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return EditSocials(
                                      url: 'https://www.facebook.com/',
                                      name: "Facebook",
                                    );
                                  },
                                );
                                if (value == true) {
                                  callUser();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  translateKey.translate('zasah'),
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primary,
                                  ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/viber.png',
                                    height: 28,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Viber',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: gray900,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          '${user.viberLink ?? '-'}',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: gray600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12),
                            GestureDetector(
                              onTap: () async {
                                final value = await showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                  ),
                                  isDismissible: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return EditSocials(
                                      url: 'https://www.viber.com/',
                                      name: 'Viber',
                                    );
                                  },
                                );
                                if (value == true) {
                                  callUser();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  translateKey.translate('zasah'),
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primary,
                                  ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/telegram.png',
                                    height: 28,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Telegram',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: gray900,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          '${user.telegramLink ?? '-'}',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: gray600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12),
                            GestureDetector(
                              onTap: () async {
                                final value = await showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                  ),
                                  isDismissible: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return EditSocials(
                                      url: 'https://www.telegram.com/',
                                      name: "Telegram",
                                    );
                                  },
                                );
                                if (value == true) {
                                  callUser();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  translateKey.translate('zasah'),
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primary,
                                  ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/line.png',
                                    height: 28,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Line',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: gray900,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          '${user.lineLink ?? '-'}',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: gray600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12),
                            GestureDetector(
                              onTap: () async {
                                final value = await showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                  ),
                                  isDismissible: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return EditSocials(
                                      url: 'https://www.line.com/',
                                      name: "Line",
                                    );
                                  },
                                );
                                if (value == true) {
                                  callUser();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  translateKey.translate('zasah'),
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primary,
                                  ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/watsapp.png',
                                    height: 28,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Whats App',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: gray900,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          '${user.whatsAppLink ?? '-'}',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: gray600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12),
                            GestureDetector(
                              onTap: () async {
                                final value = await showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                  ),
                                  isDismissible: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return EditSocials(
                                      url: 'https://www.whatsapp.com/',
                                      name: "Whats App",
                                    );
                                  },
                                );
                                if (value == true) {
                                  callUser();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  translateKey.translate('zasah'),
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: mediaQuery.padding.bottom + 24),
                ],
              ),
            ),
    );
  }
}
