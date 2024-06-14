import 'package:bizapptrack/viewmodel/status_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RevenueDashboard extends StatefulWidget {
  const RevenueDashboard({super.key});

  @override
  _RevenueDashboardState createState() => _RevenueDashboardState();
}

class _RevenueDashboardState extends State<RevenueDashboard> {
  double today = 0;
  double ystd = 0;
  double week = 0;
  double month = 0;
  double year = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    StatusController model = Provider.of<StatusController>(context, listen: false);

    setState(() {
      model.call = true;
      isLoading = true;
    });

    try {
      await model.ordertotal(context);

      setState(() {
        today = double.tryParse(model.today) ?? 0;
        ystd = double.tryParse(model.ystd) ?? 0;
        week = double.tryParse(model.week) ?? 0;
        month = double.tryParse(model.month) ?? 0;
        year = double.tryParse(model.year) ?? 0;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    } finally {
      setState(() {
        model.call = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: StatisticsWidget(
                    today: today,
                    ystd: ystd,
                    week: week,
                    month: month,
                    year: year,
                  ),
                ),
              ],
            ),
          );
  }
}

class StatisticsWidget extends StatelessWidget {
  final double today;
  final double ystd;
  final double week;
  final double month;
  final double year;

  const StatisticsWidget({
    required this.today,
    required this.ystd,
    required this.week,
    required this.month,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatisticItem(title: "Today", value: today),
        StatisticItem(title: 'Yesterday', value: ystd),
        StatisticItem(title: 'This week', value: week),
        StatisticItem(title: 'This month', value: month),
        StatisticItem(title: 'This year', value: year),
      ],
    );
  }
}

class StatisticItem extends StatelessWidget {
  final String title;
  final double value;

  const StatisticItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          Text(
            '\$ ${value.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 24, color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
