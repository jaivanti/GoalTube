// ignore_for_file: prefer_const_constructors

import 'package:goaltube/models/quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'theme.dart';

class Options extends StatelessWidget {
  const Options(
      {Key? key,
      required this.index,
      required this.text,
      required this.onpressed})
      : super(key: key);
  final int index;
  final String text;
  final VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
      init: QuestionController(),
      builder: (controllerQ) {
        Color getTheRightColor() {
          if (controllerQ.isAnswered) {
            if (index == controllerQ.correctAns) {
              return kGreenColor;
            } else if (index == controllerQ.SelectAns &&
                controllerQ.SelectAns != controllerQ.correctAns) {
              return kRedColor;
            }
          }

          return kGrayColor;
        }

        IconData getTheRightIcon() {
          return getTheRightColor() == kRedColor ? Icons.close : Icons.done;
        }

        return InkWell(
          onTap: onpressed,
          child: Container(
            margin: EdgeInsets.only(top: kDefaultPadding),
            padding: EdgeInsetsDirectional.all(kDefaultPadding),
            decoration: BoxDecoration(
              border: Border.all(
                color: getTheRightColor(),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${index + 1} $text",
                  style: TextStyle(
                    fontSize: 16,
                    color: getTheRightColor(),
                  ),
                ),
                Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    color: getTheRightColor() == kGrayColor
                        ? Colors.transparent
                        : getTheRightColor(),
                    border: Border.all(
                      color: getTheRightColor(),
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  // child: Icon(Icons.done),
                  child: getTheRightColor() != kGrayColor
                      ? Icon(getTheRightIcon())
                      : null,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
