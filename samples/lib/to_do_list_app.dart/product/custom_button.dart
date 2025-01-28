import 'package:flutter/material.dart';
import 'package:samples/to_do_list_app.dart/constants/color.dart';
import 'package:samples/to_do_list_app.dart/screen/add_tast.dart';
import 'package:samples/to_do_list_app.dart/screen/navigator_manager.dart';

class CustomButton extends StatelessWidget with NavigatorManager{
  const CustomButton({super.key, this.onpressed, required this.text});
  final void Function()? onpressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    final boyut = MediaQuery.of(context).size;
    return Container(
                  width: boyut.width,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(purpleColor),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0), // Yatay ve dikey boşluk
                        ),
                      ),
                      onPressed: onpressed,
                      child: _TextWidget(
                          icerik: text, textColor: textColor)));
  }
}

class _TextWidget extends StatelessWidget {
  const _TextWidget({
    super.key,
    required this.icerik,
    required this.textColor,
  });
  final String icerik;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Text(
      icerik,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: textColor, fontSize: 18),
    );
  }
}