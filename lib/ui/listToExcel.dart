import 'package:bizapptrack/ui/button.dart';
import 'package:bizapptrack/ui/customAppBar.dart';
import 'package:bizapptrack/ui/login.dart';
import 'package:bizapptrack/ui/sideNav.dart';
import 'package:bizapptrack/ui/status.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/painting/box_border.dart' as prefix;

class ListToExcel extends StatefulWidget {
  const ListToExcel({Key? key}) : super(key: key);

  @override
  State<ListToExcel> createState() => _ListToExcelState();
}

class _ListToExcelState extends State<ListToExcel> {
   // Replace with actual user name
  final List<PenggunaModel> _list = [];

  final TextEditingController _penggunaIdController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _pakejController = TextEditingController();
  final TextEditingController _tarikhController = TextEditingController();
  final TextEditingController _emelController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final TextEditingController _dedagangController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _userName = 'John';

  @override
  void initState() {
    super.initState();
    setState(() {
      _list.clear();
    });
  }

  @override
  void dispose() {
    _penggunaIdController.dispose();
    _namaController.dispose();
    _pakejController.dispose();
    _tarikhController.dispose();
    _emelController.dispose();
    _noHpController.dispose();
    _dedagangController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: CustomAppBar(userName: _userName, scaffoldKey: _scaffoldKey),
      drawer: SideDrawer(),
      body: _body(),  
        );
  }

  Widget _body() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 50),
          const Header(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: _form(),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _listnameBox(),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: _button(),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _exportButton(),
              ),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _form() {
    List<String> onboardOptions = ['Yes', 'No'];

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: prefix.Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _penggunaIdController,
              decoration: const InputDecoration(labelText: 'ID PENGGUNA'),
            ),
            TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: 'NAMA'),
            ),
            TextFormField(
              controller: _pakejController,
              decoration: const InputDecoration(labelText: 'PAKEJ'),
            ),
            TextFormField(
              controller: _tarikhController,
              decoration: const InputDecoration(labelText: 'TARIKH TAMAT'),
            ),
            TextFormField(
              controller: _emelController,
              decoration: const InputDecoration(labelText: 'EMEL'),
            ),
            TextFormField(
              controller: _noHpController,
              decoration: const InputDecoration(labelText: 'NO. TEL'),
            ),
            DropdownButtonFormField<String>(
              value: _dedagangController.text.isEmpty
                  ? null
                  : _dedagangController.text,
              decoration: const InputDecoration(labelText: 'ONBOARD DEDAGANG'),
              items: onboardOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _dedagangController.text = newValue ?? '';
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _listnameBox() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        height: 428.0,
        child: Container(
          decoration: BoxDecoration(
            border: prefix.Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _listname(),
          ),
        ),
      ),
    );
  }

  Widget _listname() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _list.length,
      itemBuilder: (context, i) => ListTile(
        leading: Text(
          "${i + 1}. ",
          style: const TextStyle(fontSize: 16),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            setState(() {
              _list.removeAt(i);
            });
          },
        ),
        title: Text(
          "${_list[i].penggunaid}, ${_list[i].nama}, ${_list[i].pakej}, ${_list[i].tarikh}, ${_list[i].emel}, ${_list[i].nohp},  ${_list[i].dedagang}",
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _button() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 320),
      child: BizappButton(
        color: Color.fromARGB(255, 249, 161, 190),
        title: "Enter",
        tapCallback: _checksmartEntryI,
      ),
    );
  }

  Widget _exportButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 300),
      child: BizappButton(
        color: Colors.green,
        title: "Export to Excel",
        tapCallback: () {
          if (_list.isEmpty) {
            ScaffoldMessenger.of(context)
                .showSnackBar(_popup("No data. Please enter data"));
          } else {
            _exportListToExcel(_list).then((_) {
              debugPrint('Excel file exported successfully');
              ScaffoldMessenger.of(context)
                  .showSnackBar(_popup("Excel file exported successfully"));
            }).catchError((error) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(_popup("Error exporting Excel file: $error"));
            });
          }
        },
      ),
    );
  }

  SnackBar _popup(String text) {
    return SnackBar(
      onVisible: () {
        HapticFeedback.vibrate().timeout(const Duration(milliseconds: 1500));
        HapticFeedback.heavyImpact();
      },
      duration: const Duration(seconds: 4),
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }

  void _checksmartEntryI() {
    String penggunaId = _penggunaIdController.text.trim();
    String nama = _namaController.text.trim();
    String pakej = _pakejController.text.trim();
    String tarikhTamat = _tarikhController.text.trim();
    String emel = _emelController.text.trim();
    String noHp = _noHpController.text.trim();
    String dedagang = _dedagangController.text.trim();

    PenggunaModel user = PenggunaModel(
      penggunaid: penggunaId,
      nama: nama,
      pakej: pakej,
      tarikh: tarikhTamat,
      emel: emel,
      nohp: noHp,
      dedagang: dedagang,
    );
    setState(() {
      _list.add(user);
    });
  }

  Future<void> _exportListToExcel(List<PenggunaModel> dataList) async {
    final excel = Excel.createExcel();
    final sheet = excel['Status-Renew'];

    final headers = [
      'PENGGUNAID',
      'NAMA',
      'PAKEJ',
      'TARIKH EXPIRED',
      'EMEL',
      'NO H/P',
      'ONBOARD DEDAGANG'
    ];
    for (var i = 0; i < headers.length; i++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
          .value = headers[i];
    }

    for (var row = 0; row < dataList.length; row++) {
      final user = dataList[row];
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row + 1))
          .value = user.penggunaid;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row + 1))
          .value = user.nama;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row + 1))
          .value = user.pakej;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row + 1))
          .value = user.tarikh;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row + 1))
          .value = user.emel;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row + 1))
          .value = user.nohp;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: row + 1))
          .value = user.dedagang;
    }

    var fileBytes = excel.save(fileName: 'status-renew.xlsx');
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(80)),
      child: const Padding(
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        child: Text("List To Excel",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
            )),
      ),
    );
  }
}

class PenggunaModel {
  String penggunaid;
  String nama;
  String pakej;
  String tarikh;
  String emel;
  String nohp;
  String dedagang;

  PenggunaModel({
    required this.penggunaid,
    required this.nama,
    required this.pakej,
    required this.tarikh,
    required this.emel,
    required this.nohp,
    required this.dedagang,
  });
}

void main() {
  runApp(MaterialApp(
    home: ListToExcel(),
  ));
}
