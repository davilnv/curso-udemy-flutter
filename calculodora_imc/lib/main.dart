import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    // IMC = Peso ÷ (Altura × Altura)
    double imc = weight / (height * height);
    String infor = "";
    if (imc >= 0 && imc <= 18.5) {
      infor = "Abaixo do peso, IMC: ${imc.toStringAsPrecision(3)}";
    } else if (imc > 18.5 && imc <= 24.9) {
      infor = "Peso Normal, IMC: ${imc.toStringAsPrecision(3)}";
    } else if (imc >= 25 && imc <= 29.9) {
      infor = "Sobrepeso, IMC: ${imc.toStringAsPrecision(3)}";
    } else if (imc >= 30 && imc <= 34.9) {
      infor = "Obesidade Grau I, IMC: ${imc.toStringAsPrecision(3)}";
    } else if (imc >= 35 && imc <= 39.9) {
      infor = "Obesidade Grau II, IMC: ${imc.toStringAsPrecision(3)}";
    } else {
      infor =
          "Obesidade Grau III ou Mórbida, IMC: ${imc.toStringAsPrecision(3)}";
    }

    setState(() {
      _infoText = infor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
                controller: weightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira seu peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
                controller: heightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira sua altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
