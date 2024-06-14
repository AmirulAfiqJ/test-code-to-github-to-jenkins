import 'package:bizapptrack/ui/dataUser.dart';
import 'package:bizapptrack/ui/loadingWidget.dart';
import 'package:bizapptrack/viewmodel/expiringViewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:bizapptrack/viewmodel/status_viewmodel.dart';
import 'package:bizapptrack/ui/sideNav.dart'; 
import 'customAppBar.dart';

class Expiring extends StatelessWidget {
  final String username;
  Expiring({super.key, required this.username});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExpiringViewmodel(),
      child: Scaffold(
        key: _scaffoldKey,
        // backgroundColor: Colors.white,
        appBar: CustomAppBar(username: username, scaffoldKey: _scaffoldKey),
         body: Row(
          children: [
            SideDrawer(username: username), // Add the side navigation here
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Consumer<ExpiringViewmodel>(
                    builder: (context, model, child) {
                      return SingleChildScrollView(
                        child: Center(
                          child: Column(
                            children: [
                              const SizedBox(width: 20),
                              const Header(),
                              const SizedBox(height: 20),
                              _buildSearchSection(model, context),
                              const SizedBox(height: 20),
                              model.isLoading
                                  ? CircularProgressIndicator(color: Colors.red)
                                  : _buildUserDetailsSection(context, model),
                              if (!model.isLoading)
                                Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    _body2(context, constraints),
                                    const SizedBox(height: 20),
                                    _body3(context, constraints),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body2(BuildContext context, BoxConstraints constraints) {
    return context.read<StatusController>().call == false
        ? Consumer<StatusController>(
            builder: (context, provider, child) {
              String upgradeDate = provider.tarikhnaiktaraf;
              String endDate = provider.tarikhtamat;

              List<String> parts = upgradeDate.split(' ');
              List<String> parts2 = endDate.split(' ');

              String datePart = parts[0];
              String datePart2 = parts2[0];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 1.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 253, 221, 221),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Date Start', style: AppStyles.fixedTextStyle)), // tarikh naik taraf
                          DataColumn(label: Text('Date End', style: AppStyles.fixedTextStyle)), // tarikh tamat
                          DataColumn(label: Text('Last Login', style: AppStyles.fixedTextStyle)), // tarikh log masuk
                          DataColumn(label: Text('Last Order', style: AppStyles.fixedTextStyle)), // tarikh last order
                          DataColumn(label: Text('Payment', style: AppStyles.fixedTextStyle)), // payment
                          DataColumn(label: Text('No. Records', style: AppStyles.fixedTextStyle)), // rekod tempahan
                          DataColumn(label: Text('No. Orders', style: AppStyles.fixedTextStyle)), // bil tempahan
                          DataColumn(label: Text('No. Agents', style: AppStyles.fixedTextStyle)), // bil ejen
                          DataColumn(label: Text('Bizappay', style: AppStyles.fixedTextStyle)), // ada bizappay
                          DataColumn(label: Text('Business', style: AppStyles.fixedTextStyle)), // jenis syarikat
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text(datePart, style: AppStyles.fixedTextStyle)), // tarikhnaiktaraf
                            DataCell(Text(datePart2, style: AppStyles.fixedTextStyle)), // tarikhtamat
                            const DataCell(Text("-", style: AppStyles.fixedTextStyle)),
                            const DataCell(Text("-", style: AppStyles.fixedTextStyle)),
                            const DataCell(Text("-", style: AppStyles.fixedTextStyle)),
                            DataCell(Text(provider.rekodtempahan, style: AppStyles.fixedTextStyle)),
                            DataCell(Text(provider.biltempahan, style: AppStyles.fixedTextStyle)),
                            DataCell(Text(provider.bilEjen, style: AppStyles.fixedTextStyle)),
                            DataCell(Text(provider.bizappayacc, style: AppStyles.fixedTextStyle)),
                            DataCell(Text(provider.jenissyarikatname, style: AppStyles.fixedTextStyle)),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.4,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 253, 221, 221),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 5),
                        const Text('Senarai rekod 5 terakhir: ', style: AppStyles.fixedTextStyle),
                        const SizedBox(height: 5),
                        provider.callRekod == false
                            ? provider.listrekod.isEmpty
                                ? const Text(
                                    'Tiada Rekod',
                                    style: AppStyles.fixedTextStyle
                                    )
                                  
                                : Center(
                                    child:
                                        DataList(listrekod: provider.listrekod),
                                  )
                            : const GetLoad(text: "Load data record ..."),
                      ],
                    ),
                  ),
                ],
              );
            },
          )
        : const SizedBox();
  }

