import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samples/to_do_list_app.dart/constants/color.dart';
import 'package:samples/to_do_list_app.dart/constants/padding.dart';
import 'package:samples/to_do_list_app.dart/constants/project_string.dart';
import 'package:samples/to_do_list_app.dart/constants/taskType.dart';
import 'package:samples/to_do_list_app.dart/model/newTodoModel.dart';
import 'package:samples/to_do_list_app.dart/model/taskModel.dart';
import 'package:samples/to_do_list_app.dart/product/custom_button.dart';
import 'package:samples/to_do_list_app.dart/screen/add_tast.dart';
import 'package:samples/to_do_list_app.dart/screen/navigator_manager.dart';
import 'package:samples/to_do_list_app.dart/screen/todoItem.dart';
import 'package:samples/to_do_list_app.dart/services/todo_services.dart';

class Header extends StatefulWidget{
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> with NavigatorManager{
  @override
  Widget build(BuildContext context) {
    final boyut = MediaQuery.of(context).size;
    final String header = 'assets/header.png';

    return Scaffold(
      backgroundColor: backroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(header),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: boyut.width,
                    height: boyut.height / 3,
                    child: Column(
                      children: [
                        Padding(
                          padding: ProjectPadding.titleTopPadding,
                          child: TextWidget(
                            icerik: ProjectString.title,
                            textColor: textColor,
                          ),
                        ),
                        Padding(
                          padding: ProjectPadding.titleTop2xPadding,
                          child:
                              ProjectTextTheme(title: ProjectString.subTitle),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding:
                           EdgeInsets.only(right: 16, left: 16, top: 150),
                      child: Card(
                        child: CustomCardWidget(whichMethod: false,),
                      )),
                ],
              ),
              flex: 6,
            ),
            Padding(
              padding:  EdgeInsets.only(top: 20, bottom: 20),
              child: TextWidget(icerik: 'Completed', textColor: Colors.black),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                  padding:  EdgeInsets.only(right: 16, left: 16),
                  child: CustomCardWidget(whichMethod: true,)),
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: CustomButton(text: 'Add New Task',onpressed: (){
                navigateToWidget(context, AddNewTaskScreen());
              },)
            )
          ],
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({
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
          ?.copyWith(color: textColor, fontSize: 15),
    );
  }
}

class ProjectTextTheme extends StatelessWidget {
  final String title;

  const ProjectTextTheme({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.titleLarge,
        fontWeight: FontWeight.w700,
        fontSize: 30,
        color: textColor,
      ),
    );
  }
}
