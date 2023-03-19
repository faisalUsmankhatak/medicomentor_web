import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'common_screen.dart';
import 'entity/bank_question_entity.dart';
import 'entity/quiz_entity.dart';

class BankQuestionListingScreen extends StatefulWidget {
  const BankQuestionListingScreen({Key? key}) : super(key: key);

  @override
  State<BankQuestionListingScreen> createState() =>
      _BankQuestionListingScreenState();
}

class _BankQuestionListingScreenState extends State<BankQuestionListingScreen> {
  List<String> module = ['C++', 'Web', 'java'];
  String? selectModule;
  List<String> subject = ['Physics', 'English', 'Urdu'];
  String? selectSubject;
  TextEditingController searchController = TextEditingController();
  TextEditingController testNameController = TextEditingController();
  List popList = [
    'Update',
    "Delete",
  ];

  RxBool isVisibleCheckbox = false.obs;
  late QuerySnapshot<BankQuestionEntity> data;
  List<BankQuestionEntity> bankQuestionList = [];
  List<BankQuestionEntity> selectBankQuestionList = [];
  List<BankQuestionEntity> snapshotBankQuestionList = [];

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  getData() async {
    data = await BankQuestionEntity.collection().get();

    data!.docs.forEach((element) {
      bankQuestionList.add(element.data());
      snapshotBankQuestionList.add(element.data());
    });

   // snapshotBankQuestionList=  bankQuestionList ;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppTheme.backBroundColor,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Obx(() => quizPages.value == 0
              ? Column(
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
                                myIcon: Icons.add,
                                label: "Add new Question",
                                labalColor: AppTheme.blueColor,
                                iconColor: AppTheme.blueColor,
                                backBroundColor: AppTheme.whiteColor,
                                onpressed: () {
                                  quizForUpdateMap!.value.clear();
                                  bankQuestion.value = 1;
                                },
                                radius: 20.w)),
                        //  SizedBox(width: 3.w,),
                        Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: myIconButton(
                                myIcon: Icons.add,
                                label: "Select Questions",
                                labalColor: AppTheme.blueColor,
                                iconColor: AppTheme.blueColor,
                                backBroundColor: AppTheme.whiteColor,
                                onpressed: () {
                                  print('press');
                                  isVisibleCheckbox.value =
                                      !isVisibleCheckbox.value;
                                },
                                radius: 20.w)),
                        Container(
                          width: 200.w,
                          child: Row(
                            children: [
                              Text('Filter by'),
                              Flexible(
                                child: DropdownButtonFormField(
                                  hint: Text('Module'),

                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppTheme.texFieldColor,
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          100.w,
                                        ),
                                        borderSide: const BorderSide(
                                            color: AppTheme.texFieldColor)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          100.w,
                                        ),
                                        borderSide: const BorderSide(
                                            color: AppTheme.texFieldColor)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          100.w,
                                        ),
                                        borderSide: const BorderSide(
                                            color: AppTheme.texFieldColor)),
                                  ),
                                  value: selectModule,
                                  items: module
                                      .map((e) => DropdownMenuItem(
                                            child: Text(e),
                                            value: e,
                                          ))
                                      .toList(),
                                  onChanged: (value) {


                                    selectModule = value.toString();


                                      bankQuestionList.clear();
                                      snapshotBankQuestionList.forEach((element) {
                                        if(element.module==selectModule){
                                          bankQuestionList.add(element);
                                        }
                                      });

bankQuestionList.forEach((element) {
  print(element.module);
});
                                    setState(() {

                                    });

                                  },
                                ),
                              ),
                              Flexible(
                                child: DropdownButtonFormField(
                                  hint: Text('Subject'),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppTheme.texFieldColor,
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          100.w,
                                        ),
                                        borderSide: const BorderSide(
                                            color: AppTheme.texFieldColor)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          100.w,
                                        ),
                                        borderSide: const BorderSide(
                                            color: AppTheme.texFieldColor)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          100.w,
                                        ),
                                        borderSide: const BorderSide(
                                            color: AppTheme.texFieldColor)),
                                  ),
                                  value: selectSubject,
                                  items: subject
                                      .map((e) => DropdownMenuItem(
                                            child: Text(e),
                                            value: e,
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    selectSubject = value.toString();

                                    bankQuestionList.clear();
                                    snapshotBankQuestionList.forEach((element) {
                                      if(element.subject==selectSubject){
                                        bankQuestionList.add(element);
                                      }
                                    });

                                    // bankQuestionList.forEach((element) {
                                    //   print(element.module);
                                    // });
                                    setState(() {

                                    });

                                  },
                                ),
                              ),
                              Flexible(
                                child: TextFormField(
                                  controller: searchController,
                                  decoration:  InputDecoration(
                                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.w,),
                                          borderSide: const BorderSide(color: AppTheme.texFieldColor)),
                                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.w,),
                                          borderSide: const BorderSide(color:AppTheme.texFieldColor)),
                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.w,),
                                          borderSide: const BorderSide(color: AppTheme.texFieldColor)),
                                    
                                      label: Text('Search'),
                                    suffixIcon: InkWell(
                                      onTap: (){
                                        bankQuestionList.clear();
                                        snapshotBankQuestionList.forEach((element) {
                                          if(element.topic==searchController.text){
                                            bankQuestionList.add(element);
                                          }
                                        });

                                        // bankQuestionList.forEach((element) {
                                        //   print(element.module);
                                        // });
                                        setState(() {

                                        });

                                      },
                                      child: const Icon(Icons.search),)
                                  
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.yellow,
                          width: 80.w,
                          child: const Center(
                            child: Text('Question'),
                          ),
                        ),
                        Container(
                          color: Colors.red,
                          width: 50.w,
                          child: const Center(
                            child: Text('Module'),
                          ),
                        ),
                        Container(
                          color: Colors.red,
                          width: 50.w,
                          child: const Center(
                            child: Text('Subject'),
                          ),
                        ),
                        Container(
                          color: Colors.yellow,
                          width: 50.w,
                          child: const Center(
                            child: Text('Topic'),
                          ),
                        ),
                        Container(
                          color: Colors.red,
                          width: 50.w,
                          child: const Center(
                            child: Text('Action'),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SingleChildScrollView(
                      child: ListView.separated(
                        clipBehavior: Clip.none,
                        padding: EdgeInsets.symmetric(horizontal: 0.w),
                        shrinkWrap: true,
                        itemCount: bankQuestionList.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              customCard(index),
                              SizedBox(
                                width: 10.w,
                              ),
                              Obx(
                                () => InkWell(
                                  onTap: () {
                                    bankQuestionList[index].isCheck =
                                        !bankQuestionList[index].isCheck!;
                                    // !shanshot.data!.docs[index].data().isCheck;
                                    print(bankQuestionList[index].isCheck);
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 16.w,
                                    height: 26.h,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      color: bankQuestionList[index].isCheck!
                                          ? Colors.blue
                                          : Colors.transparent,
                                      border: Border.all(
                                          color: isVisibleCheckbox.value
                                              ? Colors.blue
                                              : Colors.transparent,
                                          width: 1.w),
                                    ),
                                    child: Icon(Icons.done,
                                        color: bankQuestionList[index].isCheck!
                                            ? Colors.white
                                            : Colors.transparent),
                                  ),
                                ),
                              ),
                              // myCheckBox(shanshot.data!.docs[index].data().isCheck)
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          assignSelectQuestionToQuizEntity();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10.sp)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          child: const Text(
                            'Next',
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : const SizedBox()),
    ));
  }

  assignSelectQuestionToQuizEntity() {
    BankQuestionEntity questions = BankQuestionEntity(
      discription: '',
      answerList: [],
      correctAnswerIndex: 0,
      reference: '',
      details: '',
      module: '',
      topic: '',
      subject: '', rating: '',
    );
    for (int i = 0; i < bankQuestionList.length; i++) {
      if (bankQuestionList[i].isCheck!) {
        selectBankQuestionList.add(bankQuestionList[i]);
        questions.reference = bankQuestionList[i].reference;
        questions.discription = bankQuestionList[i].discription;
        questions.details = bankQuestionList[i].details;
        questions.correctAnswerIndex = bankQuestionList[i].correctAnswerIndex;
        questions.answerList = List.from(bankQuestionList[i].answerList);
        questions.imageName = bankQuestionList[i].imageName;
        questions.imageUrl = bankQuestionList[i].imageUrl;
        selectQuestionListFromBankQuestion.add(questions);
      }
    }
    bankQuestion.value = 2;
  }

  addQuestionQuizCollection() {
    QuizEntity quizEntity;
  }

  Widget customCard(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: Container(
        //width: Get.width*0.6,
        decoration: const BoxDecoration(),
        height: 50.h,
        child: Card(
            elevation: 2,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.h),
                child: Row(
                  children: [
                    SizedBox(
                        width: 80.w,
                        child: Text(
                          bankQuestionList[index].discription ?? '',
                          textAlign: TextAlign.center,
                        )),
                    SizedBox(
                        width: 50.w,
                        child: Text(bankQuestionList[index].module ?? '',
                            textAlign: TextAlign.center)),
                    SizedBox(
                        width: 50.w,
                        child: Text(bankQuestionList[index].subject ?? '',
                            textAlign: TextAlign.center)),
                    SizedBox(
                        width: 50.w,
                        child: Text(bankQuestionList[index].topic ?? '',
                            textAlign: TextAlign.center)),
                    // const Expanded(child: SizedBox()),

                    //  Text( object.data().questions!=null? object.data().questions!.length.toString():"0"),

                    Container(
                      width: 50.w,
                      alignment: Alignment.center,
                      child: PopupMenuButton(onSelected: (val) {
                        if (val == "Update") {
                          print('hello');
                          questionForUpdateMap!.value = {
                            "discription": bankQuestionList[index].discription,
                            "_asnwer_1_Controller":
                                bankQuestionList[index].answerList[0],
                            "_asnwer_2_Controller":
                                bankQuestionList[index].answerList[1],
                            "_asnwer_3_Controller":
                                bankQuestionList[index].answerList[2],
                            "_asnwer_4_Controller":
                                bankQuestionList[index].answerList[3],
                            "_asnwer_5_Controller":
                                bankQuestionList[index].answerList[4],
                            "correctAnswerIndex":
                                bankQuestionList[index].correctAnswerIndex,
                            "details": bankQuestionList[index].details,
                            "reference": bankQuestionList[index].reference,
                            'module': bankQuestionList[index].reference,
                            'topic': bankQuestionList[index].topic,
                            'subject': bankQuestionList[index].subject,
                            "id": bankQuestionList[index].docId
                          };
                          bankQuestion.value = 1;
                        } else if (val == "Delete") {
                          myAlert(val.toString(),
                              bankQuestionList[index].docId!, 'questionBank');
                          bankQuestionList.removeAt(index);
                        }
                      }, itemBuilder: (context) {
                        return popList.map((e) {
                          return PopupMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList();
                      }),
                    ),
                    // const Icon(Icons.more_vert)
                  ],
                ),
              ),
            )),
      ),
    );
  }

  clearQuizEntityObject() {
    quizEntityObject.value.quizName = "";
    quizEntityObject.value.subjectClass = "";
    quizEntityObject.value.userRole = "";
    quizEntityObject.value.quizType = "";
    quizEntityObject.value.timer = "";
    quizEntityObject.value.module = "";
    quizEntityObject.value.questions = [];
  }
// Widget myCheckBox(bool isCheck){
//   return true? Obx(()=>
//
//   ):SizedBox();
// }
}
