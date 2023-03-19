import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:medicomentor_web/entity/module_entity.dart';

import 'common_screen.dart';
import 'entity/subject_entity.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

bool whoseCheckButton = false;
bool isSubjectLoading = false;
bool isModuleLoading = false;
TextEditingController subjectController = TextEditingController();
TextEditingController moduleController = TextEditingController();

class _InputScreenState extends State<InputScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h,),
            Center(
              child: Container(
                width: 100.w,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: InkWell(
                      onTap: () {
                        setState(() {
                          whoseCheckButton = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: whoseCheckButton ? Colors.white : Colors.blue,
                            borderRadius: BorderRadius.circular(10.sp)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 5.w,
                            vertical: 5),
                        child: Center(child: Text('Module', style: TextStyle(
                            color: whoseCheckButton ? Colors.blue : Colors
                                .white))),
                      ),
                    )),
                    SizedBox(width: 10.w,),
                    Expanded(child: InkWell(
                      onTap: () {
                        setState(() {
                          whoseCheckButton = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: whoseCheckButton ? Colors.blue : Colors.white,
                            borderRadius: BorderRadius.circular(10.sp)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 5.w,
                            vertical: 5),
                        child: Center(child: Text('Subject', style: TextStyle(
                            color: whoseCheckButton ? Colors.white : Colors
                                .blue),)),
                      ),
                    ))
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h,),
            whoseCheckButton ? Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: MyField(
                    controller: subjectController, label: 'Enter Subject',),
                ),
                SizedBox(height: 10.h,),
                isSubjectLoading
                    ? Center(child: CircularProgressIndicator(),)
                    : InkWell(
                  onTap: () {
                    addSubject();
                  },
                  child: Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10.sp)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5),
                    child: const Center(
                        child: Text('Submit', style: TextStyle(color: Colors
                            .white))),
                  ),
                ),
                SizedBox(height: 90.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 80.w),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100.w,
                        alignment: Alignment.topLeft,
                        child: Text('Subject',textAlign: TextAlign.start),),
                      Container(
                        width: 100.w,

                        child: Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 50.w,

                              child: Text('Edit'),),
                            Container(
                              width: 50.w,

                              child: Text('Delete'),)
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 10.h,),
                StreamBuilder(
                  stream:  FirebaseFirestore.instance.collection('subject').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return ListView.separated(
                      shrinkWrap:  true,
                      padding: EdgeInsets.symmetric(horizontal: 80.w),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return
                          subjectListing(snapshot.data?.docs[index]);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 8.h,);
                      },
                      itemCount: snapshot.data!.docs.length,);
                  },
                )
              ],
            ) :
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: MyField(
                    controller: moduleController, label: 'Enter Module',),
                ),
                SizedBox(height: 10.h,),
                isModuleLoading
                    ? Center(child: CircularProgressIndicator(),)
                    : InkWell(
                  onTap: () {
                    addModule();
                  },
                  child: Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10.sp)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5),
                    child: Center(
                        child: Text('Submit', style: TextStyle(color: Colors
                            .white))),
                  ),
                ),
                SizedBox(height: 90.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 80.w),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     Container(
                       width: 100.w,
                       alignment: Alignment.topLeft,
                       child: Text('Module',textAlign: TextAlign.start),),
                     Container(
                       width: 100.w,

                       child: Row(mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Container(
                             width: 50.w,

                             child: Text('Edit'),),
                           Container(
                             width: 50.w,

                             child: Text('Delete'),)
                         ],
                       ),
                     ),

                    ],
                  ),
                ),
                SizedBox(height: 10.h,),
                StreamBuilder(
                  stream:  FirebaseFirestore.instance.collection('module').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return ListView.separated(
shrinkWrap:  true,
                        padding: EdgeInsets.symmetric(horizontal: 80.w),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                      return
                        moduleListing(snapshot.data?.docs[index]);
                    },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 8.h,);
                        },
                        itemCount: snapshot.data!.docs.length,);
                  },
                )
              ],
            )

          ],
        ),
      ),
    ));
  }
