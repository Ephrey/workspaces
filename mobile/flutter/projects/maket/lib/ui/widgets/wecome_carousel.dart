import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/welcome_text.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class WelcomeCarousel extends StatefulWidget {
  @override
  _WelcomeCarouselState createState() => _WelcomeCarouselState();
}

class _WelcomeCarouselState extends State<WelcomeCarousel> {
  int currentSlideIndex = 0;

  void _updateCurrentSlide(index, _) {
    setState(() {
      currentSlideIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    CarouselOptions _carouselOption = CarouselOptions(
      viewportFraction: 1.0,
      onPageChanged: _updateCurrentSlide,
      autoPlay: true,
      height: Math.percentage(
        percent: Numbers.thirty,
        total: ScreenSize(context: context).height,
      ),
    );

    return Column(
      children: [
        CarouselSlider(
          options: _carouselOption,
          items: welcomeTexts
              .map((text) => _CarouselContent(content: text))
              .toList(),
        ),
        _CarouselIndicator(currentIndicator: currentSlideIndex),
      ],
    );
  }
}

class _CarouselContent extends StatelessWidget {
  final Map<String, String> content;

  _CarouselContent({this.content}) : assert(content != null);

  @override
  Widget build(BuildContext context) {
    TextStyle _titleStyle = TextStyle(
      color: kPrimaryColor,
      fontSize: Math.percentage(
        percent: Numbers.four,
        total: ScreenSize(context: context).height,
      ),
      fontWeight: FontWeight.w800,
    );

    TextStyle _subtitleStyle = TextStyle(
      color: kPrimaryColor,
      fontSize: Math.percentage(
        percent: Numbers.four,
        total: ScreenSize(context: context).width,
      ),
      fontWeight: FontWeight.w600,
      height: 1.7,
    );

    return Column(
      children: [
        Text('${content['title']}',
            textAlign: TextAlign.center, style: _titleStyle),
        Separator(),
        SizedBox(
          width: Math.percentage(
            percent: Numbers.sixty,
            total: ScreenSize(context: context).width,
          ),
          child: Text('${content['subtitle']}',
              textAlign: TextAlign.center, style: _subtitleStyle),
        ),
      ],
    );
  }
}

class _CarouselIndicator extends StatelessWidget {
  final int currentIndicator;

  _CarouselIndicator({
    @required this.currentIndicator,
  }) : assert(currentIndicator != null);

  @override
  Widget build(BuildContext context) {
    List<_CarouselIndicatorDot> _dots = [];
    for (int i = 0; i < welcomeTexts.length; i++) {
      (currentIndicator == i)
          ? _dots.add(_CarouselIndicatorDot(
              color: kPrimaryColor,
              width: 19.0,
            ))
          : _dots.add(_CarouselIndicatorDot());
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _dots,
    );
  }
}

class _CarouselIndicatorDot extends StatelessWidget {
  final Color color;
  final double width;

  _CarouselIndicatorDot({
    this.color: kTextSecondaryColor,
    this.width: 9.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: width,
        height: 9.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
    );
  }
}
