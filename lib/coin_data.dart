import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

// const bitcoinAverageURL = 'https://apiv2.bitcoinaverage.com/indices/global/ticker';
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '4787ECEB-AA77-459E-8883-1A4AC42309A3';

class CoinData {
  //3. Create the Asynchronous method getCoinData() that returns a Future (the price data).
  Future getCoinData(String? selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    //4: Use a for loop here to loop through the cryptoList and request the data for each of them in turn.
    //5: Return a Map of the results instead of a single value.
    for (String crypto in cryptoList) {
      String requestURL =
          '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';
      var uri = Uri.parse(requestURL);
      http.Response response = await http.get(uri);

      //6. Check that the request was successful.
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        //8. Get the last price of bitcoin with the key 'last'.
        double lastPrice = decodedData["rate"];
        cryptoPrices[crypto] =  lastPrice.toStringAsFixed(0);
      } else {
        //10. Handle any errors that occur during the request.
        print(response.statusCode);
        //Optional: throw an error if our request fails.
        throw 'Problem with the get request';
      }
    }

    return cryptoPrices;
  }
}
