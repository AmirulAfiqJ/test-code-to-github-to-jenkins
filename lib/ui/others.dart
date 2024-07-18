import 'package:bizapptrack/ui/sideNav.dart';
import 'package:bizapptrack/viewmodel/status_viewmodel.dart';
import 'package:bizapptrack/utils/constant_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'customAppBar.dart';

class Others extends StatefulWidget {
  Others({super.key});

  @override
  State<Others> createState() => _OthersState();
}

class _OthersState extends State<Others> {
  StatusController viewModel = StatusController();

  TextEditingController usernameController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController noteController =
      TextEditingController(); // Controller for the note text field
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ConstantWidgets constantWidgets = ConstantWidgets();

  // Add state variables for dropdowns
  String _selectedNumber = 'Select';
  String _selectedCallStatus = 'Select Status';
  String _selectedFollowUp = 'Select Follow Up';

  @override
  void initState() {
    super.initState();
    viewModel.getPref(context);
  }

  void _performSearch() async {
    StatusController model =
        Provider.of<StatusController>(context, listen: false);
    setState(() {
      model.call = true;
    });
    try {
      await model.loginServices(context, userid: usernameController.text);
      await model.profile(context, pid: model.pid);
    } finally {
      setState(() {
        model.call = false;
      });
    }
  }

