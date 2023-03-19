import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'common_screen.dart';
import 'entity/bank_question_entity.dart';
import 'entity/quiz_entity.dart';

class QuestionAnswerScreen extends StatefulWidget {
  const QuestionAnswerScreen({Key? key}) : super(key: key);

  @override
  State<QuestionAnswerScreen> createState() => _QuestionAnswerScreenState();
}

class _QuestionAnswerScreenState extends State<QuestionAnswerScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _asnwer_1_Controller = TextEditingController();
  final TextEditingController _asnwer_2_Controller = TextEditingController();
  final TextEditingController _asnwer_3_Controller = TextEditingController();
  final TextEditingController _asnwer_4_Controller = TextEditingController();
  final TextEditingController _asnwer_5_Controller = TextEditingController();
  final TextEditingController _referenceController=TextEditingController();
  final TextEditingController _detailController=TextEditingController();
  String _correctAnswerIndex = "";
  bool isLoading = false;
  List<BankQuestionEntity>? questionsList = [];

  //if(widget.quiz !=null{
  // questionsList = widget.quiz.questions;
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppTheme.backBroundColor,
            body: //isTestUpload?const Center(child: CircularProgressIndicator(),):
                SingleChildScrollView(
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
                            quizPages.value = 0;
                          }),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Text(
                        "Add New Question",
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
                          SizedBox(width: 45.w, child: const Text("Question")),
                          // SizedBox(
                          //   width: 20.w,
                          // ),
                          Expanded(
                              child: MyField(
                            fillColor: AppTheme.whiteColor,
                            controller: _descriptionController,
                             maxLine: 4,
                            label: '',
                                radius: 20.sp,
                          )),
                          SizedBox(
                            width: 32.h,
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
                              width: 45.w, child: const Text("Add Answer 1")),
                          // SizedBox(
                          //   width: 20.w,
                          // ),
                          Expanded(
                              child: MyField(
                                  controller: _asnwer_1_Controller,
                                  label: "",
                                  fillColor: AppTheme.whiteColor)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Radio(
                              value: "0",
                              groupValue: _correctAnswerIndex,
                              onChanged: (val) {
                                setState(() {
                                  _correctAnswerIndex = val!;
                                });
                              }),
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
                              width: 45.w, child: const Text("Add Answer 2")),
                          Expanded(
                              child: MyField(
                                  controller: _asnwer_2_Controller,
                                  label: "",
                                  fillColor: AppTheme.whiteColor)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Radio(
                              value: "1",
                              groupValue: _correctAnswerIndex,
                              onChanged: (val) {
                                setState(() {
                                  _correctAnswerIndex = val!;
                                });
                              }),
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
                              width: 45.w, child: const Text("Add Answer 3")),
                          Expanded(
                              child: MyField(
                                  controller: _asnwer_3_Controller,
                                  label: "",
                                  fillColor: AppTheme.whiteColor)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Radio(
                              value: "2",
                              groupValue: _correctAnswerIndex,
                              onChanged: (val) {
                                setState(() {
                                  _correctAnswerIndex = val!;
                                });
                              }),
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
                              width: 45.w, child: const Text("Add Answer 4")),
                          Expanded(
                              child: MyField(
                                  controller: _asnwer_4_Controller,
                                  label: "",
                                  fillColor: AppTheme.whiteColor)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Radio(
                              value: "3",
                              groupValue: _correctAnswerIndex,
                              onChanged: (val) {
                                setState(() {
                                  _correctAnswerIndex = val!;
                                });
                              }),
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
                              width: 45.w, child: const Text("Add Answer 5")),
                          Expanded(
                            child: MyField(
                              controller: _asnwer_5_Controller,
                              label: "",
                              fillColor: AppTheme.whiteColor,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Radio(
                              value: "4",
                              groupValue: _correctAnswerIndex,
                              onChanged: (val) {
                                setState(() {
                                  _correctAnswerIndex = val!;
                                });
                              }),
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
                      padding: EdgeInsets.only(left: 10.w,right: 20.w),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 45.w, child: const Text("Reference")),
                          Expanded(
                            child: MyField(
                              controller: _referenceController,
                              label: "",
                              fillColor: AppTheme.whiteColor,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),

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
                      padding: EdgeInsets.only(left: 10.w,right: 20.w),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 45.w, child: const Text("Detail Information")),
                          Expanded(
                            child: MyField(
                              controller: _detailController,
                              label: "",
                              fillColor: AppTheme.whiteColor,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),

                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : MyFieldButton(
                                buttonText: "Save",
                                radius: 10,
                                width: 50.w,
                                onTap: () async {
                                  List<BankQuestionEntity>? questions = <BankQuestionEntity>[];
                                  BankQuestionEntity question1 = BankQuestionEntity(
                                    discription:
                                    _descriptionController.text.trim(),
                                    answerList: [
                                      _asnwer_1_Controller.text.trim(),
                                      _asnwer_2_Controller.text.trim(),
                                      _asnwer_3_Controller.text.trim(),
                                      _asnwer_4_Controller.text.trim(),
                                      _asnwer_5_Controller.text.trim()
                                    ],
                                    correctAnswerIndex:
                                    int.parse(_correctAnswerIndex),
                                    reference: _referenceController.text.trim(),
                                    details: _detailController.text.trim(), module: '', topic: '', subject: '',rating: ''
                                  );
                                  if (quizEntityObject.value.questions ==
                                      null) {
                                    questions!.add(question1);
                                    quizEntityObject.value.questions =
                                        List.from(questions);
                                  } else {
                                    quizEntityObject.value.questions!.add(
                                        question1);
                                  }
//


                                  try {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await QuizEntity.quizDoc(
                                        quizId: quizNameId.value)
                                        .set(quizEntityObject.value);
                                    quizNameId.value = "";
                                    clearTextFieldValue();
                                   
                                    Get.snackbar("congratulations", "Your data is Successfully stored",snackPosition: SnackPosition.BOTTOM,);

                                    setState(() {
                                      isLoading = false;
                                    });


                                  }
                                  catch (e) {
                                    print("error message....$e");
                                  }
                                }
                              ),
                      ],
                    )
                  ]),
            )));
  }
  clearTextFieldValue(){
    _descriptionController.clear();
    _asnwer_1_Controller.clear();
    _asnwer_2_Controller.clear();
    _asnwer_3_Controller.clear();
    _asnwer_4_Controller.clear();
    _asnwer_5_Controller.clear();
    _referenceController.clear();
    _detailController.clear();

    _correctAnswerIndex="";
  }
}
