import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openai_app/bloc/openai/openai_bloc.dart';
import 'package:openai_app/bloc/openai/openai_state.dart';
import 'package:openai_app/components/error/notfound_token.dart';
import 'package:openai_app/components/setting/setting_card.dart';
import 'package:openai_app/constants/extension/size_box_extension.dart';
import 'package:openai_app/constants/theme/colors.dart';
import 'package:openai_app/constants/theme/dimen.dart';
import 'package:openai_app/models/feature/feature_data.dart';
import 'package:openai_app/screen/chatbot/chatbot.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void toChatBotScreen(BuildContext context, FeatureData data) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChatBotScreen(data: data)));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
          appBar: buildAppBar(context, size),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: size.height * .9,
                  child: Material(
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          ///list features
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            child: Column(
                              children: [
                                size.height.toHeight(height: .04),
                                SizedBox(
                                  height: size.height * .5,
                                  child: ListView.builder(
                                    itemCount: openAIFeatures.length,
                                    itemBuilder: (context, index) {
                                      return buildFutureCard(index, context);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),

                          ///open sheet
                          BlocBuilder<OpenAIBloc, OpenAIState>(
                            bloc: BlocProvider.of<OpenAIBloc>(context,
                                listen: false),
                            builder: (context, state) {
                              if (state is OpenSettingState) {
                                return state.isOpen
                                    ? Align(
                                        alignment: Alignment.bottomCenter,
                                        child: SettingCard(
                                            height: size.height * .5,
                                            tab: () {
                                              final bloc =
                                                  BlocProvider.of<OpenAIBloc>(
                                                      context,
                                                      listen: false);
                                              bloc.saveToken(
                                                  success: () {
                                                    bloc.openSettingSheet(
                                                        !state.isOpen);
                                                  },
                                                  error: () =>
                                                      errorNotFoundToken(
                                                          context));
                                            }),
                                      )
                                    : const SizedBox();
                              }
                              return const SizedBox();
                            },
                          ),
                        ],
                      )),
                ),
              )
            ],
          )),
    );
  }

  Padding buildFutureCard(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2.5),
      child: Ink(
        decoration: BoxDecoration(
            color: kDarkBgColor,
            borderRadius: BorderRadius.circular(kDefaultPadding / 2),
            border: Border.all(color: Colors.white10)),
        child: InkWell(
          onTap: () async {
            final bloc = BlocProvider.of<OpenAIBloc>(context, listen: false);
            bloc.isHasToken(
                success: () => toChatBotScreen(context, openAIFeatures[index]),
                error: () {
                  errorNotFoundToken(context);
                  bool openSheet = false;
                  if (bloc.state is OpenSettingState) {
                    openSheet = (bloc.state as OpenSettingState).isOpen;
                  }
                  bloc.openSettingSheet(!openSheet);
                });
          },
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 50,
                    height: 40,
                    margin: const EdgeInsets.only(left: kDefaultPadding / 2),
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 2.5),
                    decoration: BoxDecoration(
                        color: openAIFeatures[index].bgColor.withOpacity(.12),
                        borderRadius:
                            BorderRadius.circular(kDefaultPadding / 2)),
                    child: Image.asset(
                      openAIFeatures[index].image,
                      color: openAIFeatures[index].imageColor,
                    ) //const Icon(Icons.question_answer,color: Colors.indigo),
                    ),
                kDefaultPadding.toWidth(),
                Expanded(
                    child: Text(openAIFeatures[index].title,
                        style: Theme.of(context).textTheme.titleMedium)),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_right_alt_sharp,
                      color: openAIFeatures[index].imageColor,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, Size size) {
    return AppBar(
      backgroundColor: kDarkBgColor,
      title: Text(
        "OpenAI Demo App",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displaySmall,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: kDefaultPadding),
          child: Ink(
            width: size.width * .11,
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
              child: const Icon(Icons.settings,
                  color: kButtonColor, size: kDefaultPadding * 1.2),
            ),
          ),
        )
      ],
    );
  }
}
