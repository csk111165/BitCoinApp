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

  List<DropdownMenuItem<String>> getDropdownItems() {

    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {

      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency)
        );

      dropdownItems.add(newItem);
    }
    return dropdownItems;
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
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
            child: CupertinoPicker(
              itemExtent: 32.0, 
              onSelectedItemChanged: (selectedIndex){
              print(selectedIndex);
            }, 
            children: [
                Text('USD'),
                Text('USD'),
                Text('USD'),
                Text('USD'),
                Text('USD'),
                Text('USD'),
                Text('USD'),
                Text('USD'),
                 Text('USD'),
                Text('USD'),
                Text('USD'),
                Text('USD'),
                Text('USD'),
                Text('USD'),
                Text('USD'),
                Text('USD'),
            ],
            ),
          ),
        ],
      ),
    );
  }
}


//  DropdownButton<String>(
//               value:selectedCurrency, // this is to show the first item on the dropdown , by default it will be empty
//               items: getDropdownItems(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedCurrency = value;
//                 });
//               },
//             ),
