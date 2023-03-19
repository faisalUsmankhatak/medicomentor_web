import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:image_picker/image_picker.dart';

import 'common_screen.dart';
import 'entity/bank_question_entity.dart';
import 'entity/quiz_entity.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddNewBankQuestionScreen extends StatefulWidget {
  AddNewBankQuestionScreen({Key? key}) : super(key: key);

  @override
  State<AddNewBankQuestionScreen> createState() =>
      _AddNewBankQuestionScreenState();
}

class _AddNewBankQuestionScreenState extends State<AddNewBankQuestionScreen> {
String? selectRating;
List<String> listRating=['Easy','Medium','Hard','Very Hard'];
  List<String> module = ['C++', 'Web', 'java'];
  String? selectModule;
  List<String> subject = ['Physics', 'English', 'Urdu'];
  String? selectSubject;
  TextEditingController testNameController = TextEditingController();

  @override
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _asnwer_1_Controller = TextEditingController();

  final TextEditingController _asnwer_2_Controller = TextEditingController();

  final TextEditingController _asnwer_3_Controller = TextEditingController();

  final TextEditingController _asnwer_4_Controller = TextEditingController();

  final TextEditingController _asnwer_5_Controller = TextEditingController();

  final TextEditingController _referenceController = TextEditingController();

  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _moduleController = TextEditingController();
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  String uploadImageName = '';
String descriptionImageName = '';
  FilePickerResult? result;
  String _correctAnswerIndex = "";

late Uint8List? selectImage;
late Uint8List? uploadImageUnit;
  XFile? xfile = XFile('');
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assignTextFieldValueForUpdate();
  }

  //if(widget.quiz !=null{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppTheme.backBroundColor,
            body: //isTestUpload?const Center(child: CircularProgressIndicator(),):
            isLoading
                ? const Center(child: CircularProgressIndicator(),)
                : SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
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
                                bankQuestion.value = 0;
                              }),
                        ),
                        SizedBox(width: 10.w,),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: myIconButton(
                              myIcon: Icons.arrow_back,
                              label: "Select Question",
                              radius: 15,
                              backBroundColor: AppTheme.whiteColor,
                              iconColor: AppTheme.blueColor,
                              labalColor: AppTheme.blueColor,
                              onpressed: () {

                              }),
                        ),
                      ],
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
                      padding: EdgeInsets.only(left: 10.w, right: 20.w),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 45.w, child: const Text("Select Image (Optional)")),
                          SizedBox(width: 100.w,),
                          InkWell(
                            onTap: () async {
                              var select = await FilePicker.platform.pickFiles(
                                type: FileType.custom,

                                allowedExtensions: [
                                  'jpg',
                                  'pdf',
                                  'doc',
                                  'jpg',
                                  'png'
                                ],
                              );
                              // Pick an image
                              // xfile = await _picker.pickImage(source: ImageSource.gallery);
                              if (select != null) {
                                descriptionImageName = select!.files.first.name;
                                print(uploadImageName);
                                selectImage = select!.files.first.bytes!;
                                setState(() {

                                });
                                //  FirebaseStorage storage =FirebaseStorage.instance;

                                //Reference reference=await storage.ref().child('uploads/${result!.files.first.name}');

                                // UploadTask uploadTask= reference.putData(selectImage);
                                // String url=await reference.getDownloadURL();
// var done=await uploadTask;

                              }
                            },
                            child: Container(
                              width: 90.w,
                              height: 90.h,
                              child: descriptionImageName == ''
                                  ? Icon(Icons.person)
                                  : Image.memory(selectImage!),
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
                      padding: EdgeInsets.only(left: 10.w, right: 20.w),
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
                      padding: EdgeInsets.only(left:10.w,right: 20.w),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 45.w,
                              child: const Text("Difficulty Rating")),
                          Expanded(
                            child:  DropdownButtonFormField<String>(
                                value: selectRating,
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
                                setState(() {
                                  selectRating = value!;
                                });
                                },
                                items: listRating.map((e) {
                                  return DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(e),
                                  );
                                }).toList(),
                              ),

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
                      padding: EdgeInsets.only(left: 10.w, right: 20.w),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 45.w,
                              child: const Text("Detail Information")),
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
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, right: 20.w),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 45.w, child: const Text("Upload Image")),
                          SizedBox(width: 100.w,),
                          InkWell(
                            onTap: () async {
                              result = await FilePicker.platform.pickFiles(
                                type: FileType.custom,

                                allowedExtensions: [
                                  'jpg',
                                  'pdf',
                                  'doc',
                                  'jpg',
                                  'png'
                                ],
                              );
                              // Pick an image
                              // xfile = await _picker.pickImage(source: ImageSource.gallery);
                              if (result != null) {
                                uploadImageName = result!.files.first.name;
                                print(uploadImageName);
                                uploadImageUnit = result!.files.first.bytes!;
                                setState(() {

                                });
                                //  FirebaseStorage storage =FirebaseStorage.instance;

                                //Reference reference=await storage.ref().child('uploads/${result!.files.first.name}');

                                // UploadTask uploadTask= reference.putData(selectImage);
                                // String url=await reference.getDownloadURL();
// var done=await uploadTask;

                              }
                            },
                            child: Container(
                              width: 90.w,
                              height: 90.h,
                              child: uploadImageName == ''
                                  ? Icon(Icons.person)
                                  : Image.memory(uploadImageUnit!),
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
                      padding: EdgeInsets.only(left: 10.w, right: 20.w),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 45.w, child: const Text("Module")),
                          Expanded(
                            child: DropdownButtonFormField(

                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppTheme.texFieldColor,
                                disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.w,),
                                    borderSide: const BorderSide(color: AppTheme.texFieldColor)),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.w,),
                                    borderSide: const BorderSide(color:AppTheme.texFieldColor)),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.w,),
                                    borderSide: const BorderSide(color: AppTheme.texFieldColor)),

                              ),

                              value: selectModule,
                              items: module.map((e) =>
                                DropdownMenuItem(child: Text(e), value: e,)).toList(),
                              onChanged: (value) {
setState(() {
  selectModule=value.toString();
});
                              },),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, right: 20.w),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 45.w, child: const Text("Subject")),
                          Expanded(
                            child: DropdownButtonFormField(

                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppTheme.texFieldColor,
                                disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.w,),
                                    borderSide: const BorderSide(color: AppTheme.texFieldColor)),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.w,),
                                    borderSide: const BorderSide(color:AppTheme.texFieldColor)),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.w,),
                                    borderSide: const BorderSide(color: AppTheme.texFieldColor)),

                              ),

                              value: selectSubject,
                              items: subject.map((e) =>
                                  DropdownMenuItem(child: Text(e), value: e,)).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectSubject=value.toString();
                                });
                              },),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10.w, right: 20.w),
                    //   child: Row(
                    //     children: [
                    //       SizedBox(
                    //           width: 45.w, child: const Text("Module")),
                    //       Expanded(
                    //         child: MyField(
                    //           controller: _moduleController,
                    //           label: "",
                    //           fillColor: AppTheme.whiteColor,
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 10.h,
                    //       ),
                    //
                    //       SizedBox(
                    //         height: 10.h,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, right: 20.w),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 45.w, child: const Text("Topic")),
                          Expanded(
                            child: MyField(
                              controller: _topicController,
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
                            buttonText: questionForUpdateMap!.value.isNotEmpty
                                ? 'Update'
                                : "Save",
                            radius: 10,
                            width: 50.w,
                            onTap: () async {
                              if (questionForUpdateMap!.value.isNotEmpty) {
                                bankQuestionUpdate();
                              }
                              else {
                                addNewQuestion();
                              }
                            }
                        ),
                      ],
                    )
                  ]),
            )));
  }

  void bankQuestionUpdate() async {
    // getTextFieldValue();

    BankQuestionEntity bankQuestionEntity = BankQuestionEntity(
      discription: _descriptionController.text,
      rating: selectRating,
      details: _detailController.text,
      answerList: [
        _asnwer_1_Controller.text,
        _asnwer_2_Controller.text,
        _asnwer_3_Controller.text,
        _asnwer_4_Controller.text,
        _asnwer_5_Controller.text
      ],
      reference: _referenceController.text,
      module: selectModule!,
    //  _moduleController.text,
      correctAnswerIndex: int.parse(_correctAnswerIndex),
      subject: selectSubject!,
     // _subjectController.text,
      topic: _topicController.text,
      isCheck: false,

    );
    // Map<String,dynamic> map=BankQuestionEntity.toJson();
    try {
      // setState(() {
      //   isLoading = true;
      // });

      Map<String, Object?> map = bankQuestionEntity.toJson();
      print(map);
      // await  BankQuestionEntity.questionDoc(questionId: quizForUpdateMap!['id']).;

      //  FirebaseFirestore.instance.collection("questionBank").doc(quizForUpdateMap!['id']).update(map);
      // setState(() {
      //   isLoading = false;
      // });
      //clearTextField();
      quizPages.value = 0;
      questionForUpdateMap!.clear();
      Get.snackbar("congratulations", "Your data is Successfully Updated",
        snackPosition: SnackPosition.BOTTOM,);
    } on FirebaseException catch (e) {
      print(e.toString());
    }


    quizForUpdateMap!.clear();
  }


  void assignTextFieldValueForUpdate() {
    if (questionForUpdateMap!.value.isNotEmpty) {
      //_correctAnswerIndex=questionForUpdateMap!['correctAnswerIndex'].toString();
      print(_correctAnswerIndex);
      _descriptionController.text = questionForUpdateMap!['discription'];
      _asnwer_1_Controller.text = questionForUpdateMap!['_asnwer_1_Controller'];
      _asnwer_2_Controller.text = questionForUpdateMap!['_asnwer_2_Controller'];
      _asnwer_3_Controller.text = questionForUpdateMap!['_asnwer_3_Controller'];
      _asnwer_4_Controller.text = questionForUpdateMap!['_asnwer_4_Controller'];
      _asnwer_5_Controller.text = questionForUpdateMap!['_asnwer_5_Controller'];
      _correctAnswerIndex =
          questionForUpdateMap!['correctAnswerIndex'].toString();
      _referenceController.text = questionForUpdateMap!['reference'];
      _detailController.text = questionForUpdateMap!['details'];
      _moduleController.text = questionForUpdateMap!['module'];
      _topicController.text = questionForUpdateMap!['topic'];
      _subjectController.text = questionForUpdateMap!['subject'];
    }
  }

  void addNewQuestion() async {
    FirebaseStorage storage = FirebaseStorage.instance;

    Reference reference1 = await storage.ref().child(
        'uploads/${result!.files.first.name}');

    await reference1.putData(selectImage!);
    String url1 = await reference1.getDownloadURL();
    Reference reference2 = await storage.ref().child(
        'uploads/${result!.files.first.name}');

    await reference2.putData(uploadImageUnit!);
    String url2 = await reference2.getDownloadURL();
    BankQuestionEntity bankQuestionEntity = BankQuestionEntity(
        discription:
        _descriptionController.text.trim(),
        imageName: result!.files.first.name,
rating: selectRating,
        imageUrl: url1,
        descriptionImageName: descriptionImageName,
        descriptionImageUrl:url2,
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
        details: _detailController.text.trim(),
        module: selectModule!,
        //_moduleController.text.trim(),
        topic: _topicController.text.trim(),
        subject:selectSubject!,
        //_subjectController.text.trim(),
        isCheck: false
    );

//


    try {
      setState(() {
        isLoading = true;
      });
      var result = await BankQuestionEntity.collection().add(
          bankQuestionEntity);
      await BankQuestionEntity.questionDoc(questionId: result.id,).update(
          {"docId": result.id});

      Get.snackbar("congratulations", "Your data is Successfully stored",
        snackPosition: SnackPosition.BOTTOM,);

      setState(() {
        isLoading = false;
      });
      clearTextFieldValue();
    }
    catch (e) {
      print("error message....$e");
    }
  }

  clearTextFieldValue() {
    _descriptionController.clear();

    _asnwer_1_Controller.clear();
    _asnwer_2_Controller.clear();
    _asnwer_3_Controller.clear();
    _asnwer_4_Controller.clear();
    _asnwer_5_Controller.clear();
    _referenceController.clear();
    _detailController.clear();
    _moduleController.clear();
    _correctAnswerIndex = "";
    _topicController.clear();
    _subjectController.clear();
    selectImage=null;
    uploadImageUnit=null;
    uploadImageName='';
    descriptionImageName='';
  }
}
