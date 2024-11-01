import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _formkey = GlobalKey<FormState>();
  var _currencies = ["Dollor", "Rupees", "Pound"];
  var _currentselectedItem = "Rupees";
  var displayResult = "";

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Interest Calculator"),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: [
            Image.asset(
              "assets/images/Finance-icon.png",
              width: 350.0,
              height: 275.0,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: principalController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter a principal amount";
                }
              },
              decoration: InputDecoration(
                labelText: "Principal Amount",
                hintText: "Enter a principal amount e.g 15000",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: roiController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter a rate of interest";
                }
              },
              decoration: InputDecoration(
                labelText: "Rate of Interest",
                hintText: "Enter a percentage e.g 15",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: termController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a term";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Term",
                      hintText: "Term in Years e.g 10",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: DropdownButton(
                    items: _currencies.map((value) {
                      return DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (newSelectedValue) {
                      setState(() {
                        this._currentselectedItem = newSelectedValue!;
                      });
                    },
                    value:
                        _currentselectedItem, // default value as "Rupees" to avoid null
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_formkey.currentState!.validate()) {
                        this.displayResult = calculateInterese();
                      }
                    });
                  },
                  child: Text("Calculate"),
                ),
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      resetFields();
                    });
                  },
                  child: Text("Reset"),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(child: Text(displayResult)),
          ],
        ),
      ),
    );
  }

  String calculateInterese() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalPayable = principal + (principal * roi * term) / 100;
    String result =
        "After $term years, your investment will be worth of $totalPayable in $_currentselectedItem";

    return result;
  }

  void resetFields() {
    principalController.text = "";
    roiController.text = "";
    termController.text = "";
    _currentselectedItem = _currencies[1];
    displayResult = "";
  }
}
