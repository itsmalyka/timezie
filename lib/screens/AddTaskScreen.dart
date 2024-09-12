import 'package:flutter/material.dart';
import 'package:timezie/screens/todayTask.dart';
import 'package:timezie/services/databaseHelper.dart';
import 'package:timezie/models/noteModel.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';
  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now().add(Duration(days: 1));
  String _status = 'to do';
  double _completionPercentage = 0;
  String category='Work';
  TimeOfDay selectedTime = TimeOfDay.now();
  String formattedTime = '12:00';
  double currentSliderValue = 0;

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

      final newNote = notemodel(
        title: _title,
        content: _content,
        startTime: _startTime,
        endTime: _endTime,
        status: _status,
        completionPercentage: _completionPercentage,
        category: category
      );

      await DatabaseHelper().insert(newNote);

      Navigator.push(context, MaterialPageRoute(builder: (context)=> todayTask()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            Navigator.pop;
                          },
                          icon: Icon(
                            Icons.arrow_circle_left,
                            color: Color(0xFF967bb6),
                          ),
                          iconSize: 40,
                        ), //icon back
                        Text(
                          'Add Note',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            //
                            // \fontFamily: 'Ubuntu'
                          ),
                        ), //add text
                        IconButton(
                          onPressed: saveNote,
                          icon: Icon(
                            Icons.check_circle,
                            color: Color(0xFF967bb6),
                          ),
                          iconSize: 40,
                        ) //icon save
                        //IconButton(icon:Icon(Icons.check),iconSize: 30,color: Colors.purple,onPressed: _saveNote,)
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
                          //task group
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
                            subtitle: Text('Work'),
                            trailing: DropdownButton<String>(
                              value: 'Work',
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
                                  category=newValue!;
                                });
                                // handle task group change
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text('Title', style: TextStyle(fontSize: 20)),
                    //title
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
                        //decoration: InputDecoration(labelText: 'Project Name'),
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
                    Text('Description',
                        style: TextStyle(fontFamily: 'OpenSans', fontSize: 20)),
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
                        //decoration: InputDecoration(labelText: 'Description'),
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
                    SizedBox(
                      height: 16,
                    ),
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
                        //leading: Icon(Icons.calendar_today),
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
                    SizedBox(height: 16.0),
                    //end date
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
                      //end date
                      child: ListTile(
                        //leading: Icon(Icons.calendar_today),
                        title: Text('End Date',
                            style: TextStyle(
                                fontFamily: 'OpenSans', fontSize: 20)),
                        subtitle:
                            Text(DateFormat('dd MMM, yyyy').format(_endTime)),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.calendar_today_rounded,
                            color: Color(0xFF967bb6),
                            size: 30,
                          ),
                          onPressed: () => _selectDate(context, false),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    //time
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
                    /*Container(padding: EdgeInsets.all(16.0),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Select Time ',style: TextStyle(fontSize: 20),),
                          IconButton(
                            icon: Icon(Icons.access_time_filled_sharp,color: Color(0xFF967bb6),size: 40,),
                            onPressed: ()async{
                              final TimeOfDay? time=await showTimePicker(context: context, initialTime: selectedTime,initialEntryMode: TimePickerEntryMode.dial);
                              if(time!=null){
                                setState(() {
                                  selectedTime=time;
                                });
                                formattedTime='${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';
                              }
                              }
                            ,
                          ),
                        ],
                      ),

                    ),*/
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Task Status',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              _status = 'To do';
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              primary: Color(0xFF967bb6), // Background color
                            ),
                            child: Text(
                              'To do',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            )),
                        SizedBox(width: 20),
                        ElevatedButton(
                            onPressed: () {
                              _status = 'In Progress';
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              primary: Color(0xFF967bb6), // Background color
                            ),
                            child: Text(
                              'In Progress',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _status = 'Done';
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              primary: Color(0xFF967bb6), // Background color
                            ),
                            child: Text(
                              'Done',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            )),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Text('Progress Status',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 8,
                    ),
                    Slider(
                      max: 100,
                        divisions: 100,
                        value: currentSliderValue,
                        label: currentSliderValue.round().toString(),
                        onChanged: (value) {
                          setState(() {
                            currentSliderValue = value;
                            _completionPercentage=value;
                          });
                        })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
