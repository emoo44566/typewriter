import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main/main_screen.dart';

class TypewriterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    return MaterialApp(
      theme: ThemeData(
        // rgb(32,37,70) rgb(19,24,48)   rgb(227,58,84)  rgb(241,241,241)
        primaryColor: Color.fromRGBO(200, 100, 100, 1),
        accentColor: Color.fromRGBO(72, 74, 126, 1),
        // brightness: Brightness.dark,
        // backgroundColor: Color.fromRGBO(244, 244, 244, 1)
        fontFamily: 'poppins',
        textTheme: TextTheme(
          headline1: GoogleFonts.poppins(
              fontSize: 36.0,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(10, 10, 10, 1)),
          headline2: GoogleFonts.poppins(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(10, 10, 10, 1)),
          headline3: GoogleFonts.poppins(
              fontSize: 28.0,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(10, 10, 10, 1)),
          headline4: GoogleFonts.poppins(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(10, 10, 10, 1)),
          headline5: GoogleFonts.poppins(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(10, 10, 10, 1)),
          headline6: GoogleFonts.poppins(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(10, 10, 10, 1)),
          bodyText2: GoogleFonts.poppins(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(10, 10, 10, 1)),
        ),
      ),
      title: 'Flutter Calendar',
      home: MultiBlocProvider(
        providers: [
          // BlocProvider(
          //   create: (_) => CalendarBloc(noteRepository),
          // ),
          // BlocProvider(
          //   create: (_) => MainBloc(),
          // ),
          // BlocProvider(
          //   create: (_) => NoteBloc(noteRepository),
          // ),
          // BlocProvider(
          //   create: (_) => AddNoteBloc(),
          // ),
        ],
        child: MainScreen(),
      ),
    );
  }
}
