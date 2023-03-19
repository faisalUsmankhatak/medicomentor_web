import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medicomentor_web/question_answer_screen.dart';

import 'package:medicomentor_web/test_screen.dart';

import 'add_new_bank_question_screen.dart';
import 'add_quiz_details__with_bank_question.dart';
import 'bank_question_listing_screen.dart';
import 'common_screen.dart';
import 'edit_delete_quiz_screen.dart';
import 'input_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  List<Widget> pages = [Obx(()=> quizPages.value==0?const TestScreen():quizPages.value==1? const EditDeleteQuizScreen():QuestionAnswerScreen()), Obx(()=> bankQuestion.value==0? BankQuestionListingScreen():bankQuestion.value==1?AddNewBankQuestionScreen():AddQuizWithBankQuestionScreen()),InputScreen()];

  @override
  Widget build(BuildContext context) {
    print(quizPages.value.toString());
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: AppTheme.backBroundColor,
          currentIndex: currentPage.value,
          onTap: (val){
            currentPage.value=val;

          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.filter_tilt_shift), label: "Quiz"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Bank Question"),
            BottomNavigationBarItem(icon: Icon(Icons.input_outlined), label: "Input")
          ],
        ),
      ),
      body: Obx(()=> pages[currentPage.value])
    ),

    );
  }
}


// class MyField extends StatelessWidget {
//   TextEditingController controller;
//   String label;
//   String? suffixIcon;
//   String? prefixIcon;
//   Color? fillColor;
//   GestureTapCallback? suffixIconTab;
//   bool? obscureText;
//   MyField({required this.controller, required this.label, this.suffixIcon, this.prefixIcon,
//     this.fillColor,this.suffixIconTab,this.obscureText});
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap:suffixIconTab ,
//       child: TextFormField(
//           controller: controller,
//           obscureText: obscureText??false,
//           decoration: InputDecoration(
//             label: Text(label),
//             //hintText: label,
//             fillColor:fillColor??AppTheme.texFieldColor,
//
//             filled: true,
//             labelStyle: AppTheme.formLabelStyle(),
//             // prefixIcon:Padding(padding: EdgeInsets.only(left: 1.w)),
//             // prefixIcon==null?const SizedBox(width: 1,):Padding(
//             //   padding:  EdgeInsets.only(bottom: 6.h),
//             //   child: Container(
//             //     width: 19.w,height: 15.h,
//             //     decoration:  BoxDecoration(
//             //         image: DecorationImage(image: AssetImage(prefixIcon!))
//             //     ),
//             //   ),
//             // ),
//             suffixIcon: suffixIcon==null?const SizedBox(width:2 ,height: 2,):GestureDetector(
//               onTap: suffixIconTab,
//               child: Container(
//                 width: 19.w,height: 15.h,
//                 decoration: BoxDecoration(image: DecorationImage(image: AssetImage(suffixIcon!))),
//               ),
//             ),
//             disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.w,),
//                 borderSide: const BorderSide(color: AppTheme.texFieldColor)),
//             enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.w,),
//                 borderSide: const BorderSide(color:AppTheme.texFieldColor)),
//             focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.w,),
//                 borderSide: const BorderSide(color: AppTheme.texFieldColor)),
//
//           )
//       ),
//     );
//   }
// }
