import 'package:flutter/material.dart';
import 'package:timezie/models/noteModel.dart';
import 'package:intl/intl.dart';
import 'package:timezie/services/databaseHelper.dart';

class taskDetailScreen extends StatefulWidget {
  final notemodel task;

  taskDetailScreen({required this.task});

  @override
  _taskDetailScreenState createState() => _taskDetailScreenState();
}

class _taskDetailScreenState extends State<taskDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _content;
  late DateTime _startTime;
  late DateTime _endTime;
  late String _status;
  late double _completionPercentage;
  late String category;
  late TimeOfDay selectedTime;
  late String formattedTime;
  late double currentSliderValue;

  @override
  void initState() {
    super.initState();
    _title = widget.task.title;
    _content = widget.task.content;
    _startTime = DateTime.parse(widget.task.startTime);
    _endTime = DateTime.parse(widget.task.endTime);
    _status = widget.task.status;
    _completionPercentage = widget.task.completionPercentage;
    category = widget.task.category;
    //selectedTime = widget.task.;
    //formattedTime = DateFormat.Hm().format(widget.task.startTime);
    currentSliderValue = widget.task.completionPercentage.toDouble();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startTime : _endTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != (isStartDate ? _startTime : _endTime)) {
      setState(() {
        if (isStartDate) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  void saveNote() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final updatedNote = notemodel(
        id: widget.task.id, // Ensure the ID remains the same for update
        title: _title,
        content: _content,
        startTime: _startTime,
        endTime: _endTime,
        status: _status,
        completionPercentage: _completionPercentage,
        category: category,
      );

      await DatabaseHelper().update(updatedNote);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfffbfe),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_circle_left,
                            color: Color(0xFF967bb6),
                          ),
                          iconSize: 40,
                        ),
                        Text(
                          'Edit Note',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        IconButton(
                          onPressed: saveNote,
                          icon: Icon(
                            Icons.check_circle,
                            color: Color(0xFF967bb6),
                          ),
                          iconSize: 40,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      margin: EdgeInsets.only(bottom: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.category_rounded,
                              color: Color(0xFF967bb6),
                              size: 30,
                            ),
                            title: Text(
                              'Task Group',
                              style: TextStyle(
                                  fontFamily: 'OpenSans', fontSize: 20),
                            ),
                            subtitle: Text(category),
                            trailing: DropdownButton<String>(
                              value: category,
                              items: <String>[
                                'Work',
                                'Personal',
                                'Health',
                                'Household'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  category = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text('Title', style: TextStyle(fontSize: 20)),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      margin: EdgeInsets.only(bottom: 16.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF967bb6),
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        initialValue: _title,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a project name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _title = value!;
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text('Description', style: TextStyle(fontSize: 20)),
                    //description
                    Container(
                      padding: EdgeInsets.all(16.0),
                      margin: EdgeInsets.only(bottom: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        initialValue: _content,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _content = value!;
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    //start date
                    Container(
                      padding: EdgeInsets.all(16.0),
                      margin: EdgeInsets.only(bottom: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title:
                            Text('Start Date', style: TextStyle(fontSize: 20)),
                        subtitle:
                            Text(DateFormat('dd MMM, yyyy').format(_startTime)),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.calendar_today_rounded,
                            size: 30,
                            color: Color(0xFF967bb6),
                          ),
                          onPressed: () => _selectDate(context, true),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Select Time ',
                              style: TextStyle(fontSize: 20),
                            )),
                        SizedBox(
                          width: 160,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.access_time_filled_sharp,
                            color: Color(0xFF967bb6),
                            size: 50,
                          ),
                          onPressed: () async {
                            final TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: selectedTime,
                                initialEntryMode: TimePickerEntryMode.dial);
                            if (time != null) {
                              setState(() {
                                selectedTime = time;
                              });
                              formattedTime =
                                  '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';
                            }
                          },
                        ),
                      ],
                    ),
                    Text('Task Completion Status',style:TextStyle(fontSize: 20)),
                    Slider(
                      value: currentSliderValue,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          currentSliderValue = value;
                        });
                      },
                    ),
                  ], //child
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} //container
