import 'package:flutter/material.dart';

import 'package:new_task/view/quiz_screen/quiz_screen.dart';
import 'package:new_task/view/topics_screen/topics_screen.dart';

void main(){
runApp(MyWidget());
}
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:TopicsScreen()
    );
  }
}

