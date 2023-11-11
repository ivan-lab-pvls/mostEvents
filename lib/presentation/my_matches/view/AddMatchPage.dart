// ignore_for_file: file_names, use_key_in_widget_constructors, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMyMatchPage extends StatefulWidget {
  const AddMyMatchPage({super.key});

  @override
  State<AddMyMatchPage> createState() => _AddMyMatchPageState();
}

class _AddMyMatchPageState extends State<AddMyMatchPage> {
  final TextEditingController _teamFirst = TextEditingController();
  final TextEditingController _teamSecond = TextEditingController();
  final TextEditingController _dateGame = TextEditingController();
  final TextEditingController _timeGame = TextEditingController();
  String _teamFirstName = '';
  String _teamSecondName = '';
  String _dateGameName = '';
  String _timeGameName = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        _dateGameName = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != TimeOfDay.now()) {
      setState(() {
        _timeGameName = pickedTime.format(context);
      });
    }
  }

  void _handleFirstTeamNameChanged(String value) {
    setState(() {
      _teamFirstName = value;
    });
  }

  void _handleSecondTeamNameChanged(String value) {
    setState(() {
      _teamSecondName = value;
    });
  }

  Future<void> saveMatchesList(List<MatchDetails> matches) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringList =
        matches.map((match) => jsonEncode(match.toJson())).toList();
    await prefs.setStringList('matches', stringList);
  }

  Future<List<MatchDetails>> loadMatchesList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? stringList = prefs.getStringList('matches');
    if (stringList != null) {
      return stringList
          .map((item) => MatchDetails.fromJson(jsonDecode(item)))
          .toList();
    } else {
      return [];
    }
  }

  void _saveMatchData() async {
    if (_teamFirstName != '' &&
        _teamSecondName != '' &&
        _dateGameName != '' &&
        _timeGameName != '') {
      List<MatchDetails> matches = await loadMatchesList();
      MatchDetails match = MatchDetails(
        firstTeam: _teamFirstName,
        secondTeam: _teamSecondName,
        date: _dateGameName,
        time: _timeGameName,
      );
      matches.add(match);
      await saveMatchesList(matches);
      Navigator.pop(context);
    } else {
      _showErrorSnackBar('You have empty fields!');
    }
  }

  void _showErrorSnackBar(String message) {
    final snackBar = SnackBar(
      content: Center(
          child: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
        ),
      )),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _pickImage(String teamTag) async {
    final PermissionStatus permissionStatus = await Permission.photos.request();
    if (permissionStatus == PermissionStatus.granted) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (image != null) {
        File tempImage = File(image.path);
        Directory appDir = await getApplicationDocumentsDirectory();
        final String imageFileName =
            '$teamTag-${DateTime.now().millisecondsSinceEpoch}.png';
        File newImage = await tempImage.copy('${appDir.path}/$imageFileName');
      }
    }
  }

  @override
  void dispose() {
    _teamFirst.dispose();
    _teamSecond.dispose();
    _dateGame.dispose();
    _timeGame.dispose();
    super.dispose();
  }

  void _handleSubmitted(String finalInput) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 0,
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  CupertinoIcons.back,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              const Text(
                'Your Playground',
                style: TextStyle(
                  color: Color.fromARGB(255, 11, 0, 55),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _teamFirstName = '';
                    _teamSecondName = '';
                    _timeGameName = '';
                    _dateGameName = '';
                  });
                  Navigator.pop(context);
                },
                child: const Icon(
                  CupertinoIcons.trash,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                'Team Info',
                style: TextStyle(
                  color: Color.fromARGB(255, 11, 0, 55),
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      // _pickImage('FirstTeam');
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(225, 208, 206, 206),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child:  Center(
                        child: Image.asset('assets/images/ball_red.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    children: [
                      // SizedBox(
                      //   height: 15,
                      //   width: 15,
                      //   child: Icon(
                      //     CupertinoIcons.cloud_download,
                      //     color: Colors.grey,
                      //     size: 15,
                      //   ),
                      // ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        ' ',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
              const Spacer(),
              SizedBox(
                height: 65,
                width: MediaQuery.of(context).size.width * .6,
                child: TextField(
                  controller: _teamFirst,
                  onChanged: _handleFirstTeamNameChanged,
                  onSubmitted: _handleSubmitted,
                  decoration: const InputDecoration(
                    hintText: 'First Team name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      // _pickImage('SecondTeam');
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(225, 208, 206, 206),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Image.asset('assets/images/ball_green.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    children: [
                      // SizedBox(
                      //   height: 15,
                      //   width: 15,
                      //   child: Icon(
                      //     CupertinoIcons.cloud_download,
                      //     color: Colors.grey,
                      //     size: 15,
                      //   ),
                      // ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        ' ',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
              const Spacer(),
              SizedBox(
                height: 65,
                width: MediaQuery.of(context).size.width * .6,
                child: TextField(
                  controller: _teamSecond,
                  onChanged: _handleSecondTeamNameChanged,
                  onSubmitted: _handleSubmitted,
                  decoration: const InputDecoration(
                    hintText: 'Second Team name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                'Date & Time',
                style: TextStyle(
                  color: Color.fromARGB(255, 11, 0, 55),
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: InkWell(
              onTap: () => _selectDate(context),
              child: Container(
                height: 65,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    border: Border.all(
                      width: 1.0,
                      color: const Color.fromARGB(255, 173, 172, 172),
                    )),
                child: Center(
                  child: Text(
                    _dateGameName == '' ? 'Choose Date' : _dateGameName,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: InkWell(
              onTap: () => _selectTime(context),
              child: Container(
                height: 65,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    border: Border.all(
                      width: 1.0,
                      color: const Color.fromARGB(255, 173, 172, 172),
                    )),
                child: Center(
                  child: Text(
                    _timeGameName == '' ? 'Choose Time' : _timeGameName,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: InkWell(
              onTap: _saveMatchData,
              child: Container(
                height: 65,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 252, 147, 10),
                ),
                child: const Center(
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
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

class MatchDetails {
  String firstTeam;
  String secondTeam;
  String date;
  String time;

  MatchDetails(
      {required this.firstTeam,
      required this.secondTeam,
      required this.date,
      required this.time});

  Map<String, dynamic> toJson() {
    return {
      'firstTeam': firstTeam,
      'secondTeam': secondTeam,
      'date': date,
      'time': time,
    };
  }

  factory MatchDetails.fromJson(Map<String, dynamic> json) {
    return MatchDetails(
      firstTeam: json['firstTeam'],
      secondTeam: json['secondTeam'],
      date: json['date'],
      time: json['time'],
    );
  }
}