  void _clearSelections() {
    setState(() {
      _selectedNumber = 'Select';
      _selectedCallStatus = 'Select Status';
      _selectedFollowUp = 'Select Follow Up';

      purposeController.clear();
      feedbackController.clear();
      reasonController.clear();
      noteController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: Colors.white,
      appBar:
          CustomAppBar(username: viewModel.username, scaffoldKey: _scaffoldKey),
      body: Row(
        children: [
          SideDrawer(username: viewModel.username),
      Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) => Consumer<StatusController>(
          builder: (context, model, child) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(width: 20),
                    const Header(),
                    const SizedBox(height: 20),
                    _buildSearchSection(),
                    const SizedBox(height: 20),
                    model.call
                        ? const CircularProgressIndicator(color: Colors.red)
                        : _buildUserDetailsSection(model),
                    const SizedBox(height: 20),
                    _body2(context, constraints),
                    const SizedBox(height: 20),
                    model.call ? const SizedBox.shrink() : _body3(context, constraints),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      ),
    ],
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
              List<String> parts2 = endDate.split(' ');
              List<String> parts3 = logDate.split(' ');

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
                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 1.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 226, 226, 226),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(
                              label: Text('Date Start', style: AppStyles.fixedTextStyle)), // tarikh naik taraf
                          DataColumn(
                            label:Text('Date End', style: AppStyles.fixedTextStyle)), // tarikh tamat
                          DataColumn(
                              label: Text('Last Order', style: AppStyles.fixedTextStyle)), // tarikh last order
                          DataColumn(
                            label: Text('Payment', style: AppStyles.fixedTextStyle)), // payment
                          DataColumn(
                              label: Text('No. Records', style: AppStyles.fixedTextStyle)), // rekod tempahan
                          DataColumn(
                            label: Text('No. Orders', style: AppStyles.fixedTextStyle)), // bil tempahan
                          DataColumn(
                            label: Text('No. Agents', style: AppStyles.fixedTextStyle)), // bil ejen
                          DataColumn(
                            label: Text('Bizappay', style: AppStyles.fixedTextStyle)), // ada bizappay
                          DataColumn(
                            label: Text('Business', style: AppStyles.fixedTextStyle)), // jenis syarikat
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text(datePart, style: AppStyles.fixedTextStyle)), // tarikhnaiktaraf
                            DataCell(Text(datePart2, style: AppStyles.fixedTextStyle)), // tarikhtamat
                            DataCell(Text(datePart3, style: AppStyles.fixedTextStyle)), // tarikh last order
                            DataCell(Text(provider.typepayment, style: AppStyles.fixedTextStyle)), // payment
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
                ],
              );
            },
          )
        : const SizedBox();
  }

  Widget _body3(BuildContext context, BoxConstraints constraints) {
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
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 1.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 226, 226, 226),
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
                DataColumn(label: Text('Purpose', style: AppStyles.fixedTextStyle)),
                DataColumn(label: Text('Feedback', style: AppStyles.fixedTextStyle)),
                DataColumn(label: Text('Reason', style: AppStyles.fixedTextStyle)),
                DataColumn(label: Text('Note', style: AppStyles.fixedTextStyle)),
                DataColumn(label: Text('Follow Up', style: AppStyles.fixedTextStyle)),
              ],
              rows: [
                DataRow(cells: [
                  const DataCell(Text('Others', style: AppStyles.fixedTextStyle)),
                  DataCell(Text(constantWidgets.date(), style: AppStyles.fixedTextStyle)),
                  DataCell(Text(viewModel.username, style: AppStyles.fixedTextStyle)),
                  DataCell(Text(_selectedNumber, style: AppStyles.fixedTextStyle)),
                  DataCell(Text(_selectedCallStatus, style: AppStyles.fixedTextStyle)),
                  DataCell(Text(purposeController.text, style: AppStyles.fixedTextStyle)),
                  DataCell(Text(feedbackController.text, style: AppStyles.fixedTextStyle)),
                  DataCell(Text(reasonController.text, style: AppStyles.fixedTextStyle)),
                  DataCell(Text(noteController.text, style: AppStyles.fixedTextStyle)),
                  DataCell(Text(_selectedFollowUp, style: AppStyles.fixedTextStyle)),
                ]),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSearchSection() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FormStatus(
          controller: usernameController,
          onSearch: _performSearch,
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: _performSearch,
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildUserDetailsSection(StatusController model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical:30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 135.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 226, 226, 226),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bizapp ID: " + "${model.username}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Package: ${model.roleid}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    "Name: ${model.nama}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 15),
                  SelectableText(
                    "Email: ${model.emel}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 15),
                  SelectableText(
                    "No. H/P: ${model.nohp}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          Container(
            width: 600,
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 226, 226, 226),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Number: ',
                      style: TextStyle(
                        fontSize: 18 ,
                        color: Colors.black
                      ),
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: _selectedNumber,
                      items: <String>[
                        'Select',
                        'BualAsia',
                        'Office HP',
                        'Personal HP'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color.fromARGB(255, 145, 144, 144)
                        : Colors.black,
                  ),
                ),
              );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedNumber = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Call status: ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                      ),
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: _selectedCallStatus,
                      items: <String>[
                        'Select Status',
                        'Did Not Call',
                        'Picked Up',
                        'Ringing',
                        'Not in service',
                        'Wrong Number',
                        'Changed PIC'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color.fromARGB(255, 145, 144, 144)
                        : Colors.black,
                  ),
                ),
              );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCallStatus = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Purpose: ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: purposeController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter purpose',
                          labelStyle: AppStyles.fixedTextStyle,
                        ),
                        style: const TextStyle(color: Color.fromARGB(255, 77, 77, 77)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Feedback: ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextFormField(
                        controller: feedbackController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter feedback',
                          labelStyle: AppStyles.fixedTextStyle,
                        ),
                        style: const TextStyle(color: Color.fromARGB(255, 77, 77, 77)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Reasoning: ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: reasonController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter reason',
                          labelStyle: AppStyles.fixedTextStyle,
                        ),
                        style: const TextStyle(color: Color.fromARGB(255, 77, 77, 77)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Note: ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: noteController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter note',
                          labelStyle: AppStyles.fixedTextStyle,
                        ),
                        style: const TextStyle(color: Color.fromARGB(255, 77, 77, 77)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Follow up: ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                      ),
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: _selectedFollowUp,
                      items: <String>[
                        'Select Follow Up',
                        'Irrelevent',
                        'Informed Management',
                        'WhatsApp',
                        'Emailed',
                        'WhatsApp & Emailed',
                        'Joined 101',
                        'Registered A-Z',
                        'Subscribed Dedicated Support',
                        'Subscribed EjenPro',
                        'Upgrade Package'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color.fromARGB(255, 145, 144, 144)
                        : Colors.black,
                  ),
                ),
              );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedFollowUp = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          String purpose = purposeController.text;
                          String feedback = feedbackController.text;
                          String reason = reasonController.text;
                          String note = noteController.text;

                          print('Purpose: $purpose');
                          print('Feedback: $feedback');
                          print('Reason: $reason');
                          print('Note: $note');
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const  Color.fromARGB(255, 125, 212, 98),
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _clearSelections,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 109, 99),
                      ),
                      child: const  Text(
                        'Clear',
                        style: TextStyle(color: Colors.black),
                      ),
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
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
        "Others",
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
