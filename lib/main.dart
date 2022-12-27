import 'package:flutter/material.dart';
import 'package:store_aplication/theme.dart';
import 'package:store_aplication/ui/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(
        fontFamily: 'IranYekan', color: LightThemeColors.primaryTextColor);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
            subtitle1: defaultTextStyle.apply(
                color: LightThemeColors.secondaryTextColor),
            bodyText2: defaultTextStyle,
            button: defaultTextStyle,
            headline6: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
            caption: defaultTextStyle.apply(
                color: LightThemeColors.secondaryTextColor)),
        colorScheme: const ColorScheme.light(
            primary: LightThemeColors.primaryColor,
            secondary: LightThemeColors.secondaryColor,
            onSecondary: Colors.white),
        primarySwatch: Colors.blue,
      ),
      home: const Directionality(
          textDirection: TextDirection.rtl, child: HomeScreen()),
    );
  }
}
