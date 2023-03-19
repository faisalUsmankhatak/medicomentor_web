import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'common_screen.dart';
import 'entity/quiz_entity.dart';
class AddQuizWithBankQuestionScreen extends StatefulWidget {
  const AddQuizWithBankQuestionScreen({Key? key}) : super(key: key);

  @override
  State<AddQuizWithBankQuestionScreen> createState() => _AddQuizWithBankQuestionScreenState();
}

class _AddQuizWithBankQuestionScreenState extends State<AddQuizWithBankQuestionScreen> {
  TextEditingController quizNameController = TextEditingController();
  TextEditingController moduleController = TextEditingController();
  TextEditingController subjectClassController = TextEditingController();
  TextEditingController timerController = TextEditingController();
  TextEditingController userRoleController = TextEditingController();
  List<String> testType = ["Select Test Type", "MCQS", "MODE"];
  List popList = ['Update', "Delete","Add Question"];
  RxString dropDownDefaultValue = "Select Test Type".obs;
  bool isTestUpload = false;
  String? quizName;
  String? module;
  String? subjectClass;
  String? userRole;
  String? timer;
  String? quizType;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
        body:isTestUpload?const Center(child: CircularProgressIndicator(),): SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: myIconButton(
                      myIcon: Icons.arrow_back,
                      label: "Back",
                      radius: 15,
                      backBroundColor: AppTheme.whiteColor,
                      iconColor: AppTheme.blueColor,
                      labalColor: AppTheme.blueColor,
                      onpressed: () {
                        quizForUpdateMap!.clear();
                        bankQuestion.value=1;
                      }),
                ),
                SizedBox(
                  height: 15.h,
                ),

                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Text(
                        "Add New Quiz",
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),

                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 45.w,
                          child: const Text("Quiz Name")),
                      // SizedBox(
                      //   width: 20.w,
                      // ),
                      Expanded(
                          child: MyField(
                              controller: quizNameController,
                              label: "",
                              fillColor: AppTheme.whiteColor)),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 45.w, child: const Text("Module")),
                      // SizedBox(
                      //   width: 20.w,
                      // ),
                      Expanded(
                          child: MyField(
                              controller: moduleController,
                              label: "",
                              fillColor: AppTheme.whiteColor)),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 45.w,
                          child: const Text("Subject Class")),
                      Expanded(
                          child: MyField(
                              controller: subjectClassController,
                              label: "",
                              fillColor: AppTheme.whiteColor)),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 45.w,
                          child: const Text("User Role")),
                      Expanded(
                          child: MyField(
                              controller: userRoleController,
                              label: "",
                              fillColor: AppTheme.whiteColor)),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 45.w, child: const Text("Timer")),
                      Expanded(
                          child: MyField(
                              controller: timerController,
                              label: "",
                              fillColor: AppTheme.whiteColor)),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 45.w,
                          child: const Text("Quiz Type")),
                      Expanded(
                        child: Obx(
                              () => DropdownButtonFormField<String>(
                            value: dropDownDefaultValue.value,
                            isExpanded: true,
                            decoration: InputDecoration(
                              fillColor: AppTheme.texFieldColor,
                              filled: true,
                              contentPadding: const EdgeInsets.all(17),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)),
                                borderSide: BorderSide(
                                  width: 0,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    100.w,
                                  ),
                                  borderSide: const BorderSide(
                                      color:
                                      AppTheme.texFieldColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    100.w,
                                  ),
                                  borderSide: const BorderSide(
                                      color:
                                      AppTheme.texFieldColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    100.w,
                                  ),
                                  borderSide: const BorderSide(
                                      color:
                                      AppTheme.texFieldColor)),
                            ),
                            borderRadius: BorderRadius.circular(10.w),
                            onChanged: (value) {
                              dropDownDefaultValue.value = value!;
                            },
                            items: testType.map((e) {
                              return DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyFieldButton(
                      buttonText:"Submit",
                      radius: 10,
                      width: 50.w,
                      onTap: () {
                       stroredNewTest();
                      },
                    ),
                  ],
                )
              ]),
        )
    ));
  }
  void stroredNewTest() async {
    setState(() {
      isTestUpload = true;
    });
    print("helo");
    //getTextFieldValue();
    // List<QuizQuestions>? questions;
    dropDownDefaultValue.value = "Select Test Type";
    QuizEntity quizeModel = QuizEntity(
      quizName: quizNameController.text!,
      module: moduleController.text!,
      subjectClass: subjectClassController.text!,
      userRole: userRoleController.text!,
      quizType: dropDownDefaultValue.value!,
      timer: timerController.text!,
      questions: selectQuestionListFromBankQuestion


    );
    quizeModel;
    try {
      var result=     await QuizEntity.collection().add(quizeModel);
      await QuizEntity.quizDoc(quizId: result.id).update({"docId":result.id});
      setState(() {
        isTestUpload = false;
      });
      quizPages.value=0;
      currentPage.value = 0;
     // clearTextField();
      Get.snackbar("congratulations", "Your data is Successfully Stored",snackPosition: SnackPosition.BOTTOM,);
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
