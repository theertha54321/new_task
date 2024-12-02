import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_task/view/topics_screen/topics_screen.dart';
import 'package:share_plus/share_plus.dart';

class ResultScreen extends StatefulWidget {
  
  final int toatalQ;
  final int correctAns;

  const ResultScreen({super.key,required this.toatalQ,required this.correctAns});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
   int starCount=0;
   @override
  void initState() {
    
    calPercentage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(3, (index)=>
            Padding(
              padding:  EdgeInsets.only(right: 15,left: 15,bottom: index ==1 ? 30 : 0),
              child: Icon(Icons.star,
              color: starCount>index ? Colors.yellow : Colors.grey ,
              size: index ==1 ? 70 : 40,
              ),
            )
            ),
           
          ),
          CachedNetworkImage(
            height: 100,
            width: 100,
        imageUrl: "https://media.istockphoto.com/id/1411591660/photo/well-done-text-note.jpg?b=1&s=612x612&w=0&k=20&c=3x_bkqHHDUlUTvDkTdjAR5iFd8uyroT0rAA-xpo3ti0=",
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
     ),
          SizedBox(height: 30,),
          Text("${answerMessage()}",style: TextStyle(color: Colors.yellow,fontSize: 24,fontWeight: FontWeight.w500)),
           SizedBox(height: 30,),
           Text("Your Score",style: TextStyle(color: Colors.white,fontSize: 12)),
           SizedBox(height: 10,),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${widget.correctAns}',style: TextStyle(color: Colors.yellow,fontSize: 16),),
                Text("/",style: TextStyle(color: Colors.yellow,fontSize: 16)),
                Text("${widget.toatalQ}",style: TextStyle(color: Colors.yellow,fontSize: 16))
              ],
            ),
          SizedBox(height: 40,),
           InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    TopicsScreen()
                    
                    ));
            },
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16),
               child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.circular(6)
                 ),
                 alignment: Alignment.center,
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                    Icon(Icons.refresh,color: Colors.black,size: 14,),
                    SizedBox(width: 8,),
                     Text("Retry",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                   ],
                 ),
               ),
             ),
           ),
           SizedBox(height: 30,),
           InkWell(
            onTap: (){
              Share.share('check out my website https://example.com');
            },
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16),
               child: Container(
                height: 50,
                width: 70,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.circular(6)
                 ),
                 alignment: Alignment.center,
                 child: Icon(Icons.share,color: Colors.black,size: 14,),
               ),
             ),
           ),

        ],
      ),
    );
  }

  String answerMessage() {
  num percent = (widget.correctAns / widget.toatalQ) * 100;
  if (percent >= 30) {
    return "Congratulations"; 
  } else {
    return "Better Luck Next Time"; 
}
  }


   calPercentage(){
  num percent =(widget.correctAns/widget.toatalQ)*100;
  if(percent>=90){
    starCount=3;
  }
  else if(percent>=50){
    starCount=2 ;
  }
  else if(percent>=30){
    starCount=1 ;
  }
  setState(() {
    
  });
}
}
