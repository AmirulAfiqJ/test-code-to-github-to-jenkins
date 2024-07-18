import 'package:bizapptrack/ui/customAppBar.dart';
import 'package:bizapptrack/viewmodel/home_viewmodel.dart';
import 'package:bizapptrack/viewmodel/status_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:bizapptrack/ui/sideNav.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  // final String username;

  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel viewModel = HomeViewModel();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String dropdownValue = 'Total Active User';
  Map<String, List<dynamic>> dataAU = {};
  Map<String, List<dynamic>> datayearAU = {};
  Map<String, List<dynamic>> dataOR = {};
  Map<String, List<dynamic>> datayearOR = {};
  Map<String, List<dynamic>> dataB = {};
  Map<String, List<dynamic>> datayearB = {};
  Map<String, List<dynamic>> dataULT1 = {};
  Map<String, List<dynamic>> datayearULT1 = {};
  Map<String, List<dynamic>> dataULT12 = {};
  Map<String, List<dynamic>> datayearULT12 = {};

  // final Map<String, List<dynamic>> data2 = {
  //   'Basic+': [120, 200],
  //   'Privilege 6': [15, 30],
  //   'Pro': [10, 22],
  //   'Superb 12': [8, 15],
  //   'Ultimate 1': [7, 18],
  //   'Ultimate 6': [5, 12],
  //   'Ultimate 12': [6, 10],
  //   'Ultra': [9, 15]
  // };

  void fetchData() async {
    StatusController model =
        Provider.of<StatusController>(context, listen: false);
    setState(() {
      model.call = true;
    });
    try {
      if (dropdownValue == 'Total Active User') {
        await model.totalactiveuser(context);
        setState(() {
          dataAU = model.getDataAU();
          datayearAU = model.getDataYearAU();
        });
      } else if (dropdownValue == 'Total Orders') {
        await model.ordertotal(context);
        setState(() {
          dataOR = model.getDataOR();
          datayearOR = model.getDataYearOR();
        });
      } else if (dropdownValue == 'Total Subscriber BASIC+') {
        await model.totalsubscriber(context);
        setState(() {
          dataB = model.getDataB();
          datayearB = model.getDataYearB();
        });
      } else if (dropdownValue == 'Total Subscriber ULTIMATE 1') {
        await model.totalsubscriber(context);
        setState(() {
          dataULT1 = model.getDataULT1();
          datayearULT1 = model.getDataYearULT1();
        });
      } else if (dropdownValue == 'Total Subscriber ULTIMATE 12') {
        await model.totalsubscriber(context);
        setState(() {
          dataULT12 = model.getDataULT12();
          datayearULT12 = model.getDataYearULT12();
        });
      }
    } finally {
      setState(() {
        model.call = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    viewModel.getPref(context);
    print(viewModel.username);
  }

  Map<String, dynamic> getChartConfiguration() {
    switch (dropdownValue) {
      case 'Total Active User':
        return {'maxY': 5000, 'interval': 500, 'data': dataAU};
      case 'Total Orders':
        return {'maxY': 100000, 'interval': 10000, 'data': dataOR};
      case 'Total Subscriber BASIC+':
        return {'maxY': 100, 'interval': 10, 'data': dataB};
      case 'Total Subscriber ULTIMATE 1':
        return {'maxY': 30, 'interval': 5, 'data': dataULT1};
      case 'Total Subscriber ULTIMATE 12':
        return {'maxY': 30, 'interval': 5, 'data': dataULT12};
      default:
        return {'maxY': 5000, 'interval': 500, 'data': dataAU};
    }
  }

  @override
  Widget build(BuildContext context) {
    final chartConfig = getChartConfiguration();
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(username: viewModel.username, scaffoldKey: _scaffoldKey),
      body: Row(
        children: [
          SideDrawer(username: viewModel.username),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dropdownValue,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        DropdownButton<String>(
                          value: dropdownValue,
                          items: [
                            'Total Active User',
                            'Total Orders',
                            'Total Subscriber BASIC+',
                            'Total Subscriber ULTIMATE 1',
                            'Total Subscriber ULTIMATE 12'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                              fetchData(); // Fetch data when dropdown value changes
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 400,
                            width: 800,
                            child: BarChart(
                              BarChartData(
                                alignment: BarChartAlignment.spaceAround,
                                maxY: chartConfig['maxY'],
                                barTouchData: BarTouchData(
                                  enabled: true,
                                  touchTooltipData: BarTouchTooltipData(
                                    tooltipBgColor: Colors.blueGrey,
                                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                      String weekDay;
                                      switch (group.x.toInt()) {
                                        case 0:
                                          weekDay = 'Today';
                                          break;
                                        case 1:
                                          weekDay = 'Yesterday';
                                          break;
                                        case 2:
                                          weekDay = 'This Week';
                                          break;
                                        case 3:
                                          weekDay = 'This Month';
                                          break;
                                        default:
                                          weekDay = '';
                                      }
                                      return BarTooltipItem(
                                        '$weekDay\n',
                                        TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: (rod.y).toString(),
                                            style: TextStyle(
                                              color: Colors.yellow,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                titlesData: FlTitlesData(
                                  leftTitles: SideTitles(
                                    showTitles: true,
                                    interval: chartConfig['interval'],
                                    getTextStyles: (context, value) => TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                    margin: 10,
                                    reservedSize: 40,
                                  ),
                                  rightTitles: SideTitles(showTitles: false),
                                  topTitles: SideTitles(showTitles: false),
                                  bottomTitles: SideTitles(
                                    showTitles: true,
                                    getTitles: (double value) {
                                      switch (value.toInt()) {
                                        case 0:
                                          return 'Today';
                                        case 1:
                                          return 'Yesterday';
                                        case 2:
                                          return 'This Week';
                                        case 3:
                                          return 'This Month';
                                        default:
                                          return '';
                                      }
                                    },
                                  ),
                                ),
                                borderData: FlBorderData(show: false),
                                barGroups: List.generate(4, (index) {
                                  double yValue = chartConfig['data'][dropdownValue]![index].toDouble();
                                  return BarChartGroupData(
                                    x: index,
                                    barRods: [
                                      BarChartRodData(
                                        y: yValue,
                                        colors: [
                                          Colors.lightBlueAccent,
                                          Colors.greenAccent
                                        ],
                                        width: 30,
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 50),
                        Container(
                          height: 110,
                          width: 200,
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.symmetric(vertical: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'This Year Data',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    dropdownValue == 'Total Active User'
                                        ? datayearAU[dropdownValue]![0].toString()
                                        : dropdownValue == 'Total Orders'
                                        ? datayearOR[dropdownValue]![0].toString()
                                        : dropdownValue == 'Total Subscriber BASIC+'
                                        ? datayearB[dropdownValue]![0].toString()
                                        : dropdownValue == 'Total Subscriber ULTIMATE 1'
                                        ? datayearULT1[dropdownValue]![0].toString()
                                        : dropdownValue == 'Total Subscriber ULTIMATE 12'
                                        ? datayearULT12[dropdownValue]![0].toString()
                                        : 'N/A',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 80),
                    // Column(
                    //   children: [
                    //     Text(
                    //       'Total Specific Subscriber',
                    //       style: TextStyle(
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.black,
                    //       ),
                    //     ),
                    //     Container(
                    //       height: 400,
                    //       child: BarChart(
                    //         BarChartData(
                    //           alignment: BarChartAlignment.spaceAround,
                    //           maxY: 300,
                    //           barTouchData: BarTouchData(
                    //             enabled: true,
                    //             touchTooltipData: BarTouchTooltipData(
                    //               tooltipBgColor: Colors.blueGrey,
                    //               getTooltipItem:
                    //                   (group, groupIndex, rod, rodIndex) {
                    //                 String subscriptionType;
                    //                 String period =
                    //                     rodIndex == 0 ? 'Month' : 'Year';
                    //                 switch (group.x.toInt()) {
                    //                   case 0:
                    //                     subscriptionType = 'Basic+';
                    //                     break;
                    //                   case 1:
                    //                     subscriptionType = 'Privilege 6';
                    //                     break;
                    //                   case 2:
                    //                     subscriptionType = 'Pro';
                    //                     break;
                    //                   case 3:
                    //                     subscriptionType = 'Superb 12';
                    //                     break;
                    //                   case 4:
                    //                     subscriptionType = 'Ultimate 1';
                    //                     break;
                    //                   case 5:
                    //                     subscriptionType = 'Ultimate 6';
                    //                     break;
                    //                   case 6:
                    //                     subscriptionType = 'Ultimate 12';
                    //                     break;
                    //                   case 7:
                    //                     subscriptionType = 'Ultra';
                    //                     break;
                    //                   default:
                    //                     subscriptionType = '';
                    //                 }
                    //                 return BarTooltipItem(
                    //                   '$subscriptionType - $period\n',
                    //                   TextStyle(
                    //                     color: Colors.white,
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //                   children: <TextSpan>[
                    //                     TextSpan(
                    //                       text: (rod.y).toString(),
                    //                       style: TextStyle(
                    //                         color: Colors.yellow,
                    //                         fontWeight: FontWeight.w500,
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 );
                    //               },
                    //             ),
                    //           ),
                    //           titlesData: FlTitlesData(
                    //             leftTitles: SideTitles(
                    //               showTitles: true,
                    //               interval: 50,
                    //               getTextStyles: (context, value) => TextStyle(
                    //                 fontSize: 15,
                    //                 color: Colors.black,
                    //               ),
                    //               margin: 10,
                    //               reservedSize: 40,
                    //             ),
                    //             rightTitles: SideTitles(showTitles: false),
                    //             topTitles: SideTitles(showTitles: false),
                    //             bottomTitles: SideTitles(
                    //               showTitles: true,
                    //               getTitles: (double value) {
                    //                 switch (value.toInt()) {
                    //                   case 0:
                    //                     return 'Basic+';
                    //                   case 1:
                    //                     return 'Privilege 6';
                    //                   case 2:
                    //                     return 'Pro';
                    //                   case 3:
                    //                     return 'Superb 12';
                    //                   case 4:
                    //                     return 'Ultimate 1';
                    //                   case 5:
                    //                     return 'Ultimate 6';
                    //                   case 6:
                    //                     return 'Ultimate 12';
                    //                   case 7:
                    //                     return 'Ultra';
                    //                   default:
                    //                     return '';
                    //                 }
                    //               },
                    //             ),
                    //           ),
                    //           borderData: FlBorderData(show: false),
                    //           barGroups:
                    //               List.generate(data2.keys.length, (index) {
                    //             String key = data2.keys.elementAt(index);
                    //             return BarChartGroupData(
                    //               x: index,
                    //               barRods: [
                    //                 BarChartRodData(
                    //                   y: data2[key]![0].toDouble(),
                    //                   colors: [Colors.lightBlueAccent],
                    //                   width: 20,
                    //                 ),
                    //                 BarChartRodData(
                    //                   y: data2[key]![1].toDouble(),
                    //                   colors: [Colors.greenAccent],
                    //                   width: 20,
                    //                 ),
                    //               ],
                    //               barsSpace: 4,
                    //             );
                    //           }),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
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
