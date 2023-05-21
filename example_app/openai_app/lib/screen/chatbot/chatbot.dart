import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lottie/lottie.dart';
import 'package:openai_app/bloc/openai/openai_bloc.dart';
import 'package:openai_app/bloc/openai/openai_state.dart';
import 'package:openai_app/components/button/openai_button.dart';
import 'package:openai_app/components/setting/setting_card.dart';
import 'package:openai_app/constants/extension/size_box_extension.dart';
import 'package:openai_app/constants/theme/colors.dart';
import 'package:openai_app/constants/theme/dimen.dart';
import 'package:openai_app/constants/theme/theme.dart';
import 'package:openai_app/models/feature/feature_data.dart';

import '../../components/error/notfound_token.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({Key? key, required this.data}) : super(key: key);

  final FeatureData data;
  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  Future<bool> clearMessages() {
    BlocProvider.of<OpenAIBloc>(context, listen: false).clearMessage();
    return Future.value(true);
  }

  ///setup openai sdk
  void initOpenAISDK() {
    Future.delayed(const Duration(milliseconds: 200), () {
      BlocProvider.of<OpenAIBloc>(context, listen: false).initOpenAISdk();
    });
  }

  @override
  void initState() {
    initOpenAISDK();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: clearMessages,
        child: Scaffold(
          appBar: buildAppBar(size, context),
          body: Material(
            color: Colors.transparent,
            child: CustomScrollView(
              reverse: true,
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: size.height * .9,
                    child: Stack(
                      children: [
                        buildMsgList(context, size),

                        ///input
                        buildTextInput(),

                        ///setting bottom sheet
                        buildSettingSheet(context, size),

                        ///open sheet errors
                        buildErrorSheet(context, size),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  BlocBuilder<OpenAIBloc, OpenAIState> buildMsgList(
      BuildContext context, Size size) {
    return BlocBuilder<OpenAIBloc, OpenAIState>(
      bloc: BlocProvider.of<OpenAIBloc>(context, listen: false),
      builder: (context, state) {
        if (state is ChatCompletionState) {
          return SizedBox(
            height: size.height * .8,
            child: ListView.builder(
              itemCount: BlocProvider.of<OpenAIBloc>(context, listen: false)
                  .list
                  .length,
              itemBuilder: (context, index) {
                return state.messages?[index].isBot == true
                    ? buildBotCard(context, state.messages?[index].message)
                    : buildUserCard(context, state.messages?[index].message);
              },
            ),
          );
        }
        return buildBotCard(context, null);
      },
    );
  }

  BlocBuilder<OpenAIBloc, OpenAIState> buildSettingSheet(
      BuildContext context, Size size) {
    return BlocBuilder<OpenAIBloc, OpenAIState>(
      bloc: BlocProvider.of<OpenAIBloc>(context, listen: false),
      builder: (context, state) {
        if (state is OpenSettingState) {
          return state.isOpen
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: SettingCard(
                      height: size.height * .5,
                      tab: () {
                        final bloc =
                            BlocProvider.of<OpenAIBloc>(context, listen: false);
                        bloc.onSetToken(
                            success: () {
                              bloc.openSettingSheet(!state.isOpen);
                            },
                            error: () => errorNotFoundToken(context));
                      }),
                )
              : const SizedBox();
        }
        return const SizedBox();
      },
    );
  }

  BlocBuilder<OpenAIBloc, OpenAIState> buildErrorSheet(
      BuildContext context, Size size) {
    return BlocBuilder<OpenAIBloc, OpenAIState>(
      bloc: BlocProvider.of<OpenAIBloc>(context, listen: false),
      builder: (context, state) {
        if (state is AuthErrorState) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: ErrorCard(
              height: size.height * .5,
              animation: 'assets/animation/error_animation.json',
              title: 'Authentication error',
              error: "Please setup your new access token",
            ),
          );
        }
        if (state is RateLimitErrorState) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: ErrorCard(
              height: size.height * .5,
              animation: 'assets/animation/error_animation.json',
              title: 'Rate limit error',
              error:
                  "You are sending requests too quickly or\nYou have hit your maximum monthly spend",
            ),
          );
        }

        if (state is OpenAIServerErrorState) {
          Align(
            alignment: Alignment.bottomCenter,
            child: ErrorCard(
              height: size.height * .5,
              animation: 'assets/animation/error_animation.json',
              title: 'Server error',
              error: "Issue on our servers.",
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Padding buildUserCard(BuildContext context, String? message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ///content card
          Flexible(
              child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 1.5,
                      vertical: kDefaultPadding / 1.2),
                  decoration: BoxDecoration(
                      color: kDarkOffBgColor,
                      borderRadius: BorderRadius.circular(kDefaultPadding / 2),
                      border: Border.all(color: Colors.white10)),
                  child: Text(
                    message ?? 'User Message.',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                        ),
                  ))),

          ///user icon
          Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              padding: const EdgeInsets.all(kDefaultPadding / 1.5),
              decoration: BoxDecoration(
                  color: kButtonColor.withOpacity(.32),
                  borderRadius: BorderRadius.circular(kDefaultPadding / 3),
                  boxShadow: [
                    BoxShadow(
                        color: kButtonColor.withOpacity(.1),
                        offset: const Offset(0, 3),
                        blurRadius: 6.0)
                  ]),
              child: Image.asset(
                'assets/icons/user_icon.png',
                color: Colors.blueAccent,
                cacheWidth: 100,
                cacheHeight: 100,
                width: kDefaultPadding * 1.2,
                height: kDefaultPadding * 1.2,
              )),
        ],
      ),
    );
  }

  Padding buildBotCard(BuildContext context, String? message) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///bot icon
          Container(
              margin: const EdgeInsets.only(right: kDefaultPadding / 2),
              padding: const EdgeInsets.all(kDefaultPadding / 1.5),
              decoration: BoxDecoration(
                  color: kButtonColor.withOpacity(.32),
                  borderRadius: BorderRadius.circular(kDefaultPadding / 3),
                  boxShadow: [
                    BoxShadow(
                        color: kButtonColor.withOpacity(.1),
                        offset: const Offset(0, 3),
                        blurRadius: 6.0)
                  ]),
              child: Image.asset(
                'assets/icons/openai_icon.png',
                color: Colors.blueAccent,
                cacheWidth: 32,
                cacheHeight: 32,
                width: kDefaultPadding,
                height: kDefaultPadding,
              )),

          ///content card
          Flexible(
              child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 1.5,
                vertical: kDefaultPadding / 1.2),
            decoration: BoxDecoration(
                color: kDarkOffBgColor,
                borderRadius: BorderRadius.circular(kDefaultPadding / 2),
                border: Border.all(color: Colors.white10)),
            child: MarkdownBody(
              data: message ?? "What Help ?",
              selectable: true,
              onTapText: () {},
              styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
              styleSheet: MarkdownStyleSheet(
                  codeblockDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: kDarkBgColor,
                  ),
                  code: theme.textTheme.titleSmall?.copyWith(
                      color: Colors.blue, backgroundColor: Colors.transparent),
                  p: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.white)),
            ),
            // Text(
            //   message ?? 'OpenAI Answer',
            //   style: Theme.of(context).textTheme.titleSmall?.copyWith(
            //         color: Colors.white,
            //       ),
            // )
          ))
        ],
      ),
    );
  }

  Align buildTextInput() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            margin: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            width: double.infinity,
            height: kDefaultPadding * 2.5,
            decoration: BoxDecoration(
                color: kDarkOffBgColor,
                borderRadius: BorderRadius.circular(kDefaultPadding / 2),
                border: Border.all(color: Colors.white10)),
            child: TextField(
                controller: BlocProvider.of<OpenAIBloc>(context, listen: false)
                    .getTextInput(),
                onSubmitted: (it) {
                  BlocProvider.of<OpenAIBloc>(context, listen: false)
                      .sendWithPrompt(false);
                },
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.white),
                decoration: InputDecoration(
                    suffixIcon: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: kDefaultPadding / 4),
                        decoration: BoxDecoration(
                            color: kButtonColor.withOpacity(.32),
                            borderRadius:
                                BorderRadius.circular(kDefaultPadding / 2),
                            boxShadow: [
                              BoxShadow(
                                  color: kButtonColor.withOpacity(.1),
                                  offset: const Offset(0, 3),
                                  blurRadius: 6.0)
                            ]),
                        child: IconButton(
                          onPressed: () {
                            BlocProvider.of<OpenAIBloc>(context, listen: false)
                                .sendWithPrompt(false);
                          },
                          color: kButtonColor,
                          icon: Transform.rotate(
                              angle: -pi / 4,
                              child: const Icon(Icons.send_outlined,
                                  color: kButtonColor, size: kDefaultPadding)),
                        )),
                    hintText: '.... ?',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.white),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none))));
  }

  AppBar buildAppBar(Size size, BuildContext context) {
    return AppBar(
      backgroundColor: kDarkBgColor,
      leading: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 1.5),
        child: Ink(
          width: size.width * .08,
          height: size.height * .044,
          decoration: BoxDecoration(
              color: kButtonColor.withOpacity(.32),
              borderRadius: BorderRadius.circular(kDefaultPadding / 2),
              boxShadow: [
                BoxShadow(
                    color: kButtonColor.withOpacity(.1),
                    offset: const Offset(0, 3),
                    blurRadius: 6.0)
              ]),
          child: InkWell(
            onTap: () {
              BlocProvider.of<OpenAIBloc>(context, listen: false)
                  .clearMessage();
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new,
                color: kButtonColor, size: kDefaultPadding * 1.2),
          ),
        ),
      ),
      title: Text(widget.data.title,
          style: Theme.of(context).textTheme.titleMedium),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 1.5),
          child: Ink(
            width: size.width * .09,
            height: size.height * .044,
            decoration: BoxDecoration(
                color: kButtonColor.withOpacity(.32),
                borderRadius: BorderRadius.circular(kDefaultPadding / 2),
                boxShadow: [
                  BoxShadow(
                      color: kButtonColor.withOpacity(.1),
                      offset: const Offset(0, 3),
                      blurRadius: 6.0)
                ]),
            child: InkWell(
              onTap: () {
                final bloc =
                    BlocProvider.of<OpenAIBloc>(context, listen: false);
                bool openSheet = false;
                if (bloc.state is OpenSettingState) {
                  openSheet = (bloc.state as OpenSettingState).isOpen;
                }
                bloc.openSettingSheet(!openSheet);
              },
              child: const Icon(Icons.more_horiz_outlined,
                  color: kButtonColor, size: kDefaultPadding * 1.2),
            ),
          ),
        ),
      ],
    );
  }
}

