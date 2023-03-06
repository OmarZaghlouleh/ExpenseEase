import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:budgeting_app/core/functions/media_query.dart';
import 'package:animate_do/animate_do.dart';
import 'package:budgeting_app/core/utils/durations/animation_duration.dart';
import 'package:budgeting_app/core/utils/routes/routes_manager.dart';
import 'package:budgeting_app/core/utils/sizes/media_query_sizes.dart';
import 'package:budgeting_app/core/utils/assets/assets_path.dart';
import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/sizes/opacity.dart';
import 'package:budgeting_app/core/utils/sizes/padding.dart';
import 'package:budgeting_app/core/utils/sizes/space_sizes.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/core/utils/values/app_values.dart';
import 'package:budgeting_app/core/widgets/nothing_widget.dart';
import 'package:budgeting_app/plans/presentation/controller/intro_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController =
      PageController(initialPage: AppValues.v0);

  // late AnimationController _animationController;
  // late Animation<double> _animation;

  @override
  void initState() {
    // _animationController = AnimationController(
    //     vsync: this, duration: Duration(milliseconds: AnimationDuration.d500))
    //   ..repeat();
    // _animation = Tween<double>(begin: 0, end: 100).animate(_animationController)
    //   ..addListener(() {
    //     setState(() {});
    //   });

    Provider.of<IntroProvider>(context, listen: false).reset();
    _pageController.addListener(() {
      if (_pageController.page != null && _pageController.page! % 1 == 0) {
        Provider.of<IntroProvider>(context, listen: false).setCurrentPage(
            _pageController.page == null ? 0 : _pageController.page!.toInt());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero).then((_) {});
    _pageController.removeListener(() {});
    // _animation.removeListener(() {});
    // _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<IntroProvider>(
            builder: (context, value, child) => AnimatedOpacity(
              opacity: value.getAppbarTitleVisibilty ? 1 : 0,
              duration: Duration(milliseconds: AnimationDuration.d1000),
              child: Text(
                AppStrings.appName,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
        ),
        body: GestureDetector(
          onVerticalDragStart: (dr) {
            Navigator.pushReplacementNamed(context, Routes.createPlanScreen);
          },
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: getMediaQueryInstance(context: context).size.height *
                      MediaQuerySizes.mq5,
                  width: double.infinity,
                  child: PageView(
                    controller: _pageController,
                    children: [
                      _getIntroBody(
                          imagePath: ImageAssets.intro1Image,
                          texts: [
                            TypewriterAnimatedText(
                              AppStrings.withCapitalText,
                            ),
                            TypewriterAnimatedText(
                              AppStrings.appName,
                              textStyle:
                                  Theme.of(context).textTheme.displayMedium,
                            ),
                            TypewriterAnimatedText(
                              AppStrings.intro1,
                            ),
                          ],
                          context: context),
                      _getIntroBody(
                          imagePath: ImageAssets.intro2Image,
                          texts: [
                            TypewriterAnimatedText(
                              AppStrings.intro2,
                            ),
                          ],
                          context: context),
                      _getIntroBody(
                          imagePath: ImageAssets.intro3Image,
                          texts: [
                            TypewriterAnimatedText(
                              AppStrings.intro3,
                            ),
                          ],
                          context: context),
                      _getIntroBody(
                          imagePath: ImageAssets.intro4Image,
                          texts: [
                            TypewriterAnimatedText(
                              AppStrings.intro4,
                            ),
                          ],
                          context: context),
                    ],
                  ),
                ),
              ),
              Consumer<IntroProvider>(
                builder: (context, value, child) =>
                    value.getCurrentPage == 3 || value.getLastPage == 3
                        ? JelloIn(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.createPlanScreen);
                                },
                                child: const Text(
                                  AppStrings.gettingStarted,
                                )),
                          )
                        : emptyWidget(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.spaceSize5,
                      ),
                      child: Consumer<IntroProvider>(
                        builder: (context, value, child) {
                          return AnimatedContainer(
                            duration:
                                Duration(milliseconds: AnimationDuration.d200),
                            width: value.getCurrentPage == index
                                ? AppSizes.spaceSize25
                                : AppSizes.spaceSize10,
                            height: AppSizes.spaceSize5,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.circular(AppSizes.spaceSize10),
                              color: value.getCurrentPage == index
                                  ? AppLightColors.primaryLightColor
                                  : AppLightColors.accentColor,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Consumer<IntroProvider>(
                builder: (context, value, child) => AnimatedOpacity(
                  duration: Duration(milliseconds: AnimationDuration.d300),
                  opacity: value.getLastPage == 3 ? 0 : 1,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: AppPaddings.p15),
                    child: Column(
                      children: [
                        LottieBuilder.asset(
                          LottieAssets.swipeUp,
                          width: AppSizes.spaceSize60,
                          height: AppSizes.spaceSize60,
                          frameRate: FrameRate.max,
                        ),
                        Text(
                          AppStrings.swipeUpToSkip,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: AppLightColors.primaryLightColor
                                      .withOpacity(AppOpacity.op07)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getIntroBody(
      {required String imagePath,
      required List<AnimatedText> texts,
      required BuildContext context}) {
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
