import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:new_task/view/quiz_screen/quiz_screen.dart';

class TopicsScreen extends StatelessWidget {
   


  const TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
   final List colors = [
  Colors.blueAccent,
  Colors.lightGreenAccent,
  Colors.orangeAccent,
  Colors.purpleAccent,
  Colors.pinkAccent,
  Colors.tealAccent,
];
    final contents = ['General Knowledge', 'Sports', 'Technology', 'Science','History','Entertainment','Chemistry'];

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu,color: Colors.black,),
        title: const Text("Quiz Topics",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
           
          ),
         
          itemCount: contents.length,
          itemBuilder: (context, index) =>
             InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(content: contents[index],
                    ),
                  ),
                );
              },
              child: Container(
                 height:  100,
                decoration: BoxDecoration(
                  color:colors[index % colors.length] ,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                alignment: Alignment.center,
                child: Text(
                 contents[index],
                  style:  TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          
        ),
      ),
    );
  }
}
