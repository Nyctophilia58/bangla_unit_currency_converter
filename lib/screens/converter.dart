import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:unit_currency_converter/services/ad_helper.dart';
import 'package:unit_currency_converter/services/ad_loader.dart';
import 'package:unit_currency_converter/services/iap_service.dart';
import 'package:unit_currency_converter/providers/language_provider.dart';
import 'package:unit_currency_converter/widgets/drawer.dart';
import '../constant/converter_constants.dart';
import '../conversions/convert_currency.dart';
import '../conversions/convert_height.dart';
import '../conversions/convert_temperature.dart';
import '../conversions/convert_time.dart';
import '../conversions/convert_weight.dart';
import '../models/button_values.dart';
import '../providers/selection_provider.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  BannerAd? _bannerAd;
  final IAPService _iapService = IAPService();
  String inputValue = '';
  String outputValue = '';
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _inputController.text = "";
    inputValue = '';
    outputValue = '';
    _iapService.initialize();
    _iapService.isProNotifier.addListener(_updateAdVisibility);
    _loadAd();
  }

  void _loadAd() {
    if (!_iapService.isPro) {
      BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              _bannerAd = ad as BannerAd;
            });
          },
          onAdFailedToLoad: (ad, err) {
            debugPrint('Failed to load a banner ad: ${err.message}');
            ad.dispose();
          },
        ),
      ).load();
    }
  }

  void _updateAdVisibility() {
    setState(() {
      if (_iapService.isPro) {
        _bannerAd?.dispose();
        _bannerAd = null;
      } else {
        _loadAd();
      }
    });
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
    _inputController.dispose();
    _bannerAd?.dispose();
    _iapService.isProNotifier.removeListener(_updateAdVisibility);
    _iapService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final dropdownProvider = Provider.of<SelectionProvider>(context);

    final screenSize = MediaQuery.of(context).size;
    final buttonLabels =
    languageProvider.isEnglish ? buttonLabelsEnglish : buttonLabelsBangla;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          languageProvider.isEnglish
              ? 'Bangla Unit Currency Converter'
              : 'বাংলা একক মুদ্রা রূপান্তরকারী',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 2,
        shadowColor: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                inputValue = '';
                outputValue = '';
                _inputController.clear();
                dropdownProvider.resetCurrentCategory();
              });
            },
            tooltip: languageProvider.isEnglish ? 'Reset' : 'রিসেট',
          ),
        ],
      ),
      drawer: MyDrawer(iapService: _iapService,),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final padding = constraints.maxWidth * 0.05;
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: padding),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    itemCount: buttonLabelsEnglish.length,
                    itemBuilder: (context, index) {
                      final isSelected = dropdownProvider.selectedIndex == index;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: GestureDetector(
                          onTap: () {
                            dropdownProvider.selectIndex(index);
                            setState(() {
                              inputValue = '';
                              outputValue = '';
                              _inputController.clear();
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            width: 65,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.secondaryContainer
                                  : Theme.of(context).colorScheme.surfaceContainer,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  buttonIcons[index],
                                  height: 40,
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.onSurface,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  buttonLabels[index],
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.onPrimary
                                        : Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: padding),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: _inputController,
                          decoration: InputDecoration(
                            labelText: languageProvider.isEnglish ? 'Input' : 'ইনপুট',
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                          ),
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          style: Theme.of(context).textTheme.bodyLarge,
                          onChanged: (value) {
                            setState(() {
                              inputValue = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: DropdownButtonFormField<String>(
                          value: dropdownProvider.firstSelectedValue,
                          hint: Text(
                            languageProvider.isEnglish ? 'Select Option' : 'বিকল্প নির্বাচন করুন',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          isExpanded: true,
                          items: dropdownOptions[dropdownProvider.selectedIndex]!
                              .toSet()
                              .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e, style: Theme.of(context).textTheme.bodyLarge),
                          ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              dropdownProvider.selectFirstValue(value);
                            }
                          },
                          style: Theme.of(context).textTheme.bodyLarge,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: padding),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: languageProvider.isEnglish ? 'Output' : 'আউটপুট',
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                          ),
                          controller: TextEditingController(text: outputValue),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: DropdownButtonFormField<String>(
                          value: dropdownProvider.secondSelectedValue,
                          hint: Text(
                            languageProvider.isEnglish ? 'Select Option' : 'বিকল্প নির্বাচন করুন',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          isExpanded: true,
                          items: dropdownOptions[dropdownProvider.selectedIndex]!
                              .toSet()
                              .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e, style: Theme.of(context).textTheme.bodyLarge),
                          ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              dropdownProvider.selectSecondValue(value);
                            }
                          },
                          style: Theme.of(context).textTheme.bodyLarge,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: padding * 4),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: padding, vertical: 8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: (constraints.maxWidth / 4 - 8) / (constraints.maxHeight / 10),
                  ),
                  itemCount: Button.buttonValues.length,
                  itemBuilder: (context, index) {
                    final value = Button.buttonValues[index];
                    return AnimatedScaleButton(value: value, onTap: _onButtonTap);
                  },
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _iapService.isProNotifier,
                  builder: (context, isPro, child) {
                    return AnimatedOpacity(
                      opacity: isPro || _bannerAd == null ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      child: Card(
                        elevation: 2,
                        margin: EdgeInsets.all(padding),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: isPro
                            ? const SizedBox.shrink()
                            : _bannerAd != null
                            ? AdLoader(bannerAd: _bannerAd!)
                            : const SizedBox.shrink(),
                      ),
                    );
                  },
                ),
                SizedBox(height: padding),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onButtonTap(String value) {
    setState(() {
      if (value == Button.del) {
        inputValue = inputValue.isNotEmpty ? inputValue.substring(0, inputValue.length - 1) : '';
        _inputController.text = inputValue;
      } else if (value == Button.clear) {
        inputValue = '';
        _inputController.text = '';
      } else if (value == Button.ok) {
        performConversion();
      } else {
        inputValue += value;
        _inputController.text = inputValue;
      }
    });
  }
}

class AnimatedScaleButton extends StatefulWidget {
  final String value;
  final void Function(String) onTap;

  const AnimatedScaleButton({super.key, required this.value, required this.onTap});

  @override
  State<AnimatedScaleButton> createState() => _AnimatedScaleButtonState();
}

class _AnimatedScaleButtonState extends State<AnimatedScaleButton> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails _) {
    setState(() => _scale = 0.95);
  }

  void _onTapUp(TapUpDetails _) {
    setState(() => _scale = 1.0);
    widget.onTap(widget.value);
  }

  Color getButtonColor(String value) {
    return [Button.del, Button.clear].contains(value)
        ? Colors.red
        : [Button.ok].contains(value)
        ? Colors.green
        : [Button.dot].contains(value)
        ? Colors.blue
        : Theme.of(context).colorScheme.secondaryContainer;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => setState(() => _scale = 1.0),
      child: Transform.scale(
        scale: _scale,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: getButtonColor(widget.value),
          child: Center(
            child: Text(
              widget.value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: [Button.del, Button.clear, Button.ok, Button.dot].contains(widget.value)
                    ? Colors.white
                    : Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
