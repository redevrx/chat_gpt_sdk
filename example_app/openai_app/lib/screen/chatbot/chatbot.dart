import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:openai_app/bloc/openai/openai_bloc.dart';
import 'package:openai_app/bloc/openai/openai_state.dart';
import 'package:openai_app/components/button/openai_button.dart';
import 'package:openai_app/components/dialog/loading_dialog.dart';
import 'package:openai_app/components/error/error_card.dart';
import 'package:openai_app/components/setting/setting_card.dart';
import 'package:openai_app/constants/constants.dart';
import 'package:openai_app/constants/theme/colors.dart';
import 'package:openai_app/constants/theme/dimen.dart';
import 'package:openai_app/constants/theme/theme.dart';
import 'package:openai_app/models/feature/feature_data.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../components/error/notfound_token.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key, required this.data});

  final FeatureData data;
  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  void clearMessages(bool _) {
    BlocProvider.of<OpenAIBloc>(context, listen: false).clearMessage();
  }

  ///setup openai sdk
  void initOpenAISDK() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted) return;
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
    return PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, _) {
          clearMessages(didPop);
        },
        child: Scaffold(
          body: Material(
            color: Colors.transparent,
            child: CustomScrollView(
              reverse: true,
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: size.height,
                    child: Stack(
                      children: [
                        ///messages card
                        buildMsgCard(size, context),

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

  Column buildMsgCard(Size size, BuildContext context) {
    return Column(
      children: [
        buildAppBar(size, context),
        BlocBuilder<OpenAIBloc, OpenAIState>(
          bloc: BlocProvider.of<OpenAIBloc>(context, listen: false),
          builder: (context, state) {
            if (state is ChatCompletionState) {
              return Expanded(
                  flex: 12,
                  child: ListView.builder(
                    itemCount:
                        BlocProvider.of<OpenAIBloc>(context, listen: false)
                            .list
                            .length,
                    itemBuilder: (context, index) {
                      if (widget.data.type == FeatureType.kGenerateImage) {
                        return state.messages?[index].isBot == true
                            ? buildBotCardImage(
                                context, state.messages?[index].message)
                            : buildUserCard(
                                context, state.messages?[index].message);
                      }
                      return state.messages?[index].isBot == true
                          ? buildBotCard(
                              context, state.messages?[index].message)
                          : buildUserCard(
                              context, state.messages?[index].message);
                    },
                  ));
            }
            return buildBotCard(context, null);
          },
        ),
        const Spacer(
          flex: 1,
        )
      ],
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
                        bloc.saveToken(
                            success: () {
                              bloc.openSettingSheet(!state.isOpen);
                              bloc.initOpenAISdk();
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
          return Align(
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
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ///content card
          Flexible(
              child: Container(
                  margin: const EdgeInsets.only(right: kDefaultPadding / 2),
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

  Padding buildBotCardImage(BuildContext context, String? message) {
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
              child: ClipRRect(
            borderRadius: BorderRadius.circular(kDefaultPadding),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    message ?? kExampleImageNetwork,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: kDefaultPadding / 2,
                  right: kDefaultPadding,
                  child: InkWell(
                    onTap: () async {
                      if (message != "" && message != null) {
                        final bloc =
                            BlocProvider.of<OpenAIBloc>(context, listen: false);
                        await Permission.storage.request();
                        await Permission.photos.request();

                        ///show loading dialog
                        if (context.mounted) {
                          loadingDialog(context);
                        }

                        ///start download
                        bloc.downloadImage(message, success: () {
                          toast(context, message: "save image success");
                          Navigator.pop(context);
                        }, error: (err) {
                          toast(context, message: 'save image error :$err');
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kDefaultPadding / 2),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaY: 10.0, sigmaX: 10.0),
                        child: Container(
                          padding: const EdgeInsets.all(kDefaultPadding / 6),
                          color: Colors.transparent,
                          child: const Icon(
                            Icons.downloading,
                            color: kButtonColor,
                            size: kDefaultPadding,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  Align buildTextInput() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: BlocBuilder<OpenAIBloc, OpenAIState>(
          builder: (context, state) {
            if (state is ChatCompletionState) {
              return state.showStopButton
                  ? Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: kDefaultPadding),
                      child: OpenAIButton(
                        width: MediaQuery.of(context).size.width * .25,
                        height: kDefaultPadding * 2.8,
                        title: 'Stop',
                        boxShadow: [
                          BoxShadow(
                              color: kButtonColor.withOpacity(.23),
                              offset: const Offset(0.0, 6),
                              blurRadius: 5.0)
                        ],
                        tab: () {
                          BlocProvider.of<OpenAIBloc>(context, listen: false)
                              .onStopGenerate();
                        },
                      ),
                    )
                  : buildTextField(context);
            }
            return buildTextField(context);
          },
        ));
  }

  Container buildTextField(BuildContext context) {
    return Container(
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
              BlocProvider.of<OpenAIBloc>(context, listen: false).openAIEvent(
                  widget.data.type,
                  error: () => errorNotFoundPrompt(context));
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
                            .openAIEvent(widget.data.type,
                                error: () => errorNotFoundPrompt(context));
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
                focusedBorder: InputBorder.none)));
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