class ErrorCard extends StatelessWidget {
  const ErrorCard(
      {Key? key,
      required this.height,
      required this.animation,
      required this.title,
      required this.error})
      : super(key: key);

  final double height;
  final String animation;
  final String title;
  final String error;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        height: height,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: kDarkOffBgColor,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(kDefaultPadding * 2),
                topLeft: Radius.circular(kDefaultPadding * 2)),
            boxShadow: [
              BoxShadow(
                  color: kDarkOffBgColor.withOpacity(.4),
                  offset: const Offset(8, 0),
                  blurRadius: 27.0)
            ]),
        child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                MediaQuery.of(context).size.height.toHeight(height: .06),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                kDefaultPadding.toHeight(height: .1),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Text(
                    error,
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                kDefaultPadding.toHeight(),
                Lottie.asset(
                  animation,
                  width: 150,
                  height: 150,
                ),
                kDefaultPadding.toHeight(height: 2),
                OpenAIButton(
                  width: MediaQuery.of(context).size.width * .56,
                  height: kDefaultPadding * 2.8,
                  title: 'Close',
                  boxShadow: [
                    BoxShadow(
                        color: kButtonColor.withOpacity(.23),
                        offset: const Offset(0.0, 6),
                        blurRadius: 5.0)
                  ],
                  tab: () => BlocProvider.of<OpenAIBloc>(context, listen: false)
                      .closeOpenAIError(),
                ),
              ],
            )));
  }
}
