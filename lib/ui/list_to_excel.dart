import 'package:bizapptrack/ui/button.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ListToExcel extends StatefulWidget {
  const ListToExcel({super.key});

  @override
  State<ListToExcel> createState() => _ListToExcelState();
}

class _ListToExcelState extends State<ListToExcel> {

  final List<PenggunaModel> _list = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _list.clear();
      _aa.clear();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f8ff),
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=> Navigator.pop(context),
          icon: const Icon(Icons.chevron_left),
        ),
        backgroundColor: Colors.transparent,
        title: const Text("List to Excel", style: TextStyle(
            color: Colors.black87, fontSize: 16
        ),),
      ),
      body: _body(),
    );
  }

  Widget _body(){
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _form(),

              const SizedBox(width: 20),

              /// button clear list
              BizappButton(
                  color: Colors.grey,
                  title: "Clear List",
                  tapCallback: (){
                    setState(() {
                      _list.clear();
                      _aa.clear();
                      _controller.clear();
                    });
                  }
              ),

            ],
          ),
          const SizedBox(height: 10),

          const Text('1. Masukkan seberapa banyak data. Ikut seperti format di atas'),
          const Text('2. Tekan Export to Excel'),

          const SizedBox(height: 20),
          _button(),

          _listname(),

          const SizedBox(height: 50),

        ],
      ),
    );
  }

  final TextEditingController _controller = TextEditingController();
  final String _col1 = "PENGGUNAID";
  final String _col2 = "NAMA";
  final String _col3 = "PAKEJ";
  final String _col4 = "TARIKH EXPIRED";
  final String _col5 = "EMEL";
  final String _col6 = "NO H/P";
  final String _col7 = "ONBOARD DEDAGANG";

  final dataList = [];

  Widget _form(){
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * .6,
      child: TextField(
        maxLines: 10,
        controller: _controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Masukkan data seperti:\n\n'
                    'PENGGUNAID : BLINGRECIPE\n'
                    'NAMA : SYAZA NUR IYLIA BINTI ZULKIFLI\n'
                    'PAKEJ : SUPERB\n'
                    'TARIKH EXPIRED : 22/08/2023\n'
                    'EMEL : admin@blingrecipe.com\n'
                    'NO H/P : 0143467400\n'
                    'ONBOARD DEDAGANG : YES\n'
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> _aa = [];
  Widget _button(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        /// button enter
        BizappButton(
            color: Colors.lightBlueAccent,
            title: "Enter",
            tapCallback: (){
              if(_controller.text.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(_popup("Sila masukkan data"));
              }
              else{
                _checksmartEntryI();
                // _check2();
              }
            }
        ),
        const SizedBox(width: 20),

        const SizedBox(width: 20),

        /// button export to excel
        BizappButton(
            color: Colors.green,
            title: "Export to Excel",
            tapCallback: (){

              if(_list.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(_popup("Tiada data. Masukkan data"));
              }
              else{
                _aa.clear();
                _list.map((e) {

                  _aa.add({_col1: e.penggunaid, _col2: e.nama, _col3: e.pakej, _col4: e.tarikh, _col5: e.emel, _col6: e.nohp, _col7: e.dedagang});

                }).toList();

                _exportListToExcel(_aa).then((_) {
                  debugPrint('Excel file exported successfully');
                  ScaffoldMessenger.of(context).showSnackBar(_popup("Excel file exported successfully"));
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(_popup("Error exporting Excel file: $error"));
                });
              }

            }
        ),
      ],
    );
  }

  Widget _listname(){
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _list.length,
        itemBuilder: (context, i)=>
            ListTile(
              leading: Text("${i+1}. ", style: const TextStyle(
                fontSize: 16
              ),),
              trailing: MaterialButton(
                color: Colors.red,
                onPressed: (){
                  setState(() {
                    _list.removeAt(i);
                  });
                },
                child: const Text('Remove', style: TextStyle(
                  color: Colors.white
                ),),
              ),
              title: Text("${_list[i].penggunaid}, ${_list[i].nama}, ${_list[i].pakej}, ${_list[i].tarikh}, ${_list[i].emel}, ${_list[i].nohp},  ${_list[i].dedagang}",
                style: const TextStyle(
                color: Colors.black
              ),),
            )
    );
  }

  SnackBar _popup(String text){
    return SnackBar(
      onVisible: (){
        HapticFeedback.vibrate().timeout(const Duration(milliseconds: 1500));
        HapticFeedback.heavyImpact();
      },
      duration: const Duration(seconds: 4),
      behavior: SnackBarBehavior.floating,
      content: Text(text, style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18, color: Colors.white,
        //fontWeight: FontWeight.bold
      )),
    );
  }

  int a = 0;
  List<String> userStrings = [];

  _checksmartEntryI(){

    for (String userString in _controller.text.split('\n\n\n')) {

      List<String> lines = userString.split('\n');
      String penggunaId = lines[0].split(' : ')[1].trim();
      String nama = lines[1].split(' : ')[1].trim();
      String pakej = lines[2].split(' : ')[1].trim();
      String tarikhExpired = lines[3].split(' : ')[1].trim();
      String emel = lines[4].split(' : ')[1].trim();
      String noHp = lines[5].split(' : ')[1].trim();
      String dedagang = lines[6].split(' : ')[1].trim();

      PenggunaModel user = PenggunaModel(
        penggunaid: penggunaId,
        nama: nama,
        pakej: pakej,
        tarikh: tarikhExpired,
        emel: emel,
        nohp: noHp,
        dedagang: dedagang
      );
      setState(() {
        _list.add(user);
      });
    }

  }

  /// to export list to excel
  Future<void> _exportListToExcel(List<Map<String, dynamic>> dataList) async {
    final excel = Excel.createExcel();
    final sheet = excel['Status-Renew'];

    /// Create headers for your Excel sheet
    final headers = [_col1, _col2, _col3, _col4, _col5, _col6, _col7];
    for (var i = 0; i < headers.length; i++) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).value = headers[i];
    }

    /// Populate the Excel sheet with data from your list
    for (var row = 0; row < dataList.length; row++) {
      final rowData = dataList[row];
      for (var col = 0; col < headers.length; col++) {
        final header = headers[col];
        final value = rowData[header];
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row + 1)).value = value;
      }
    }

    /// Save the Excel file
    var fileBytes = excel.save(fileName: 'status-renew.xlsx');
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