  Widget _body3(BuildContext context, BoxConstraints constraints) {
    final ExpiringViewmodel model =
        Provider.of<ExpiringViewmodel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 1.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 253, 221, 221),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Category', style: AppStyles.fixedTextStyle)),
                DataColumn(label: Text('Date Called', style: AppStyles.fixedTextStyle)),
                DataColumn(label: Text('PIC', style: AppStyles.fixedTextStyle)),
                DataColumn(label: Text('Number', style: AppStyles.fixedTextStyle)),
                DataColumn(label: Text('Call Status', style: AppStyles.fixedTextStyle)),
                DataColumn(label: Text('Feedback', style: AppStyles.fixedTextStyle)),
                DataColumn(label: Text('Note', style: AppStyles.fixedTextStyle)),
                DataColumn(label: Text('Action', style: AppStyles.fixedTextStyle)),
                DataColumn(label: Text('Follow Up', style: AppStyles.fixedTextStyle)),
              ],
              rows: [
                DataRow(cells: [
                  const DataCell(Text(" ", style: AppStyles.fixedTextStyle)),
                  const DataCell(Text(" ", style: AppStyles.fixedTextStyle)),
                  DataCell(Text(username, style: AppStyles.fixedTextStyle)),
                  DataCell(Text(model.selectedNumber, style: AppStyles.fixedTextStyle)),
                  DataCell(Text(model.selectedCallStatus, style: AppStyles.fixedTextStyle)),
                  DataCell(Text(model.selectedFeedback, style: AppStyles.fixedTextStyle)),
                  DataCell(Text(model.noteController.text, style: AppStyles.fixedTextStyle)),
                  DataCell(Text(model.selectedAction, style: AppStyles.fixedTextStyle)),
                  DataCell(Text(model.selectedFollowUp, style: AppStyles.fixedTextStyle)),
                ]),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSearchSection(ExpiringViewmodel model, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FormStatus(
          controller: model.usernameController,
          onSearch: () => model.performSearch(context),
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () => model.performSearch(context),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildUserDetailsSection(
    BuildContext context, ExpiringViewmodel model) {
    final statusModel = Provider.of<StatusController>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 80.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 253, 221, 221),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bizapp ID: ${statusModel.username}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Package: ${statusModel.roleid}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 50),
                  Text(
                    "Name: ${statusModel.nama}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Email: ${statusModel.emel}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "No. H/P: ${statusModel.nohp}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20),
          Container(
            width: 600,
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 253, 221, 221),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDropdown(
                  label: 'Number',
                  value: model.selectedNumber,
                  items: model.numberItems,
                  onChanged: model.setSelectedNumber,
                  context: context,
                ),
                _buildDropdown(
                  label: 'Call status',
                  value: model.selectedCallStatus,
                  items: model.callStatusItems,
                  onChanged: model.setSelectedCallStatus,
                  context: context,
                ),
                _buildDropdown(
                  label: 'Feedback',
                  value: model.selectedFeedback,
                  items: model.feedbackItems,
                  onChanged: model.setSelectedFeedback,
                  context: context,
                ),
                _buildDropdown(
                  label: 'Action',
                  value: model.selectedAction,
                  items: model.actionItems,
                  onChanged: model.setSelectedAction,
                  context: context,
                ),
                _buildDropdown(
                  label: 'Follow up',
                  value: model.selectedFollowUp,
                  items: model.followUpItems,
                  onChanged: model.setSelectedFollowUp,
                  context: context,
                ),
                Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Note: ', style: TextStyle(fontSize: 18, color: Colors.black)),
                  SizedBox(height: 10),
                  Container(
                    width: 400, // Set the desired width here
                    child: TextFormField(
                      controller: model.noteController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter note',
                        labelStyle: AppStyles.fixedTextStyle,
                      ),
                      style: TextStyle(color: const Color.fromARGB(255, 77, 77, 77)),
                      onFieldSubmitted: model.setNoteText,
                    ),
                  ),
                ],
              ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                      model.setNoteText(model.noteController.text);
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 125, 212, 98),
                      ),
                      child:
                          Text('Update', style: TextStyle(color: Colors.black)),
                    ),
                    ElevatedButton(
                      onPressed: model.clearSelections,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 109, 99),
                      ),
                      child:
                          Text('Clear', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String) onChanged,
    required BuildContext context,
  }) {
    Color textColor = Theme.of(context).brightness == Brightness.dark
      ? Colors.white
      : Colors.black;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('$label: ', style: TextStyle(fontSize: 18, color: Colors.black)),
        SizedBox(width: 10),
       DropdownButton<String>(
          value: value,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Color.fromARGB(255, 165, 165, 165)
                    : Color.fromARGB(255, 43, 43, 43),
              ),
            ),
          );
          }).toList(),
          onChanged: (String? newValue) {
            onChanged(newValue!);
          },
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
        "Expiring",
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class AppStyles {
  static const TextStyle fixedTextStyle = TextStyle(
    color: Color.fromARGB(255, 27, 27, 27), // or any fixed color you prefer
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
}
class FormStatus extends StatelessWidget {
  final TextEditingController controller;
  final Function() onSearch;
  const FormStatus(
      {super.key, required this.controller, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: TextFormField(
        style: const TextStyle(fontSize: 16, color: Colors.black),
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          filled: true,
          labelStyle: AppStyles.fixedTextStyle,
          labelText: 'Username',
          fillColor: Colors.white,
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear, color: Colors.red),
            onPressed: () {
              controller.clear();
            },
          ),
        ),
        onEditingComplete: onSearch,
      ),
    );
  }
}
import 'package:bizapptrack/ui/dataUser.dart';
import 'package:bizapptrack/ui/loadingWidget.dart';
import 'package:bizapptrack/viewmodel/expiringViewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bizapptrack/viewmodel/status_viewmodel.dart';
import 'package:bizapptrack/ui/sideNav.dart'; 
import 'customAppBar.dart';

