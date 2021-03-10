import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 20;

  Widget calcButton(String btnText, Color btnColor, Color textColor){
    return Container(
      height: MediaQuery.of(context).size.height*0.1*1,
      width: MediaQuery.of(context).size.width*0.25,
      child: RaisedButton(
        onPressed: (){
          //TODO add function for button press
          calculation(btnText);
        },
        child: Text('$btnText',
          style: TextStyle(
            fontSize: 35,
            color: textColor,
          ),
        ),
        // shape: Border(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
        ),
        color: btnColor,
        padding: EdgeInsets.all(20.0),
       ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(title: Text('Calculator'), backgroundColor: Colors.black,),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            //Calculator display
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('$text',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Here buttons function will be called where we will pass some arguments
                calcButton('C', Colors.grey[800], Colors.white),
                calcButton('+/-', Colors.grey[800], Colors.white),
                calcButton('%', Colors.grey[800], Colors.white),
                calcButton('/', Colors.amber[700], Colors.white),
              ],
            ),
            SizedBox(height: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Here buttons function will be called where we will pass some arguments
                calcButton('7', Colors.grey[600], Colors.white),
                calcButton('8', Colors.grey[600], Colors.white),
                calcButton('9', Colors.grey[600], Colors.white),
                calcButton('x', Colors.amber[700], Colors.white),
                // SizedBox(width: 50,)
              ],
            ),
            SizedBox(height: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Here buttons function will be called where we will pass some arguments
                calcButton('4', Colors.grey[600], Colors.white),
                calcButton('5', Colors.grey[600], Colors.white),
                calcButton('6', Colors.grey[600], Colors.white),
                calcButton('-', Colors.amber[700], Colors.white),
              ],
            ),
            SizedBox(height: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Here buttons function will be called where we will pass some arguments
                calcButton('1', Colors.grey[600], Colors.white),
                calcButton('2', Colors.grey[600], Colors.white),
                calcButton('3', Colors.grey[600], Colors.white),
                calcButton('+', Colors.amber[700], Colors.white),
              ],
            ),
            SizedBox(height: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //This is button 0
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(40, 25, 151, 25),
                  onPressed: (){
                    //Button function
                    calculation('0');
                  },
                  shape: Border(),
                  child: Text("0",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white
                  ),
                  ),
                  color: Colors.grey,
                ),
                calcButton('.', Colors.grey[600], Colors.white),
                calcButton('=', Colors.amber[700], Colors.white),
              ],
            ),
            SizedBox(height: 1,),
          ],
        ),
      ),

    );
  }
  //Calculation logic
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {


    if(btnText  == 'C') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';

    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
        finalResult = add();
      } else if( preOpr == '-') {
        finalResult = sub();
      } else if( preOpr == 'x') {
        finalResult = mul();
      } else if( preOpr == '/') {
        finalResult = div();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();
      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == 'x') {
        finalResult = mul();
      } else if( opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';

    }
    else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;

    }

    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      text = finalResult;
    });

  }


  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
