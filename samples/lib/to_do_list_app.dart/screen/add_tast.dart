import 'package:flutter/material.dart';
import 'package:samples/to_do_list_app.dart/constants/color.dart';
import 'package:samples/to_do_list_app.dart/constants/taskType.dart';
import 'package:samples/to_do_list_app.dart/model/taskModel.dart';
import 'package:samples/to_do_list_app.dart/product/custom_button.dart';
import 'package:samples/to_do_list_app.dart/screen/header.dart';
import 'package:samples/to_do_list_app.dart/model/newTodoModel.dart';
import 'package:samples/to_do_list_app.dart/services/services.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});
  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  List<bool> isSelected = [false, false, false];
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  Tasktype tasktype = Tasktype.note;
  Services newService = Services();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F5F9),
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_new_outlined), color: textColor,),
          title: Text('Add New Task', style: TextStyle(
            color: textColor
          ),),
          centerTitle: true,
          toolbarHeight: 80,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/header.png'),
                fit: BoxFit.cover,
              ),
            ),
          )),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextWidget(icerik: 'Task Title', textColor: textDarkColor,)
            ),
            _CustomTextField(hinTextt: 'Task Title', controller: taskNameController,),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextWidget(icerik: 'Category', textColor: textDarkColor),
                  IconButton.filled(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(isSelected[0] ? purpleColor : disabledColor)),
                    onPressed: () {
                      setState(() {
                        isSelected[0] = !isSelected[0];
                        tasktype = Tasktype.note;
                      });
                    },
                    icon: Icon(Icons.description),
                  ),
                  IconButton.filled(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(isSelected[1] ? purpleColor : disabledColor)),
                      onPressed: () {
                        setState(() {
                          isSelected[1] = !isSelected[1];
                          tasktype = Tasktype.calender;
                        });
                      },
                      icon: Icon(Icons.calendar_today_rounded)),
                  IconButton.filled(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(isSelected[2] ? purpleColor : disabledColor)),
                      onPressed: () {
                        setState(() {
                          isSelected[2] = !isSelected[2];
                          tasktype = Tasktype.contest;
                        });
                      },
                      icon: Icon(Icons.emoji_events)),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5, top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWidget(icerik: 'Date', textColor: textDarkColor),
                        Container(
                          child: _CustomTextField(hinTextt: 'Date', icons: Icon(Icons.calendar_today), controller: dateController,),
                          width: MediaQuery.of(context).size.width / 2,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, top: 20),
                    child: Column(
                      children: [
                        TextWidget(icerik: 'Time', textColor: textDarkColor),
                        Container(
                          child: _CustomTextField(hinTextt: 'Time', icons: Icon(Icons.access_time),controller: dateController,),
                          width: MediaQuery.of(context).size.width / 2,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: TextWidget(icerik: 'Note', textColor: textDarkColor),
            ),
            _CustomTextField(hinTextt: 'Notes', satirSayisi: 5, controller: taskDescriptionController,),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CustomButton(text: 'Save', onpressed: () {
                
                saveTodo();
                Navigator.pop(context);
              },),
            )
          ],
        ),
      )),
    );
  }
 

  Future<void> saveTodo() async {
    NewTodomodel newTodo = NewTodomodel(taskName: taskNameController.text, isCompleted: false, taskDescription: taskDescriptionController.text, type: Tasktype.contest.toString());
    await newService.addTodo(newTodo);

    setState(() {
      
    });
  }
}

class _CustomTextField extends StatelessWidget {
   _CustomTextField({
    this.satirSayisi = 1,
    this.icons =  const Icon(null),
    super.key, required this.hinTextt,
    required this.controller
  });
  final String hinTextt;
  final Icon icons;
  int satirSayisi;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: satirSayisi,
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hinTextt,
          fillColor: Color(0xFFFFFFFF),
          filled: true,
          suffixIcon: icons,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE0E0E0)))),
    );
  }
}