class Expiring extends StatelessWidget {
  final String username;
  Expiring({super.key, required this.username});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExpiringViewmodel(),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: CustomAppBar(username: username, scaffoldKey: _scaffoldKey),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Consumer<ExpiringViewmodel>(
              builder: (context, model, child) {
                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Header(),
                        const SizedBox(height: 20),
                        _buildSearchSection(model, context),
                        const SizedBox(height: 20),
                        model.isLoading
                            ? CircularProgressIndicator(color: Colors.red)
                            : _buildUserDetailsSection(context, model),
                        if (!model.isLoading)
                          Column(
                            children: [
                              const SizedBox(height: 20),
                              _body2(context, constraints),
                              const SizedBox(height: 20),
                              _body3(context, constraints),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        drawer: SideDrawer(username: username),
      ),
    );
  }

  Widget _body2(BuildContext context, BoxConstraints constraints) {
    return context.read<StatusController>().call == false
        ? Consumer<StatusController>(
            builder: (context, provider, child) {
              String upgradeDate = provider.tarikhnaiktaraf;
              String endDate = provider.tarikhtamat;
              String logDate = provider.transactdate;

              List<String> parts = upgradeDate.split(' ');
              List<String> parts3 = logDate.split(' ');
              List<String> parts2 = endDate.split(' ');

              String datePart = parts[0];
              String datePart2 = parts2[0];
              String datePart3 = parts3[0];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Customer Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 1.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Date Start')), // tarikh naik taraf
                          DataColumn(label: Text('Date End')), // tarikh tamat
                          DataColumn(label: Text('Last Login')), // tarikh log masuk
                          DataColumn(label: Text('Last Order')), // tarikh last order
                          DataColumn(label: Text('Payment')), // payment
                          DataColumn(label: Text('No. Records')), // rekod tempahan
                          DataColumn(label: Text('No. Orders')), // bil tempahan
                          DataColumn(label: Text('No. Agents')), // bil ejen
                          DataColumn(label: Text('Bizappay')), // ada bizappay
                          DataColumn(label: Text('Business')), // jenis syarikat
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text(datePart)), // tarikhnaiktaraf
                            DataCell(Text(datePart2)), // tarikhtamat
                            DataCell(Text(provider.tarikhlogmasuk)), // tarikh log masuk
                            DataCell(Text(datePart3)), // tarikh last order
                            DataCell(Text(provider.typepayment)), // payment
                            DataCell(Text(provider.rekodtempahan)),
                            DataCell(Text(provider.biltempahan)),
                            DataCell(Text(provider.bilEjen)),
                            DataCell(Text(provider.bizappayacc)),
                            DataCell(Text(provider.jenissyarikatname)),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          )
        : const SizedBox();
  }

  Widget _body3(BuildContext context, BoxConstraints constraints) {
    final ExpiringViewmodel model =
        Provider.of<ExpiringViewmodel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Follow Up',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 1.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Category')),
                DataColumn(label: Text('Date Called')),
                DataColumn(label: Text('PIC')),
                DataColumn(label: Text('Number')),
                DataColumn(label: Text('Call Status')),
                DataColumn(label: Text('Feedback')),
                DataColumn(label: Text('Action')),
                DataColumn(label: Text('Follow Up')),
                DataColumn(label: Text('Note')),
              ],
              rows: [
                DataRow(cells: [
                  const DataCell(Text(" ")),
                  const DataCell(Text(" ")),
                  DataCell(Text(username)),
                  DataCell(Text(model.selectedNumber)),
                  DataCell(Text(model.selectedCallStatus)),
                  DataCell(Text(model.selectedFeedback)),
                  DataCell(Text(model.selectedAction)),
                  DataCell(Text(model.selectedFollowUp)),
                  DataCell(Text(model.noteController.text)),
                ]),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSearchSection(ExpiringViewmodel model, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FormStatus(
          controller: model.usernameController,
          onSearch: () => model.performSearch(context),
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () => model.performSearch(context),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildUserDetailsSection(
    BuildContext context, ExpiringViewmodel model) {
    final statusModel = Provider.of<StatusController>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(50),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bizapp ID: ${statusModel.username}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Package: ${statusModel.roleid}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 50),
                  Text(
                    "Name: ${statusModel.nama}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Email: ${statusModel.emel}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "No. H/P: ${statusModel.nohp}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 70),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDropdown(
                  label: 'Number',
                  value: model.selectedNumber,
                  items: model.numberItems,
                  onChanged: model.setSelectedNumber,
                ),
                _buildDropdown(
                  label: 'Call status',
                  value: model.selectedCallStatus,
                  items: model.callStatusItems,
                  onChanged: model.setSelectedCallStatus,
                ),
                _buildDropdown(
                  label: 'Feedback',
                  value: model.selectedFeedback,
                  items: model.feedbackItems,
                  onChanged: model.setSelectedFeedback,
                ),
                _buildDropdown(
                  label: 'Action',
                  value: model.selectedAction,
                  items: model.actionItems,
                  onChanged: model.setSelectedAction,
                ),
                _buildDropdown(
                  label: 'Follow up',
                  value: model.selectedFollowUp,
                  items: model.followUpItems,
                  onChanged: model.setSelectedFollowUp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Note: ', style: TextStyle(fontSize: 18)),
                    SizedBox(width: 15),
                    Expanded(
                      child: TextFormField(
                        controller: model.noteController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter note',
                        ),
                        onFieldSubmitted: model.setNoteText,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                      model.setNoteText(model.noteController.text);
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 125, 212, 98),
                      ),
                      child:
                          Text('Update', style: TextStyle(color: Colors.black)),
                    ),
                    ElevatedButton(
                      onPressed: model.clearSelections,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 109, 99),
                      ),
                      child:
                          Text('Clear', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('$label: ', style: TextStyle(fontSize: 18)),
        SizedBox(width: 10),
        DropdownButton<String>(
          value: value,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? newValue) {
            onChanged(newValue!);
          },
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
        "Expiring",
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class FormStatus extends StatelessWidget {
  final TextEditingController controller;
  final Function() onSearch;
  const FormStatus(
      {super.key, required this.controller, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: TextFormField(
        style: const TextStyle(fontSize: 16),
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          filled: true,
          labelStyle: const TextStyle(fontSize: 14),
          labelText: 'Username',
          fillColor: Colors.white,
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear, color: Colors.red),
            onPressed: () {
              controller.clear();
              Provider.of<StatusController>(context, listen: false).resetData();
            },
          ),
        ),
        onEditingComplete: onSearch,
      ),
    );
  }
}
