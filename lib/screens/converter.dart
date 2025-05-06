import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:unit_currency_converter/ad_helper.dart';
import 'package:unit_currency_converter/providers/language_provider.dart';
import 'package:unit_currency_converter/widgets/drawer.dart';

import '../models/square_button.dart';
import '../providers/selection_provider.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  BannerAd? _bannerAd;

  final List<String> buttonLabelsEnglish = [
    'Currency',
    'Height',
    'Weight',
    'Temp.',
    'Time'
  ];

  final List<String> buttonLabelsBangla = [
    'মুদ্রা',
    'উচ্চতা',
    'ওজন',
    'তাপমাত্রা',
    'সময়'
  ];

  final List<String> buttonIcons = [
    'assets/icons/currency.png',
    'assets/icons/height.png',
    'assets/icons/weight.png',
    'assets/icons/temperature.png',
    'assets/icons/time.png'
  ];

  final Map<int, List<String>> dropdownOptions = {
    0: ['USD', 'EUR', 'BDT', 'INR', 'GBP', 'CAD'],
    1: ['Feet', 'Meters', 'Inches', 'Centimeters'],
    2: ['Kg', 'Lb', 'Oz', 'Stone'],
    3: ['Celsius', 'Fahrenheit', 'Kelvin'],
    4: ['Seconds', 'Minutes', 'Hours', 'Days'],
  };

  final myTextController = TextEditingController();
  String _output = '';

  @override
  void initState(){
    super.initState();
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

  @override
  void dispose() {
    myTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final dropdownProvider = Provider.of<SelectionProvider>(context);

    return Scaffold(
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
                    label: languageProvider.isEnglish ? buttonLabelsEnglish[index] : buttonLabelsBangla[index],
                    isSelected: isSelected,
                    onTap: (){
                      dropdownProvider.selectIndex(index);
                    }
                  );
                })
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  const SizedBox(width: 20,),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: myTextController,
                      onChanged: (text) {
                        setState(() {
                          _output = text;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Enter value",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12)
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
                  Icon(
                    Icons.arrow_forward,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),

                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        _output,
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
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // add a calculator here

              if(_bannerAd != null)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  ),
                )
            ]
          )
        ],
      )
    );
  }
}