import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:bitcoin_app/coin_data.dart";

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  //value had to be updated into a Map to store the values of all three cryptocurrencies.
  Map<String, String> coinValues = {};
  //7: Figure out a way of displaying a '?' on screen while we're waiting for the price data to come back. First we have to create a variable to keep track of when we're waiting on the request to complete.
  bool isWaiting = false;


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
          selectedCurrency = value!;
          // we are calling getData here so that selectedCurrency can be passed to getCoinData() to get the respective price
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
  
  String bitcoinValue  = '?';

  void getData() async {
    //7: Second, we set it to true when we initiate the request for prices.
    isWaiting = true;

    try {
      CoinData coinData = CoinData();
      //6: Update this method to receive a Map containing the crypto:price key value pairs.
      var data = await coinData.getCoinData(selectedCurrency);
      //7. Third, as soon the above line of code completes, we now have the data and no longer need to wait. So we can set isWaiting to false.
      isWaiting = false;
      setState(() {
        coinValues = data;
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
        children: [ 
          CryptoCard(
                cryptoCurrency: 'BTC',
                //7. Finally, we use a ternary operator to check if we are waiting and if so, we'll display a '?' otherwise we'll show the actual price data.
                value: isWaiting ? '?' : coinValues['BTC'],
                selectedCurrency: selectedCurrency,
              ),
              CryptoCard(
                cryptoCurrency: 'ETH',
                value: isWaiting ? '?' : coinValues['ETH'],
                selectedCurrency: selectedCurrency,
              ),
              CryptoCard(
                cryptoCurrency: 'LTC',
                value: isWaiting ? '?' : coinValues['LTC'],
                selectedCurrency: selectedCurrency,
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

class CryptoCard extends StatelessWidget {
  //2: You'll need to able to pass the selectedCurrency, value and cryptoCurrency to the constructor of this CryptoCard Widget.
  const CryptoCard({super.key,  this.value, this.selectedCurrency, this.cryptoCurrency });

  final String? value;
  final String? selectedCurrency;
  final String? cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}



