import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timezie/services/taskProvider.dart';
import 'taskDetailScreen.dart';
import 'package:timezie/models/noteModel.dart';


class todayTask extends StatefulWidget {
  @override
  _todayTask createState() => _todayTask();
}

class _todayTask extends State<todayTask> {
  String filter = 'All';
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    Provider.of<taskProvider>(context, listen: false).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final TaskProvider = Provider.of<taskProvider>(context);
    final tasks = TaskProvider.tasks.where((task) {
      if (filter == 'All') return true;
      return task.status == filter;
    }).toList();

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60),
          Text(
            'Today\'s Tasks',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          _buildDateRow(),
          SizedBox(height: 10),
          _buildFilterButtons(),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return _buildTaskCard(task);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (index) {
        final date = DateTime.now().subtract(Duration(days: 2 - index));
        final isSelected = date.day == selectedDate.day;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedDate = date;
            });
          },
          child: Container(
            height: 90,
            width: 60,
            decoration: BoxDecoration(
              color: isSelected ? Color(0xFF967bb6) : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  DateFormat('MMM').format(date),
                  style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 15),
                ),
                Text(
                  date.day.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 25),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildFilterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildFilterButton('All'),
        _buildFilterButton('To do'),
        _buildFilterButton('In Progress'),
      ],
    );
  }

  Widget _buildFilterButton(String label) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFede8ff)),
      onPressed: () {
        setState(() {
          filter = label;
        });
      },
      child: Text(label),
    );
  }

 /* Widget _buildTaskCard(notemodel task) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        height: 150,
        width: double.infinity,
        child: Card(
          //color: Color(0xFFf6ddfa),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ListTile(
              title: Text(task.title),
              subtitle: Text(
                  DateFormat('hh:mm a').format(DateTime.parse(task.startTime))),
              trailing: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    color: Color(0xFFf6ddfa),
                    child: Image.asset(
                      'assets/icons/personal.png',
                      fit: BoxFit.cover, // Adjust the fit as needed
                       // Adjust the height as needed
                    ),
                  ),
                  SizedBox(height: 8,),
                  _buildStatusTag(task.status)
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetailScreen(task: task),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
*/
  Widget _buildTaskCard(notemodel task) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Dismissible(
        key: Key(task.id.toString()),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          setState(() {
            Provider.of<taskProvider>(context, listen: false).removeTask(task);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${task.title} dismissed")),
          );
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => taskDetailScreen(task: task),
              ),
            );
          },
          child: Container(
            height: 150,
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.title,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              DateFormat('hh:mm a').format(DateTime.parse(task.startTime)),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
        
                          Container(
                            height: 30,
                            width: 30,
        
        
                            child: Center(
                              child: Image.asset(
                                _getCategoryIcon(task.category),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          _buildStatusTag(task.status),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildStatusTag(String status) {
    Color color;
    Color textColor;
    if (status == 'Done') {
      color = Color(0xFF967bb6);
    } else if (status == 'In Progress') {
      color = Color(0xFF967bb6);
    } else {
      color = Color(0xFF967bb6);
      //textColor=Color(0xFF967bb6); 0xFF967bb6
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
String _getCategoryIcon(String category) {
  switch (category) {
    case 'Personal':
      return 'assets/icons/personal1.png';
    case 'Household':
      return 'assets/icons/household1.png';
    case 'Work':
      return 'assets/icons/work1.png';
    default:
      return 'assets/icons/health1.png';
  }
}