Widget moduleListing(var map){
// return Container(width: 100.w,color: Colors.yellow,child: Text('helo'),);
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(map['module'],textAlign: TextAlign.start),
        Row(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap:(){

              },
              child: Container(
                width: 50.w,
                alignment: Alignment.topLeft,
                child: Icon(Icons.edit),),
            ),
            InkWell(
              onTap: (){
                myAlert('Delete', map['moduleId'],'module');
              },
              child: Container(
                width: 50.w,
                alignment: Alignment.topLeft,
                child: Icon(Icons.delete),),
            )
          ],
        ),

      ],
    );

}

  Widget subjectListing(var map){
// return Container(width: 100.w,color: Colors.yellow,child: Text('helo'),);
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(map['subject'],textAlign: TextAlign.start),
        Row(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap:(){
                editSubject(map['subjectId']);
              },
              child: Container(
                width: 50.w,
                alignment: Alignment.topLeft,
                child: Icon(Icons.edit),),
            ),
            InkWell(
              onTap: (){
                myAlert('Delete', map['subjectId'],'subject');
              },
              child: Container(
                width: 50.w,
                alignment: Alignment.topLeft,
                child: Icon(Icons.delete),),
            )
          ],
        ),

      ],
    );

  }
  void addSubject() async {
    if (subjectController.text == '') {
      Get.snackbar("Failed", "Please fill Subject Field",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
    else {
      SubjectEntity subjectEntity = SubjectEntity(
          subject: subjectController.text
      );
      try {
        setState(() {
          isSubjectLoading = true;
        });
        var result = await SubjectEntity.collection().add(
            subjectEntity);
        await SubjectEntity.subjectDoc(subjectId: result.id,).update(
            {"subjectId": result.id});
        subjectController.clear();
        Get.snackbar("congratulations", "Your data is Successfully stored",
          snackPosition: SnackPosition.BOTTOM,);

        setState(() {
          isSubjectLoading = false;
        });
        //clearTextFieldValue();
      } catch (e) {

      }
    }
  }

 void editSubject(var data)  {
    TextEditingController textEditingController=TextEditingController();
    print(data['subject'].toString());
    textEditingController.value=data['subject'];
    print(textEditingController.text);
    RxBool isRecordDelete = true.obs;
     // await Get.defaultDialog(
     //
     //    content: const Text("Alert Message"),
     //    title: "Are you shure you want to Edit",
     //    actions: [
     //      Row(
     //        mainAxisAlignment: MainAxisAlignment.center,
     //        children: [
     //          MyField(
     //            controller: textEditingController, label: 'Enter Subject',),
     //          Obx(
     //                () => ElevatedButton(
     //              onPressed: () async {
     //                isRecordDelete.value = false;
     //                await FirebaseFirestore.instance
     //                    .collection('subject')
     //                    .doc(data['subjectId']).update({'subject':data['subject']});
     //                isRecordDelete.value =  !isRecordDelete.value;
     //                quizPages.value=1;
     //                quizPages.value=0;
     //                Get.back();
     //                // isShowAllTestVisible.value = true;
     //                Get.snackbar("congratulations", "Your data is Successfully Update",snackPosition: SnackPosition.BOTTOM,);
     //              },
     //              style: ElevatedButton.styleFrom(
     //                  padding:
     //                  EdgeInsets.symmetric(horizontal: 11.w, vertical: 14.5.h),
     //                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3.w)))
     //              ),
     //              child: isRecordDelete.value
     //                  ? const Text("Ok")
     //                  :  Center(
     //                child: SizedBox(
     //                    height: 20.h,
     //                    width: 10.w,
     //                    child: const CircularProgressIndicator(color: AppTheme.whiteColor,)),
     //              ),
     //            ),
     //          ),
     //
     //          SizedBox(
     //            width: 10.w,
     //          ),
     //          MyFieldButton(
     //            buttonText: "No",
     //            width: 30.w,
     //            onTap: () {
     //              Get.back();
     //            },
     //            height: 30.h,
     //          ),
     //        ],
     //      )
     //    ]);
  }
  void addModule() async {
    if (moduleController.text == '') {
      Get.snackbar("Failed", "Please fill Module Field",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
    else {
      ModuleEntity moduleEntity = ModuleEntity(
          module: moduleController.text
      );
      try {
        setState(() {
          isModuleLoading = true;
        });
        var result = await ModuleEntity.collection().add(
            moduleEntity);
        await ModuleEntity.moduleDoc(subjectId: result.id,).update(
            {"moduleId": result.id});
        subjectController.clear();
        Get.snackbar("congratulations", "Your data is Successfully stored",
          snackPosition: SnackPosition.BOTTOM,);

        setState(() {
          isModuleLoading = false;
        });
        //clearTextFieldValue();
      } catch (e) {

      }
    }
  }
}
