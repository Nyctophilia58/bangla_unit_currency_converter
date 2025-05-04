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

  final List<String> buttonLabels = ['Currency', 'Height', 'Weight', 'Temp.', 'Time'];

  final Map<int, List<String>> dropdownOptions = {
    0: ['USD', 'EUR', 'BDT'],
    1: ['Feet', 'Meters', 'Inches'],
    2: ['Kg', 'Lb', 'Stone'],
    3: ['Celsius', 'Fahrenheit'],
    4: ['Seconds', 'Minutes', 'Hours'],
  };

  final myTextController = TextEditingController();

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
                children: List.generate(buttonLabels.length, (index){
                  final isSelected = dropdownProvider.selectedIndex == index;

                  return SquareButton(
                    label: buttonLabels[index],
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
                  Expanded(
                    flex: 2,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter value",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12)
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<String>(
                      value: dropdownProvider.selectedValue,
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          value: null,
                          child: Text(
                            dropdownOptions[dropdownProvider.selectedIndex]![0],
                          ),
                        ),
                        ...dropdownOptions[dropdownProvider.selectedIndex]!
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                          )),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          dropdownProvider.selectValue(value);
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12)
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          if(_bannerAd != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            )
        ],
      )
    );
  }
}