import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'home_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDufxDh7GL1ZnpQO7bYJhEBLLIkDuhDg4U",
          authDomain: "medico-d7a21.firebaseapp.com",
          projectId: "medico-d7a21",
          storageBucket: "medico-d7a21.appspot.com",
          messagingSenderId: "136646324204",
          appId: "1:136646324204:web:046df28b811396305d1ac9",
          // measurementId: "G-QP41TDPKEM"

  ),);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Medico Mentor',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: const HomeScreen(),
      //const HomeScreen(),
    );
  }

}





