import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'entity/bank_question_entity.dart';
import 'entity/quiz_entity.dart';


List<BankQuestionEntity> selectQuestionListFromBankQuestion=<BankQuestionEntity>[];
Rx<QuizEntity> quizEntityObject=QuizEntity(quizName: 'cede', module: 'efe', subjectClass: 'fef', userRole: 'ee', quizType: 'ee', timer: 'ee').obs;
RxString quizNameId="".obs;
RxInt quizPages=0.obs;
RxInt bankQuestion = 0.obs;
RxInt currentPage = 0.obs;
RxMap? quizForUpdateMap={}.obs;
RxMap? questionForUpdateMap={}.obs;
Widget myIconButton(
    {required IconData myIcon,
    required String label,
    required double radius,
    Color? backBroundColor,
    Color? labalColor,
    Color? iconColor,
    VoidCallback? onpressed}) {
  return ElevatedButton.icon(
    onPressed: onpressed,
    icon: Icon(myIcon, color: iconColor ?? AppTheme.whiteColor),
    label: Text(label,
        style: TextStyle(color: labalColor ?? AppTheme.whiteColor)),
    style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backBroundColor ?? AppTheme.blueColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius))),
  );
}

class MyFieldButton extends StatelessWidget {
  GestureTapCallback? onTap;
  String? buttonText;
  double? height;
  double? radius;
  double? width;
  double? fontSize;
  Color? bodyColor;

  MyFieldButton({this.onTap, this.buttonText, this.height, this.radius,
    this.width, this.fontSize,this.bodyColor});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      child: Ink(
        width: width,
        height:height??45.sp,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius??10),
            color: bodyColor?? AppTheme.blueColor

        ),
        child: Center(child: Text(buttonText??"Button",style:  TextStyle(color: AppTheme.whiteColor,
            fontSize: fontSize??15.sp)),),
      ),

    );
  }


}

Future<void> myAlert(String status, String id,String collection) async {
  RxBool isRecordDelete = true.obs;
  return await Get.defaultDialog(

      content: const Text("Alert Message"),
      title: "Are you shure you want to $status",
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => ElevatedButton(
                onPressed: () async {
                  isRecordDelete.value = false;
                  await FirebaseFirestore.instance
                      .collection(collection)
                      .doc(id)
                      .delete();
                  isRecordDelete.value =  !isRecordDelete.value;
                  quizPages.value=1;
                  quizPages.value=0;
                  Get.back();
                  // isShowAllTestVisible.value = true;
                  Get.snackbar("congratulations", "Your data is Successfully Deleted",snackPosition: SnackPosition.BOTTOM,);
                },
                style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 11.w, vertical: 14.5.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3.w)))
                ),
                child: isRecordDelete.value
                    ? const Text("Ok")
                    :  Center(
                        child: SizedBox(
                            height: 20.h,
                            width: 10.w,
                            child: const CircularProgressIndicator(color: AppTheme.whiteColor,)),
                      ),
              ),
            ),

            SizedBox(
              width: 10.w,
            ),
            MyFieldButton(
              buttonText: "No",
              width: 30.w,
              onTap: () {
                Get.back();
              },
              height: 30.h,
            ),
          ],
        )
      ]);
}

class MyField extends StatelessWidget {
  TextEditingController controller;
  String label;
  String? suffixIcon;
  String? prefixIcon;
  Color? fillColor;
  int? maxLine;
  double? radius;

  GestureTapCallback? suffixIconTab;
  bool? obscureText;
  MyField({required this.controller, required this.label, this.suffixIcon, this.prefixIcon,
    this.fillColor,this.suffixIconTab,this.obscureText,this.maxLine,this.radius});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:suffixIconTab ,
      child: TextFormField(
        maxLines:maxLine?? 1,

          controller: controller,
          obscureText: obscureText??false,
          decoration: InputDecoration(
            label: Text(label),
            //hintText: label,
            fillColor:fillColor??AppTheme.texFieldColor,

            filled: true,
            labelStyle: AppTheme.formLabelStyle(),

            suffixIcon: suffixIcon==null?const SizedBox(width:2 ,height: 2,):GestureDetector(
              onTap: suffixIconTab,
              child: Container(
                width: 19.w,height: 15.h,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(suffixIcon!))),
              ),
            ),
            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius??100.w,),
                borderSide: const BorderSide(color: AppTheme.texFieldColor)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius??100.w,),
                borderSide: const BorderSide(color:AppTheme.texFieldColor)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius??100.w,),
                borderSide: const BorderSide(color: AppTheme.texFieldColor)),

          )
      ),
    );
  }
}

class AppTheme{
  static const   texFieldColor=Color(0XffF7F5FF);
  static const backBroundColor=Color(0xffE5E4E2);
  static const  textColor=Color(0xff2B3D5F);
  static const whiteColor=Color(0xffFFFFFF);
  static const blackClor=Color(0xff36454F);
  static const blueColor=Color(0xff0096FF);

  static TextStyle formLabelStyle(){

    return TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppTheme.textColor
    );
  }
}
