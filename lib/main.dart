import 'package:flutter/material.dart';
double memory=1;
void main() {
  runApp(Starter());
}

class Starter extends StatelessWidget {
  const Starter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (
        MaterialApp(
            initialRoute: 'Home',
            routes: {
              'Start': (context) => Starter(),
              'Home' : (context) => Home(),
              "Act"  : (context) => Act(),
              "FinalPage": (context) => FinalPage()
            }
        )
    );
  }
}


class Home extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Center(
          child: Text("Press button to give a review"),
        ),
        floatingActionButton: FloatingActionButton(
         onPressed: (){
           Navigator.pushNamed(context, 'Act');
         },
         tooltip: "Begin",
          child: Icon(Icons.arrow_forward_outlined),
        ),

    );
  }
}


class Act extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text("Feedback Page"),
                centerTitle: true,

                ),
            body: Review(),
          ),

    );
  }
}

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {

  int k=0;
  double value = 1;
  bool flag = false;
  List<double> Score = [1,1,1,1,1,1];
  List<String> Questions = [" How did you like our service?"," How was our sanitation?"," How was the lighting?"," How was the sound quality?"," How likely are you to represent us to your friends?"," How likely is the possibility of you using our service again"];
  List<String> Report = ["We are sorry for your inconvenience","Hope we serve you better next time","We hope you come back next time."];
  List Color = [Colors.red,Colors.yellow,Colors.green];

  double add()
  {
    double sum=0;
    for(int i=0;i<6;i++)
      {
        sum = sum + Score[i];
      }
    return sum;
  }

  void onPressed()
  {
    if(k>0)
    {
      k--;
      setState(() {});
    }

  }
  void initState()
  {
    super.initState();
    k=0;
    value = 1;
  }

  @override
  Widget build(BuildContext context) {

    if(flag == false)
    {
      Score[k] = memory;
    }
    else
    {
      flag = false;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(

              child: Text("${Questions[k]}",
                //TODO -> Size manipulation ?
              ),

            ),
          ),
          Slider.adaptive(
            value: value,
            divisions: 4,
            min : 1.0,
            max : 5.0,
            label: "$value",
            onChanged: (newValue){
              setState((){
                flag = true;
                value = (newValue>0.0)?newValue:1;
                Score[k] = value;
                memory = value;
              });

            },

          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: (k>0)?onPressed:null,
                  child: Text("Previous"),
                  ),
              SizedBox(
                width: 30.0,
              ),
              ElevatedButton(
                  onPressed: (){
                    if(k==5)
                    {
                      int c=0;
                      double decider = add();
                      if(decider<=10){c=0;}
                      else if( 11<=decider && decider<=20){c=1;}
                      else if(decider > 20){c = 2;}

                      //display();
                      Navigator.pushNamed(context, 'FinalPage', arguments: {'data':Report[c],'color':Color[c]});
                    }
                    if(k<5)
                    {
                      k++;
                      setState(() {});
                    }

                  },
                  child: Text((k!=5)?"Next":"Results"),
                  ),
            ],
          ),
        ],
      ),

    );

  }
}

class FinalPage extends StatefulWidget {

  @override
  _FinalPageState createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
  @override
  Widget build(BuildContext context) {

    final Map data = ModalRoute.of(context)!.settings.arguments as Map;

    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            title: Text("Thank you"),
          ),
          body: Container(

            child: Center(
              child: Text(
                data['data'],
                style: TextStyle(
                  color: data['color'],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.popUntil(context, ModalRoute.withName('Home'));
              },
            child: Icon(Icons.repeat),
              tooltip: "Repeat",
          ),
        ),

    );
  }
}



