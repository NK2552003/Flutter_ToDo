import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:to_do_app/font_bold.dart';
import 'package:to_do_app/text_field.dart';
import 'package:intl/intl.dart';

class Task {
  final String title;
  bool completed;
  final String subtitle;
  final String date;
  final String time;
  Task(
      {required this.title,
      required this.subtitle,
      this.date = " ",
      this.time = " ",
      this.completed = false});
}

class TickTickScreen extends StatefulWidget {
  @override
  _TickTickScreenState createState() => _TickTickScreenState();
}

class _TickTickScreenState extends State<TickTickScreen> {
  
  final List<Task> _tasks = [];

  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _titleTextEditingController = TextEditingController();
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 245, 185, 185),
            radius: 22,
            child: Image.asset('assets/profile_pic.png'),
          ),
          title: Text(
            'Hello There!',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
          subtitle: const Text(
            "Good To See You Again :)",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    showDatePicker(
                        context: context,
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2026));
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Gap(18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Today\'s Task",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(DateFormat("EEEE, dd MMMM").format(DateTime.now()),
                        style: TextStyle(color: Colors.grey.shade700)),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD5E8FA),
                      foregroundColor: Colors.blue.shade800,
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {
                    _showAddTaskDialog(context);
                  },
                  child: const Text("+ New Task"),
                ),
              ],
            ),
            const Gap(12),
            SingleChildScrollView(
              physics: const PageScrollPhysics(),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(1),
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      border: Border(
                          left: BorderSide(
                              color: Colors.deepPurple.shade700, width: 4),
                          right:  BorderSide(
                              color: Colors.deepPurple.shade700, width: 1.5),
                          top:  BorderSide(
                              color: Colors.deepPurple.shade700, width: 0.5),
                          bottom:  BorderSide(
                              color: Colors.deepPurple.shade700, width: 0.5),
                          ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(_tasks[index].title,
                                maxLines: 2,
                                    style: TextStyle(
                                        decoration: _tasks[index].completed
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: _tasks[index].completed
                                            ? Colors.grey.shade600
                                            : Colors.deepPurple.shade900)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_tasks[index].subtitle,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: _tasks[index].completed
                                                ? Colors.grey.shade600
                                                : const Color.fromARGB(
                                                    255, 121, 84, 184))),
                                    const Divider(
                                      thickness: 2.0,
                                    ),
                                    Text(
                                      "${_tasks[index].date} at ${_tasks[index].time}",
                                      style: TextStyle(
                                          color: _tasks[index].completed
                                              ? Colors.grey.shade600
                                              : const Color.fromARGB(
                                                  255, 121, 84, 184),
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                leading: Checkbox(
                                  value: _tasks[index].completed,
                                  onChanged: (value) {
                                    setState(() {
                                      _tasks[index].completed = value!;
                                    });
                                  },
                                  visualDensity: VisualDensity.compact,
                                  activeColor: Colors.blue, // Set desired color
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      _tasks.removeAt(index);
                                    });
                                  },
                                  color: Colors.red, // Set desired color
                                ),
                              ),
                            ]),
                      ),
                    ]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 220, 226, 230),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(color: Colors.deepPurple.shade500)),
          title: const Center(
              child: Text(
            "Add Task",
            style: TextStyle(
                fontSize: 26, fontWeight: FontWeight.w900, color: Colors.black),
          )),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 500,
              height: 330,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Task Title", style: AppStyle.headingOne),
                  const Gap(6),
                  TextFieldWidget(
                      hintText: 'Enter the Task Here',
                      maxLine: 1,
                      txtController: _textEditingController),
                  const Gap(12),
                  const Text("Task Description", style: AppStyle.headingOne),
                  const Gap(6),
                  TextFieldWidget(
                      hintText: "Enter the Description Here",
                      maxLine: 4,
                      txtController: _titleTextEditingController),
                  const Gap(12),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DateTimeWidget(
                          title: "Date",
                          icon: Icons.calendar_month_outlined,
                          onTap: () async {
                            DateTime? selectedTime = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2023),
                              lastDate: DateTime(2025),
                            );
                            if (selectedTime != null) {
                              setState(() {
                                date = selectedTime;
                              });
                            }
                          },
                          showTitle: DateFormat("yyyy-MM-dd").format(date),
                        ),
                        const Gap(12),
                        DateTimeWidget(
                          title: "Time",
                          showTitle: time.format(context),
                          icon: Icons.timer_outlined,
                          onTap: () async {
                            final TimeOfDay? timeSelected =
                                await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (timeSelected != null) {
                              setState(() {
                                time = timeSelected;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD5E8FA),
                foregroundColor: Colors.blue.shade800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: BorderSide(
                  color: Colors.blue.shade800,
                ),
              ),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD5E8FA),
                foregroundColor: Colors.blue.shade800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: BorderSide(
                  color: Colors.blue.shade800,
                ),
              ),
              child: const Text("Add"),
              onPressed: () {
                setState(() {
                  String taskTitle = _textEditingController.text;
                  String taskSubtitle = _titleTextEditingController.text;
                  if (taskTitle.isNotEmpty) {
                    var newTask = Task(
                        title: taskTitle,
                        subtitle: taskSubtitle,
                        date: DateFormat("EEEE, dd MMMM").format(date),
                        time: time.format(context));
                    _tasks.add(newTask);
                    _textEditingController.clear();
                    _titleTextEditingController.clear();
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({
    super.key,
    required this.showTitle,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final String showTitle;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyle.headingOne,
          ),
          Material(
            color: const Color.fromARGB(255, 208, 214, 219),
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(icon),
                      const Gap(5),
                      Text(showTitle),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
