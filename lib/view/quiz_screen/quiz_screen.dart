
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:new_task/dummy_db.dart';
import 'package:new_task/view/result_screen/result_screen.dart';


class QuizScreen extends StatefulWidget {
   String content; 
   
   QuizScreen({super.key,required this.content});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  
  int score=0;
  int currentQuestionIndex=0;
  int? selectedAnswerIndex;


 
final CountDownController timeController = CountDownController();
final int questionDuration = 11; 


  @override
  Widget build(BuildContext context) {
   
    List<Map<String, dynamic>> displayQuest = DummyDb.getQuestions(widget.content);
     double progress =
        (currentQuestionIndex + 1) / displayQuest.length; 

    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.close_outlined,color: Colors.white,size: 16,)),
           title: Row(
          children: [
           



            Expanded(
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(4),
                value: progress,
                backgroundColor: Colors.grey.shade800,
                color: Colors.orange,
                minHeight: 5,
              ),
            ),
            SizedBox(width: 35),
            Text(
              '${currentQuestionIndex + 1}/${displayQuest.length}',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ],
        ),
        centerTitle: true,
          ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            
            children: [
                           

           
            Center(
              child: CircularCountDownTimer(
                duration: questionDuration,
                initialDuration: 0,
                controller: timeController,
                width: 50,
                height: 50,
                ringColor: Colors.grey.shade800,
                fillColor: Colors.blue,
                textStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                isReverse: true,
                isTimerTextShown: true,
                onComplete: () {
                  incrementQuestion(displayQuest);
                },
              ),
            ),
            
        
            
            SizedBox(height: 20),
              Expanded(
                child: Container(
                  height: 100,
                  width: double.infinity,
                 padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  alignment: Alignment.center,

                  child: Stack(
                    children: [
                      if(selectedAnswerIndex==displayQuest[currentQuestionIndex]["answerIndex"])
                    Align(
                      alignment: Alignment.center,
                      child: Lottie.asset('assets/animations/poperanimation.json')),
                     Align(
                      alignment: Alignment.center,
                      child: Text(displayQuest[currentQuestionIndex]["question"],style: TextStyle(color: Colors.white,fontSize: 12),))]),
                ),
              ),
              SizedBox(height:20 ,),
              
              
              Column(
                children: List.generate(4, (optionIndex)=>
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InkWell(
                    onTap: (){
                      if(selectedAnswerIndex==null){
                      selectedAnswerIndex=optionIndex;
                      setState(() {
                        
                      });
                      cAns(displayQuest);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white),
                              color: getColor(optionIndex,displayQuest)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(displayQuest[currentQuestionIndex]["options"][optionIndex],style:TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
                               
                                Icon(Icons.circle_outlined,color: Colors.white,)
                              ],
                            ),
                          ),
                  ),
                )
                ),
              ),
               if(selectedAnswerIndex!=null)
              InkWell(
                onTap: (){
                  
                  if(currentQuestionIndex<displayQuest.length-1 ){
                    currentQuestionIndex++;
                    setState(() {
                      
                    });
                    selectedAnswerIndex=null;
                    timeController.restart(); 
                  
                  }
                  else{
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    ResultScreen(toatalQ: displayQuest.length ,correctAns:score ,)
                    
                    ));
                  }
                 
                },
                
               
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.green.shade200,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: Text("Next",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                ),
              )
            ],
          ),
        ),
      );
  }
  Color getColor(int optionIndex, List<Map<String, dynamic>> displayQuest){


if(selectedAnswerIndex!=null){
  if(displayQuest[currentQuestionIndex]["answerIndex"]==optionIndex){
    
    return Colors.green;
  }
}




      if(selectedAnswerIndex==optionIndex){
        if(selectedAnswerIndex==displayQuest[currentQuestionIndex]["answerIndex"]){
        
          return Colors.green;
        }
        else{
          return Colors.red;
        }
      }
      else{
       return Colors.black;
      }
    }

void cAns( List<Map<String, dynamic>> displayQuest){
  if(displayQuest[currentQuestionIndex]["answerIndex"]==selectedAnswerIndex){
    score++;
  }
}

 
void incrementQuestion(List<Map<String, dynamic>> displayQuest) {
    if (currentQuestionIndex < displayQuest.length - 1) {
      setState(() {
        selectedAnswerIndex = null;
        currentQuestionIndex++;
      });
       timeController.restart();
      
    } else {
       Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          toatalQ: displayQuest.length,
          correctAns: score,
        ),
      ),
    );
      
    }
  }

 
  


}