import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:unit_currency_converter/services/ad_helper.dart';
import 'package:unit_currency_converter/providers/language_provider.dart';
import 'package:unit_currency_converter/services/ad_loader.dart';
import 'package:unit_currency_converter/widgets/drawer.dart';

import '../constant/converter_constants.dart';
import '../conversions/convert_currency.dart';
import '../conversions/convert_height.dart';
import '../conversions/convert_temperature.dart';
import '../conversions/convert_time.dart';
import '../conversions/convert_weight.dart';
import '../models/button_values.dart';
import '../models/square_button.dart';
import '../providers/selection_provider.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  BannerAd? _bannerAd;

  String inputValue = '';
  String outputValue = '';

  @override
  void initState(){
    super.initState();
    inputValue = '';
    outputValue = '';
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        }
      )
    ).load();
  }

  Future<void> performConversion() async {
    final dropdownProvider = Provider.of<SelectionProvider>(context, listen: false);
    final from = dropdownProvider.firstSelectedValue;
    final to = dropdownProvider.secondSelectedValue;
    final category = dropdownProvider.selectedIndex;

    double? input = double.tryParse(inputValue);
    if (input == null || from == null || to == null) {
      setState(() {
        outputValue = 'Invalid';
      });
      return;
    }

    double? result;

    switch (category) {
      case 0: // Currency
        result = await convertCurrency(input, from, to);
        break;
      case 1:
        result = convertHeight(input, from, to);
        break;
      case 2:
        result = convertWeight(input, from, to);
        break;
      case 3:
        result = convertTemperature(input, from, to);
        break;
      case 4:
        result = convertTime(input, from, to);
        break;
      default:
        result = null;
    }

    setState(() {
      outputValue = result != null ? result.toStringAsFixed(2) : 'Invalid';
    });
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final dropdownProvider = Provider.of<SelectionProvider>(context);

    final screenSize = MediaQuery.of(context).size;

    final buttonLabels = languageProvider.isEnglish ? buttonLabelsEnglish : buttonLabelsBangla;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          languageProvider.isEnglish ? 'Bangla Unit Currency Converter' : 'বাংলা একক মুদ্রা রূপান্তরকারী'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
       ),
      drawer: MyDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                children: List.generate(buttonLabelsEnglish.length, (index){
                  final isSelected = dropdownProvider.selectedIndex == index;

                  return SquareButton(
                    imagePath: buttonIcons[index],
                    label: buttonLabels[index],
                    isSelected: isSelected,
                    onTap: (){
                      dropdownProvider.selectIndex(index);
                      inputValue = '';
                      outputValue = '';
                    }
                  );
                })
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.outline),
                      ),
                      child: Text(
                        inputValue,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),

                  const SizedBox(width: 30),

                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<String>(
                      value: dropdownProvider.firstSelectedValue,
                      isExpanded: true,
                      hint: Text("Select an option"),
                      items: dropdownOptions[dropdownProvider.selectedIndex]!
                        .toSet()
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                          )).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          dropdownProvider.selectFirstValue(value);
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12)
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),
                ],
              ),

              const SizedBox(height: 20,),

              Row(
                children: [
                  const SizedBox(width: 20),

                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.outline),
                      ),
                      child: Text(
                        outputValue,
                        style: TextStyle(fontSize: 18),
                      ),

                    ),
                  ),

                  const SizedBox(width: 30),

                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<String>(
                      value: dropdownProvider.secondSelectedValue,
                      isExpanded: true,
                      hint: Text("Select an option"),
                      items: dropdownOptions[dropdownProvider.selectedIndex]!
                          .toSet()
                          .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      )).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          dropdownProvider.selectSecondValue(value);
                        }
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12)
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),
                ],
              ),

              const SizedBox(height: 20,),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Wrap(
                children: Button.buttonValues
                  .map(
                    (value) => SizedBox(
                      width: value == Button.ok ? (screenSize.width / 2) : screenSize.width / 4,
                      height: screenSize.height / 10,
                      child: buildButton(value),
                    ),
                  ).toList(),
              ),

              const SizedBox(height: 5,),

              if(_bannerAd != null)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AdLoader(bannerAd: _bannerAd!),
                )
            ]
          )
        ],
      )
    );
  }

  void _onButtonTap(String value) {
    setState(() {
      if (value == Button.del) {
        inputValue = inputValue.isNotEmpty ? inputValue.substring(0, inputValue.length - 1) : '';
      } else if (value == Button.clear) {
        inputValue = '';
      } else if (value == Button.ok) {
        performConversion();
      } else {
        inputValue += value;
      }
    });
  }

  Widget buildButton(String value) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Material(
        color: getButtonColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.inversePrimary,
            width: 1,
          ),
        ),
        child: InkWell(
          onTap: () {
            if (value == Button.del) {
              setState(() {
                inputValue = inputValue.isNotEmpty ? inputValue.substring(0, inputValue.length - 1) : '';
              });
            } else if (value == Button.clear) {
              setState(() {
                inputValue = '';
              });
            } else if (value == Button.ok) {
              // Handle OK button action
              performConversion();
            } else if (value == Button.dot) {
              setState(() {
                inputValue += '.';
              });
            } else if (value == Button.zeroZero) {
              setState(() {
                inputValue += '00';
              });
            } else {
              setState(() {
                inputValue += value;
              });
            }
          },
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: [Button.del, Button.clear].contains(value)?
                  Colors.white :
                [Button.ok,].contains(value)?
                  Colors.white :
                [Button.dot].contains(value)? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color getButtonColor(value) {
    return [Button.del, Button.clear].contains(value)?
    Colors.red :
    [Button.ok,].contains(value)?
    Colors.green : [Button.dot,].contains(value) ? Colors.blue :
    Colors.grey;
  }
}