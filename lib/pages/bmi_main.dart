import 'package:flutter/material.dart';


class Bmimain extends StatefulWidget {
  const Bmimain({ Key? key }) : super(key: key);

  @override
  _BmimainState createState() => _BmimainState();
}

class _BmimainState extends State<Bmimain> {
  TextEditingController txtHight = TextEditingController();
  TextEditingController txtWidth = TextEditingController();
  String _result = "0";
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('BMI Calculator',),
        ),
      ),
      
      body: Center(
        child: Container(
          decoration: const BoxDecoration(),
          child: Column(
            children: <Widget>[
              talllisttile(),
              weightlisttile(),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  color: Color.fromRGBO(255, 250, 205, 10),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text('   ผล BMI คือ $_result   ',
                    ),
                  ),
                ),
              ),
              call(context),
            ],
          ),
        ),
      ),
    );
  }

  ListTile weightlisttile() {
    return ListTile(
      leading: Icon(Icons.add_chart),
      title: TextField(
        controller: txtWidth,
        maxLength: 3,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'ระบุน้ำหนัก (kg)',
        ),
      ),
    );
  }

  ListTile talllisttile() {
    return ListTile(
      leading: Icon(Icons.height),
      title: TextField(
        controller: txtHight,
        maxLength: 3,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'ระบุส่วนสูง (cm)',
        ),
      ),
    );
  }


  Widget call(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.tealAccent),
          foregroundColor: MaterialStateProperty.all(Colors.blue),
        ),
        onPressed: () {
          //print('ส่วนสูง:'+txtHight.text+', น้ำหนัก :'+txtWidth.text);
          setState(() {
            //Body Mass Index (BMI) มีสูตรการคำนวณ = น้ำหนักตัว[Kg] / (ส่วนสูง[m] ยกกำลังสอง)
            var _heightM = double.parse(txtHight.text) /
                100; //ประกาศตัวแปร _heightM มารับค่าส่วนสูง cm แปลงเป็น m
            var _bmi = double.parse(txtWidth.text) / (_heightM * _heightM);
            _result = _bmi.toStringAsFixed(3);
            if (_bmi >= 40) {
              _result = "อ้วนระดับ 3 (อ้วนระดับรุนแรงมาก)";
            } else if (_bmi >= 30) {
              _result = "อ้วนระดับ 2 (อ้วนมาก)";
            } else if (_bmi >= 25) {
              _result = "อ้วนระดับ 1 (อ้วนระยะเริ่มต้น)";
            } else if (_bmi >= 23) {
              _result = "น้ำหนักเกิน (ท้วม)";
            } else if (_bmi >= 18.5) {
              _result = "น้ำหนักปกติ";
            } else {
              _result = "น้ำหนักน้อยเกินไป";
            }
            //print(_bmi);

            //สร้าง popup แสดงผลลัพธ์
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return Text('$_result');
                  //เรียก dialog ที่เป็น widget ของ Scaffold จะทำให้สวยงาม
                  return AlertDialog(
                    title: Center(
                        child: Text('ผล BMI ของคุณ',)
                      ),
                    content: Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Container(
                        width: 300,
                        height: 170,
                        color: Color.fromRGBO(255, 245, 238, 10),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Column(
                            children: <Widget>[
                              //Text('มีค่า BMI=$_bmi'),
                              Text('มีค่า BMI เท่ากับ',),
                              const SizedBox(height: 12),
                              Text(' ${_bmi.toStringAsFixed(3)}',),
                              const SizedBox(height: 12),
                              Text('คุณอยู่ในเกณฑ์ : ',),
                              const SizedBox(height: 12),
                              Text('$_result',),
                            ],
                          ),
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      // ignore: deprecated_member_use
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('ปิด',),
                        color: Colors.greenAccent[200],
                      ),
                    ],
                  );
                });
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Text('คำนวน',),
        ),
      )
    );
  }
}
