import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:timezie/screens/userscreen.dart';
import 'package:timezie/models/Profile.dart';
import 'todayTask.dart';
import 'AddTaskScreen.dart';
import 'package:timezie/services/taskProvider.dart';
import 'package:provider/provider.dart';

class taskscreen extends StatefulWidget {
  @override
  _taskscreenState createState() => _taskscreenState();
}

class _taskscreenState extends State<taskscreen> {
  int index = 0;
  late final DateTime today;
  late final DateTime startOfDay;
  late final DateTime endOfDay;
  late final taskOfToday;
  final PageController _pageController = PageController();
  final List<Widget> screens = [
    TaskScreenContent(startOfDay: DateTime.now().subtract(Duration(days: 1)), endOfDay: DateTime.now()),
    todayTask(),
    AddTaskScreen(),
    userscreen() // Add other screens as needed
  ];
  // Define the start and end of today
  /*final today = DateTime.now();
  final startOfDay = DateTime(today.year, today.month, today.day);
  final endOfDay =
      DateTime(today.year, today.month, today.day, 23, 59, 59, 999);
  final tasksOfToday = tasks.where((task) {
    final taskStartTime = DateTime.parse(task.startTime);
    return taskStartTime.isAfter(startOfDay) &&
        taskStartTime.isBefore(endOfDay);
  }).toList();*/

  //void _onItemTapped(int index) {
  // setState(() {
  // _currentIndex = index;
  // });
  //_pageController.jumpToPage(index);
  //}

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    startOfDay = DateTime(today.year, today.month, today.day);
    endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59, 999);

  }
  // void dispose() {
  //_pageController.dispose();
  // super.dispose();
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF2FF),
      body: screens[index],
      /*PageView(
        controller: _pageController,
        children: screens,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),*/
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Color(0xFFeff2ff),
          color: Color(0xFF967bb6),
          items: [
            Icon(Icons.home_filled, color: Color(0xFFeff2ff)),
            Icon(Icons.calendar_today_sharp, color: Color(0xFFeff2ff)),
            Icon(Icons.add_box, color: Color(0xFFeff2ff)),
            Icon(Icons.person, color: Color(0xFFeff2ff)),
          ],
          index: index,
          onTap: (index) => setState(() => this.index = index)),
    );
  }
}

class TaskScreenContent extends StatelessWidget {
  final String filter;
  final DateTime startOfDay;
  final DateTime endOfDay;

  TaskScreenContent({
    this.filter = 'All',
    required this.startOfDay,
    required this.endOfDay,
  });
  @override
  Widget build(BuildContext context) {
    final mytaskProvider = Provider.of<taskProvider>(context);
    final tasks = mytaskProvider.tasks.where((task) {
      if (filter == 'All') return true;
      return task.status == filter;
    }).toList();
    final tasksOfToday = tasks.where((task) {
      final taskStartTime = DateTime.parse(task.startTime);
      return taskStartTime.isAfter(startOfDay) &&
          taskStartTime.isBefore(endOfDay);
    }).toList();
    print(tasksOfToday.length);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  radius: 30,
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    Text(
                      "Hello!",
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      "Ashley Kim",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF967bb6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Take a look at\n your tasks for today",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),


                      SizedBox(height: 20),

                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'View Task',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  //Text('My name',style: TextStyle(),)
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "In Progress",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Work",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("Grocery shopping app\ndesign",
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        LinearProgressIndicator(
                          value: 0.7,
                          backgroundColor: Colors.grey[200],
                          color: Color(0xFF967bb6),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Health",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(
                          "Online Yoga Class",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        LinearProgressIndicator(
                          value: 0.3,
                          backgroundColor: Colors.grey[200],
                          color: Color(0xFFF3A6A6),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Task Groups",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TaskGroupWidget(title: "Work", tasks: 23, progress: 0.7),
            TaskGroupWidget(title: "Health", tasks: 30, progress: 0.52),
            TaskGroupWidget(title: "Personal", tasks: 30, progress: 0.87),
            TaskGroupWidget(title: "Household", tasks: 30, progress: 0.68),
          ],
        ),
      ),
    );
  }
}

class TaskGroupWidget extends StatelessWidget {
  final String title;
  final int tasks;
  final double progress;

  TaskGroupWidget(
      {required this.title, required this.tasks, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "$tasks Tasks",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            CircularPercentIndicator(
              radius: 40.0,
              lineWidth: 5.0,
              percent: progress,
              center: Text(
                "${(progress * 100).toInt()}%",
                style: TextStyle(fontSize: 14),
              ),
              progressColor: Color(0xFF967bb6),
            ),
          ],
        ),
      ),
    );
  }
}
