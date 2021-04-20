import 'package:flutter_bloc/flutter_bloc.dart';

class BlocUtils {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  BlocUtils._();

  static void printTransition(Transition t) {
    print(  
        "Transition\n   cs: " +
        t.currentState.toString() +
        "\n   ev: " +
        t.event.toString() +
        "\n   ns: " +
        t.nextState.toString()
    );
  }

  
}
