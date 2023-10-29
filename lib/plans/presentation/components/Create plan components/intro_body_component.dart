import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:budgeting_app/core/functions/media_query.dart';
import 'package:budgeting_app/core/utils/sizes/app_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/media_query_sizes.dart';
import 'package:budgeting_app/plans/presentation/controller/intro_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntroBodyComponent extends StatelessWidget {
  const IntroBodyComponent(
      {super.key,
      required this.imagePath,
      required this.texts,
      required this.context});
  final String imagePath;
  final List<AnimatedText> texts;
  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: getMediaQueryInstance(context: context).size.height *
                  MediaQuerySizes.mq05,
              left: getMediaQueryInstance(context: context).size.width *
                  MediaQuerySizes.mq03,
            ),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (texts.length > 1)
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            DefaultTextStyle(
                              style: Theme.of(context).textTheme.displaySmall!,
                              child: AnimatedTextKit(
                                onFinished: () {
                                  Provider.of<IntroProvider>(context,
                                          listen: false)
                                      .setAppbarTitleVisiblity(false);
                                },
                                isRepeatingAnimation: false,
                                animatedTexts: [texts.first],
                              ),
                            ),
                            DefaultTextStyle(
                              style: Theme.of(context).textTheme.displaySmall!,
                              child: AnimatedTextKit(
                                onFinished: () {
                                  Provider.of<IntroProvider>(context,
                                          listen: false)
                                      .setAppbarTitleVisiblity(false);
                                },
                                isRepeatingAnimation: false,
                                animatedTexts: [texts[1]],
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: AppSizes.spaceSize10),
                    Expanded(
                      child: DefaultTextStyle(
                        style: Theme.of(context).textTheme.displaySmall!,
                        child: AnimatedTextKit(
                          onFinished: () {
                            if (texts.length == 1) {
                              Provider.of<IntroProvider>(context, listen: false)
                                  .setAppbarTitleVisiblity(true);
                            } else {
                              Provider.of<IntroProvider>(context, listen: false)
                                  .setAppbarTitleVisiblity(false);
                            }
                          },
                          isRepeatingAnimation: false,
                          animatedTexts: [texts.last],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
        Expanded(
          flex: 2,
          child: Image(
            filterQuality: FilterQuality.high,
            fit: BoxFit.fitWidth,
            image: AssetImage(imagePath),
          ),
        ),
      ],
    );
  }
}
