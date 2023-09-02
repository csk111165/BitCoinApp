import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:bitcoin_app/coin_data.dart";

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = 'USD';

  // for andriod
  DropdownButton<String> androidDropDown() {

    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {

      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency)
        );

      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value:selectedCurrency, // this is to show the first item on the dropdown , by default it will be empty
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  // for ios

  CupertinoPicker iOSPicker() {

    List<Widget> pickerItems = [];

    for( String currency in currenciesList){

      var newItem = Text(currency);
      pickerItems.add(newItem);
    }

    return CupertinoPicker(
        itemExtent: 32.0, 
        onSelectedItemChanged: (selectedIndex){
          setState(() {
            selectedCurrency = currenciesList[selectedIndex];
            getData();
          });
      }, 
      children: pickerItems,
      );
  }
  
  @override
  void initState() {
    print("init state is called");
    super.initState();
    getData();
  }
  
  String? bitcoinValue  = '?';

  void getData() async {

    try {
      CoinData coinData = CoinData();
      String data = await coinData.getCoinData(selectedCurrency);
      setState(() {
        bitcoinValue = data;
      });
    } catch(e) {
      print(e);
    }
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[ 
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child:  Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $bitcoinValue $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:  androidDropDown(), //Platform.isAndroid ? androidDropDown() :iOSPicker(), // this works in android simulator not in web
            ),
        ],
      ),
    );
  }
}



