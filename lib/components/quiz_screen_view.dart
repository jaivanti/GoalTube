// ignore_for_file: prefer_const_constructors, deprecated_member_use, sized_box_for_whitespace

import 'package:goaltube/components/theme.dart';
import 'package:goaltube/models/quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'answer_card_widget.dart';

class QuizScreenView extends StatefulWidget {
  const QuizScreenView({Key? key}) : super(key: key);

  @override
  _QuizScreenViewState createState() => _QuizScreenViewState();
}

class _QuizScreenViewState extends State<QuizScreenView> {
  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            FlatButton(
                onPressed: () {
                  _questionController.nextQuestion();
                },
                child: Text("Skip"))
          ],
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: GetBuilder<QuestionController>(
                        init: Get.find<QuestionController>(),
                        builder: (con) {
                          return Text.rich(
                            TextSpan(
                              text: "Question  ${con.questionNumber.value}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: kSecondaryColor),
                              children: [
                                TextSpan(
                                  text: '/${con.questions.length}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(color: kSecondaryColor),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Divider(thickness: 1.5),
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Expanded(
                      child: PageView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        onPageChanged: _questionController.updateQnumber,
                        controller: _questionController.pageController,
                        itemCount: _questionController.questions.length,
                        itemBuilder: (context, index) => QA(
                          question: _questionController.questions[index],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
