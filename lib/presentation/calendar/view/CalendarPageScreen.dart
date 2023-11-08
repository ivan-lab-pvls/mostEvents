// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_final_fields, avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:most_sport/presentation/match_board/data/data.dart';
import 'package:most_sport/presentation/match_board/view/choosedMatchInfo/ChoosedMatchInfo.dart';
import 'package:most_sport/widgets/other/data.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreenPage extends StatefulWidget {
  @override
  State<CalendarScreenPage> createState() => _CalendarScreenPageState();
}

class _CalendarScreenPageState extends State<CalendarScreenPage> {
  String selectedDayToData = '';
  final DataRepository dataRepository = DataRepository();
  @override
  void initState() {
    super.initState();
    selectedDayToData = getCurrentDate();
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 70,
          ),
          SingleChildScrollView(
              child: TableCalendar(
                firstDay: DateTime.utc(2023, 1, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    selectedDayToData = getStringDataFromDate(_selectedDay!);
                  });
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                    color: Color.fromARGB(255, 12, 3, 35),
                    fontWeight: FontWeight.w500,
                  ),
                  titleCentered: true,
                ),
              ),
            ),
          
          Expanded(
            child: Container(
              child: FutureBuilder(
                future: dataRepository.fetchDataByDay(selectedDayToData),
                builder: (context, snapshot) {
                  var matchData = snapshot.data;
                  int length = 1;
                  String time = '';
                  String timeLeft = '';
                  if (matchData != null) {
                    length = matchData.length;
                    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                        snapshot.data!['response'][0]['fixture']['timestamp'] *
                            1000);
                    time = DateFormat.Hm().format(dateTime);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Text(
                        'No matches on this day.\nCreate our match or choose another day!');
                  } else {
                    return ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 1.2,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            itemCount: length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChoosedMatchInfo(
                                          teamHome: snapshot.data!['response']
                                                  [index]['teams']['home']
                                                  ['name']
                                              .toString(),
                                          teamAway: snapshot.data!['response']
                                                  [index]['teams']['away']
                                                  ['name']
                                              .toString(),
                                          leagueName: snapshot.data!['response']
                                                  [index]['league']['name']
                                              .toString(),
                                          time: time,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .9,
                                    height: MediaQuery.of(context).size.height *
                                        .2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color:
                                            Colors.white),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              timeLeft,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              snapshot.data!['response'][index]
                                                      ['league']['name']
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            SizedBox(
                                                height: 15,
                                                width: 15,
                                                child: Image.asset(
                                                    'assets/images/ball_green.png')),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                      width: 30,
                                                      child: Image.asset(
                                                          'assets/images/ball_green.png'),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      snapshot.data!['response']
                                                              [index]['teams']
                                                              ['home']['name']
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 11, 0, 55),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                      width: 30,
                                                      child: Image.asset(
                                                          'assets/images/ball_red.png'),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      snapshot.data!['response']
                                                              [index]['teams']
                                                              ['away']['name']
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 11, 0, 55),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Text(
                                              time,
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 11, 0, 55),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
