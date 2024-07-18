import 'package:bizapptrack/viewmodel/expiringViewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bizapptrack/viewmodel/status_viewmodel.dart';
import 'package:bizapptrack/utils/constant_widgets.dart';
import 'package:bizapptrack/ui/sideNav.dart';
import 'customAppBar.dart';

class Expiring extends StatefulWidget {
  Expiring({super.key});

  @override
  State<Expiring> createState() => _ExpiringState();
}

class _ExpiringState extends State<Expiring> {
  ExpiringViewmodel viewModel = ExpiringViewmodel();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ConstantWidgets constantWidgets = ConstantWidgets();

  @override
  void initState() {
    super.initState();
    viewModel.getPref(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExpiringViewmodel(),
      child: Scaffold(
        key: _scaffoldKey,
        // backgroundColor: Colors.white,
        appBar: CustomAppBar(username: viewModel.username, scaffoldKey: _scaffoldKey),
        body: Row(
          children: [
            SideDrawer(username: viewModel.username), // Add the side navigation here
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
                                  ? const CircularProgressIndicator(color: Colors.red)
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 10.0),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 1.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 253, 221, 221),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(
                              label: Text('Date Start',
                                  style: AppStyles
                                      .fixedTextStyle)), // tarikh naik taraf
                          DataColumn(
                              label: Text('Date End',
                                  style: AppStyles
                                      .fixedTextStyle)), // tarikh tamat
                          DataColumn(
                              label: Text('Last Order',
                                  style: AppStyles
                                      .fixedTextStyle)), // tarikh last order
                          DataColumn(
                              label: Text('Payment',
                                  style: AppStyles.fixedTextStyle)), // payment
                          DataColumn(
                              label: Text('No. Records',
                                  style: AppStyles
                                      .fixedTextStyle)), // rekod tempahan
                          DataColumn(
                              label: Text('No. Orders',
                                  style: AppStyles
                                      .fixedTextStyle)), // bil tempahan
                          DataColumn(
                              label: Text('No. Agents',
                                  style: AppStyles.fixedTextStyle)), // bil ejen
                          DataColumn(
                              label: Text('Bizappay',
                                  style: AppStyles
                                      .fixedTextStyle)), // ada bizappay
                          DataColumn(
                              label: Text('Business',
                                  style: AppStyles
                                      .fixedTextStyle)), // jenis syarikat
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text(datePart,
                                style: AppStyles
                                    .fixedTextStyle)), // tarikhnaiktaraf
                            DataCell(Text(datePart2,
                                style:
                                    AppStyles.fixedTextStyle)), // tarikhtamat
                            DataCell(Text(datePart3,
                                style: AppStyles.fixedTextStyle)),
                            DataCell(Text(provider.typepayment,
                                style: AppStyles.fixedTextStyle)),
                            DataCell(Text(provider.rekodtempahan,
                                style: AppStyles.fixedTextStyle)),
                            DataCell(Text(provider.biltempahan,
                                style: AppStyles.fixedTextStyle)),
                            DataCell(Text(provider.bilEjen,
                                style: AppStyles.fixedTextStyle)),
                            DataCell(Text(provider.bizappayacc,
                                style: AppStyles.fixedTextStyle)),
                            DataCell(Text(provider.jenissyarikatname,
                                style: AppStyles.fixedTextStyle)),
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
    final ExpiringViewmodel model = Provider.of<ExpiringViewmodel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 1.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 253, 221, 221),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(
                    label: Text('Category', style: AppStyles.fixedTextStyle)),
                DataColumn(
                    label:
                        Text('Date Called', style: AppStyles.fixedTextStyle)),
                DataColumn(label: Text('PIC', style: AppStyles.fixedTextStyle)),
                DataColumn(
                    label: Text('Number', style: AppStyles.fixedTextStyle)),
                DataColumn(
                    label:
                        Text('Call Status', style: AppStyles.fixedTextStyle)),
                DataColumn(
                    label: Text('Feedback', style: AppStyles.fixedTextStyle)),
                DataColumn(
                    label: Text('Note', style: AppStyles.fixedTextStyle)),
                DataColumn(
                    label: Text('Action', style: AppStyles.fixedTextStyle)),
                DataColumn(
                    label: Text('Follow Up', style: AppStyles.fixedTextStyle)),
              ],
              rows: [
                DataRow(cells: [
                  const DataCell(Text('Expiring', style: AppStyles.fixedTextStyle)),
                  DataCell(Text(constantWidgets.date(), style: AppStyles.fixedTextStyle)),
                  DataCell(Text(viewModel.username, style: AppStyles.fixedTextStyle)),
                  DataCell(Text(model.selectedNumber,
                      style: AppStyles.fixedTextStyle)),
                  DataCell(Text(model.selectedCallStatus,
                      style: AppStyles.fixedTextStyle)),
                  DataCell(Text(model.selectedFeedback,
                      style: AppStyles.fixedTextStyle)),
                  DataCell(Text(model.noteController.text,
                      style: AppStyles.fixedTextStyle)),
                  DataCell(Text(model.selectedAction,
                      style: AppStyles.fixedTextStyle)),
                  DataCell(Text(model.selectedFollowUp,
                      style: AppStyles.fixedTextStyle)),
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
          icon: const Icon(Icons.search),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 80.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 253, 221, 221),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bizapp ID: ${statusModel.username}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Package: ${statusModel.roleid}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    "Name: ${statusModel.nama}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 15),
                  SelectableText(
                    "Email: ${statusModel.emel}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 15),
                  SelectableText(
                    "No. H/P: ${statusModel.nohp}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          Container(
            width: 600,
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 253, 221, 221),
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
                    const Text('Note: ',
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    const SizedBox(height: 10),
                    Container(
                      width: 400, // Set the desired width here
                      child: TextFormField(
                        controller: model.noteController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter note',
                          labelStyle: AppStyles.fixedTextStyle,
                        ),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 77, 77, 77)),
                        onFieldSubmitted: model.setNoteText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        model.setNoteText(model.noteController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 125, 212, 98),
                      ),
                      child:
                          const Text('Update', style: TextStyle(color: Colors.black)),
                    ),
                    ElevatedButton(
                      onPressed: model.clearSelections,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 109, 99),
                      ),
                      child:
                          const Text('Clear', style: TextStyle(color: Colors.black)),
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
        Text('$label: ', style: const TextStyle(fontSize: 18, color: Colors.black)),
        const SizedBox(width: 10),
        DropdownButton<String>(
          value: value,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color.fromARGB(255, 165, 165, 165)
                      : const Color.fromARGB(255, 43, 43, 43),
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
    return const Padding(
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
