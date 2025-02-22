import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<String> currencyList = ['Baht', 'MMK'];

class _HomeScreenState extends State<HomeScreen> {
  String currencyFrom = currencyList.first;
  String currencyTo = currencyList[1];
  TextEditingController rateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController currencyF = TextEditingController();
  TextEditingController currencyT = TextEditingController();
  double calculatedAmount = 0.0;
  bool isCalculated = false;

  double getRate() {
    return double.parse(rateController.text);
  }

  double getAmount() {
    return double.parse(amountController.text);
  }

  String getCurrencyF(){
    return currencyF.text;
  }

  String getCurrencyT(){
    return currencyT.text;
  }

  void rateCalculation() {
    double rate = getRate();
    double amount = getAmount();
    // rateController.clear();
    // amountController.clear();
    setState(() {
      calculatedAmount = rate * amount;
      isCalculated = true;
    });
    
    Future.delayed(Duration(seconds: 1),(){
        isCalculated = false;
    });
  }

  Widget calculatedCard(){
    String showAmount = getAmount().toStringAsFixed(2);
    String Cfrom = getCurrencyF();
    String Cto = getCurrencyT();
    String totalAmount = calculatedAmount.toStringAsFixed(2);
    return Card(
      color: Colors.purple[100],
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          '$showAmount $Cfrom=$totalAmount $Cto',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }

  void reset(){

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Currency Converter'),
          backgroundColor: Colors.purple[200],
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image(
                image: AssetImage('assets/currency-exchange.png'),
                height: 200,
              ),
              TextField(
                controller: rateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    label: Text('Rate'),
                    hintText: 'Enter Rate',
                    border: OutlineInputBorder()),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    label: Text('Amount'),
                    hintText: 'Enter Amount',
                    border: OutlineInputBorder()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownMenu(
                    controller: currencyF,
                    initialSelection: currencyList.first,
                    onSelected: (String? value) {
                      setState(() {
                        currencyFrom = value!;
                      });
                    },
                    dropdownMenuEntries: currencyList
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                  DropdownMenu(
                    controller: currencyT,
                    initialSelection: currencyList[1],
                    onSelected: (String? value) {
                      setState(() {
                        currencyTo = value!;
                      });
                    },
                    dropdownMenuEntries: currencyList
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if(rateController.text.isEmpty || amountController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please Enter Rate & Amount'),backgroundColor: Colors.red,
                        )
                    );
                  }else {
                    rateCalculation();

                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Convert',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
              ),
              if (isCalculated) calculatedCard()
            ],
          ),
        ),
      ),
    );
  }
}
