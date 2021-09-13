import 'package:crypto_font_icons/crypto_font_icon_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto_font_icons/crypto_font_icons.dart';

const apiKey = '85CF044A-57E5-4F15-8BD4-7C1A9B4D225F';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String don = 'AUD';
  String x = '?', y = '?', z = '?', a = '?', b = '?';

  @override
  void initState() {
    super.initState();
    getData('AUD','BTC');
    getData('AUD','ETH');
    getData('AUD','LTC');
    getData('AUD','DOGE');
    getData('AUD','DASH');
  }

  Future<double> getData(String fin , String ini) async {
    var response = await http.get(Uri.parse('https://rest.coinapi.io/v1/exchangerate/$ini/$fin?apikey=$apiKey'));

    double ratey = jsonDecode(response.body)['rate'];

    if(ini == 'BTC')
      {
        x = ratey.toStringAsFixed(2);
      }
    else if(ini == 'ETH')
      {
        y = ratey.toStringAsFixed(2);
      }
    else if(ini == 'LTC')
    {
      z = ratey.toStringAsFixed(2);
    }
    else if(ini == 'DOGE')
    {
      a = ratey.toStringAsFixed(2);
    }
    else if(ini == 'DASH')
    {
      b = ratey.toStringAsFixed(2);
    }
  }

  String selectedCurrency = 'AUD';

  List<Text> getDropdownItems() {
    List<Text> dropdownItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];

      dropdownItems.add(
        Text(
          currency,
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return dropdownItems;
  }

  Widget getRow(icon, String val) {

    String exact = '1 $val = $x $don';
    if(val == 'ETH')
      {
        exact = '1 $val = $y $don';
      }
    else if(val == 'LTC')
      {
        exact = '1 $val = $z $don';
      }
    else if(val == 'DOGE')
      {
        exact = '1 $val = $a $don';
      }
    else if(val == 'DASH')
      {
        exact = '1 $val = $b $don';
      }
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.red,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          leading: Icon(icon),
          title: Padding(
            padding:
            EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 10.0),
            child: Text(
              exact,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Exchange'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          getRow(CryptoFontIcons.BTC,'BTC'),
          getRow(CryptoFontIcons.ETH,'ETH'),
          getRow(CryptoFontIcons.LTC,'LTC'),
          getRow(CryptoFontIcons.DOGE,'DOGE'),
          getRow(CryptoFontIcons.DASH,'DASH'),
          SizedBox(
            height: 40.0,
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              color: Colors.deepPurple,
              child: CupertinoPicker(
                backgroundColor: Color(0xFF1D1E33),
                itemExtent: 40.0,
                onSelectedItemChanged: (idx) {
                  getData(currenciesList[idx],'BTC');
                  getData(currenciesList[idx],'ETH');
                  getData(currenciesList[idx],'LTC');
                  getData(currenciesList[idx],'DOGE');
                  getData(currenciesList[idx],'DASH');
                  setState(() {
                    don = currenciesList[idx];
                  });
                },
                children: getDropdownItems(),
              )),
        ],
      ),
    );
  }
}

// DropdownButton<String>(
// value: selectedCurrency,
// items: getDropdownItems(),
// onChanged: (value){
// setState((){
// selectedCurrency = value;
// });
// }
// ),
