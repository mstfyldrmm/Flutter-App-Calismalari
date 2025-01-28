// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:samples/to_do_list_app.dart/constants/color.dart';
import 'package:samples/to_do_list_app.dart/constants/padding.dart';
import 'package:samples/to_do_list_app.dart/model/newTodoModel.dart';
import 'package:samples/to_do_list_app.dart/services/services.dart';


class CustomCardWidget extends StatefulWidget {
  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();

  final bool whichMethod;
   CustomCardWidget({super.key, required this.whichMethod});
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  Services services = Services();
  late Future<List<NewTodomodel>> todoModeller;
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    todoModeller = widget.whichMethod ? services.getCompletedTodos() : services.getUncompletedTodos();
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: ProjectPadding.cardRadius),
      child: FutureBuilder<List<NewTodomodel>>(
        future: todoModeller, // Future'dan veriyi bekliyoruz
        builder: (context, snapshot) {
          // Eğer veri yükleniyorsa
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } 
          // Eğer hata varsa
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } 
          // Eğer veri geldiyse
          else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final todo = snapshot.data![index]; // Veriyi snapshot'tan alıyoruz
                return Card.filled(
                  color: todo.isCompleted! ? disabledColor : textColor, // Tamamlanma durumuna göre renk değişimi
                  child: ListTile(
                    leading: Image.asset('assets/category_1.png'),      
                    title: Text(
                      todo.taskName!,
                      style: todo.isCompleted!
                          ? TaskTextStyle(fontWeight: FontWeight.w600).disabled
                          : TaskTextStyle(fontWeight: FontWeight.w600).enabled,
                    ),
                    subtitle: Text(
                      todo.taskDescription!,
                      style: todo.isCompleted!
                          ? TaskTextStyle(fontWeight: FontWeight.w400).disabled
                          : TaskTextStyle(fontWeight: FontWeight.w400).enabled,
                    ),
                    trailing: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (value) {
                        setState(() {
                          todo.isCompleted = value;
                          isSelected = value!;
                        });
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
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

class TaskTextStyle {
  final FontWeight fontWeight;

  TaskTextStyle({required this.fontWeight});

  // 'disabled' stilini bir getter olarak tanımlıyoruz.
  TextStyle get disabled => TextStyle(
        decoration: TextDecoration.lineThrough,
        fontWeight: fontWeight,
      );

  // 'enabled' stilini de bir getter olarak tanımlıyoruz.
  TextStyle get enabled => TextStyle(
        decoration: TextDecoration.none,
        fontWeight: fontWeight,
      );
}

