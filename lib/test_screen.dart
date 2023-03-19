import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import 'common_screen.dart';
import 'entity/quiz_entity.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  TextEditingController quizNameController = TextEditingController();
  TextEditingController moduleController = TextEditingController();
  TextEditingController subjectClassController = TextEditingController();
  TextEditingController timerController = TextEditingController();
  TextEditingController userAccessController = TextEditingController();
  List<String> testType = ["Select Test Type", "MCQS", "MODE"];
  List popList = ['Update', "Delete","Add Question"];
  RxString dropDownDefaultValue = "Select Test Type".obs;
  bool isTestUpload = false;


  // Future<QuerySnapshot<QuizEntity>> querySnapshot =QuizEntity.collection().get();
      // FirebaseFirestore.instance.collection("quiz").get();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppTheme.backBroundColor,
      body: Obx(()=> quizPages.value==0?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),

               Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: myIconButton(
                      myIcon: Icons.add,
                      label: "Add new Quiz",
                      labalColor: AppTheme.blueColor,
                      iconColor: AppTheme.blueColor,
                      backBroundColor: AppTheme.whiteColor,
                      onpressed: () {
                        quizForUpdateMap!.value.clear();
                        quizPages.value = 1;
                      },
                      radius: 20.w)),

            SizedBox(
              height: 10.h,
            ),
            Expanded(
                child: FutureBuilder<QuerySnapshot<QuizEntity>>(
              future: QuizEntity.collection().get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return ListView.separated(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return cutomCard(

                        snapshot.data!.docs[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10.h,
                    );
                  },
                );
              },
            )),
          ],
        ):const SizedBox()
      ),

    ));
  }

  Widget cutomCard(
       QueryDocumentSnapshot<QuizEntity> object) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        decoration: const BoxDecoration(
            // color: AppColors.whiteColor
            ),
        height: 50.h,
        child: Card(
            elevation: 2,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: Row(
                  children: [
                    Text(object.data().quizName ?? ''),
                    const Expanded(child: SizedBox()),

                     Text( object.data().questions!=null? object.data().questions!.length.toString():"0"),


                    SizedBox(
                      width: 60.w,
                    ),
                    PopupMenuButton(onSelected: (val) {
                      if (val == "Update") {

                        quizForUpdateMap!.value = {
                          "quizName": object.data().quizName,
                          "module": object.data().module,
                          "subjectClass":object.data().subjectClass,
                          "userAccess":object.data().userRole,
                          "quizType":object.data().quizType,
                          "timer":object.data().timer,
                       "id":object.reference.id
                        };
                        quizPages.value=1;
                      } else if (val == "Delete") {
                        myAlert(val.toString(), object.id,'quiz');
                      }else if(val=="Add Question"){
clearQuizEntityObject();


                      quizEntityObject.value.quizName=object.data().quizName;
                        quizEntityObject.value.subjectClass=object.data().subjectClass;
                        quizEntityObject.value.userRole=object.data().userRole;
                        quizEntityObject.value.quizType=object.data().quizType;
                        quizEntityObject.value.timer=object.data().timer;
                        quizEntityObject.value.module=object.data().module;
                        quizEntityObject.value.questions=object.data().questions;

                        print(quizEntityObject.value.questions);
                        quizForUpdateMap!.value.clear();

                        quizNameId.value=object.id;

                        quizPages.value=2;

                      }
                    }, itemBuilder: (context) {
                      return popList.map((e) {
                        return PopupMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList();
                    }),
                    // const Icon(Icons.more_vert)
                  ],
                ),
              ),
            )),
      ),
    );
  }
  clearQuizEntityObject(){

    quizEntityObject.value.quizName="";
    quizEntityObject.value.subjectClass="";
    quizEntityObject.value.userRole="";
    quizEntityObject.value.quizType="";
    quizEntityObject.value.timer="";
    quizEntityObject.value.module="";
    quizEntityObject.value.questions=[];
  }
}
