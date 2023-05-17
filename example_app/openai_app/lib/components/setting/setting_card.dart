import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:openai_app/constants/extension/size_box_extension.dart';
import 'package:openai_app/constants/theme/colors.dart';
import 'package:openai_app/constants/theme/dimen.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        height: MediaQuery.of(context).size.height * .8,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(kDefaultPadding * 1.3),
                topLeft: Radius.circular(kDefaultPadding * 1.3)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12.withOpacity(.1),
                  offset: const Offset(0, 5),
                  blurRadius: 30.0)
            ]),
        child: Column(
          children: [
            Lottie.asset('assets/animation/robot_setting_animation.json',
                width: 200, height: 200, fit: BoxFit.fill),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Text(
                "Setting OpenAI",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: kDefaultPadding * 1.5),
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding / 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(kDefaultPadding),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12.withOpacity(.12),
                        offset: const Offset(0, 3),
                        blurRadius: 27.0)
                  ]),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Access Token",
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            Row(
              children: [
                CupertinoCheckbox(value: true, onChanged: (it) {}),
                Text("ChatGPT 3.5",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.black)),
                CupertinoCheckbox(value: false, onChanged: (it) {}),
                Text("ChatGPT 4",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.black)),
              ],
            ),
            MediaQuery.of(context).size.height.toHeight(height: .1),
            SizedBox(
              width: MediaQuery.of(context).size.width * .5,
              height: kDefaultPadding * 3,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: kDefaultPadding / 1.6,
                    shadowColor: Colors.indigoAccent.withOpacity(.3),
                    backgroundColor: kButtonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kDefaultPadding))),
                onPressed: () {},
                child: Text("Save",
                    style: Theme.of(context).textTheme.titleMedium),
              ),
            ),
          ],
        ));
  }
}
