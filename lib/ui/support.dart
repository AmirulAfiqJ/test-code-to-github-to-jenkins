import 'package:bizapptrack/ui/dataUser.dart';
import 'package:bizapptrack/ui/loadingWidget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bizapptrack/ui/sideNav.dart';
import 'package:bizapptrack/viewmodel/status_viewmodel.dart';
import 'package:bizapptrack/viewmodel/support_viewmodel.dart';
import 'customAppBar.dart';

class SupportPage extends StatefulWidget {
  final String username;
  SupportPage({required this.username});
  //const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  SupportViewModel viewModel = SupportViewModel();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  bool _showScrollToTopButton = false;

  void dispose() {
    viewModel.sourceController.dispose();
    viewModel.descController.dispose();
    viewModel.levelController.dispose();
    viewModel.firstResponseController.dispose();
    viewModel.departmentController.dispose();
    viewModel.picController.dispose();
    viewModel.noteController.dispose();
    _horizontalScrollController.dispose();
    horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
  }

  void _performSearch() async {
    StatusController model =
        Provider.of<StatusController>(context, listen: false);
    setState(() {
      model.call = true;
    });
    try {
      await model.loginServices(context,
          userid: viewModel.usernameController.text);
      await model.profile(context, pid: model.pid);
      await model.statushopee(context, pid: model.pid);
      await model.statustiktok(context, pid: model.pid);
      await model.statusWsapme(context, pid: model.pid);
      await model.bizappPage(context, pid: model.pid, hqpid: '');
    } finally {
      setState(() {
        model.call = false;
      });
    }
  }

  void _clearSelections() {
    setState(() {
      // do to every field
      viewModel.clearAllCheckboxes();
      viewModel.sourceController.clear();
      viewModel.descController.clear();
      viewModel.levelController.clear();
      viewModel.firstResponseController.clear();
      viewModel.departmentController.clear();
      viewModel.picController.clear();
      viewModel.noteController.clear();
    });
  }

  void _scrollListener() {
    setState(() {
      _showScrollToTopButton = _verticalScrollController.offset >= 200;
    });
  }

  void _scrollToTop() {
    _verticalScrollController.animateTo(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  late FormList selectedSource;
  late FormList selectedLevel;
  late FormList selectedInitial;
  late FormList selectedDepartment;
  late FormList selectedPIC;

  @override
  void initState() {
    super.initState();
    selectedSource = viewModel.sourceList.first;
    selectedLevel = viewModel.levelList.first;
    selectedInitial = viewModel.firstResponseList.first;
    selectedDepartment = viewModel.departmentList.first;
    selectedPIC = viewModel.picList.first;
    _verticalScrollController.addListener(_scrollListener);
  }

  List<String> selectedMediumValues = [];
  List<String> selectedProductValues = [];
  List<String> selectedIssueValues = [];
  List<String> selectedFollowUpValues = [];

  void handleCheckboxChanges(bool value, int index, List<CheckboxItem> items) {
    setState(() {
      items[index].value = value;
    });
  }

  List<String> getSelectedCheckboxValues(List<CheckboxItem> items) {
    return items.where((item) => item.value).map((item) => item.name).toList();
  }

  void _updateSelectedValues() {
    setState(() {
      selectedMediumValues =
          getSelectedCheckboxValues(viewModel.mediumCheckbox);
      selectedProductValues =
          getSelectedCheckboxValues(viewModel.productCheckbox);
      selectedIssueValues = getSelectedCheckboxValues(viewModel.issueCheckbox);
      selectedFollowUpValues =
          getSelectedCheckboxValues(viewModel.followUpCheckbox);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar:
          CustomAppBar(username: widget.username, scaffoldKey: _scaffoldKey),
      body: LayoutBuilder(
        builder: (context, constraints) => Consumer<StatusController>(
          builder: (context, model, child) {
            return SingleChildScrollView(
              controller: _verticalScrollController,
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Header(),
                    const SizedBox(height: 20),
                    _buildSearchSection(),
                    const SizedBox(height: 20),
                    model.call
                        ? CircularProgressIndicator()
                        : _buildUserDetailsSection(model),
                    _buildForm(viewModel),
                    _buildUpdateClearButton(),
                    const SizedBox(height: 20),
                    _body2(context, constraints),
                    const SizedBox(height: 20),
                    model.call
                        ? const SizedBox.shrink()
                        : _body3(context, constraints),
                    const SizedBox(height: 20),
                    model.call
                        ? const SizedBox.shrink()
                        : _body4(context, constraints, viewModel),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      drawer: SideDrawer(username: widget.username),
      floatingActionButton: Visibility(
        visible: _showScrollToTopButton,
        child: FloatingActionButton(
          onPressed: _scrollToTop,
          child: Icon(Icons.arrow_upward),
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
                        maxWidth: MediaQuery.of(context).size.width * 0.9),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Scrollbar(
                      controller: _horizontalScrollController,
                      thumbVisibility: false,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: _horizontalScrollController,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Bizapp ID')), // username
                            DataColumn(label: Text('Name')), // nama
                            DataColumn(label: Text('Email')), // emel
                            DataColumn(label: Text('No. H/P')), // no hp
                            DataColumn(label: Text('Package')), // pakej
                            DataColumn(label: Text('Date Start')), // tarikh naik taraf
                            DataColumn(label: Text('Date End')), // tarikh tamat
                            DataColumn(label: Text('Last Login')), // tarikh log masuk
                            DataColumn(label: Text('Last Order')), // tarikh last order
                            DataColumn(label: Text('Payment')), // payment
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text(provider.username)), // username
                              DataCell(Text(provider.nama)), // nama
                              DataCell(Text(provider.emel)), // emel
                              DataCell(Text(provider.nohp)), // no hp
                              DataCell(Text(provider.roleid)), // pakej
                              DataCell(Text(datePart)), // tarikhnaiktaraf
                              DataCell(Text(datePart2)), // tarikhtamat
                              DataCell(Text(provider.tarikhlogmasuk)), // tarikh log masuk
                              DataCell(Text(datePart3)), // tarikh last order
                              DataCell(Text(provider.typepayment)), // payment
                            ]),
                          ],
                        ),
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
    return context.read<StatusController>().call == false
        ? Consumer<StatusController>(
            builder: (context, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.9),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(
                              label: Text('No. Records')), // rekod tempahan
                          DataColumn(label: Text('No. Orders')), // bil tempahan
                          DataColumn(label: Text('No. Agents')), // bil ejen
                          DataColumn(label: Text('Bizappay')), // ada bizappay
                          DataColumn(label: Text('Business')), // jenis syarikat
                          DataColumn(label: Text('Bizappshop')),
                          DataColumn(label: Text('Bizappage')),
                          DataColumn(label: Text('Woo-Commerce')),
                          DataColumn(label: Text('Wsapme')),
                          DataColumn(label: Text('Shopee')),
                          DataColumn(label: Text('Tiktok')),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text(provider.rekodtempahan)),
                            DataCell(Text(provider.biltempahan)),
                            DataCell(Text(provider.bilEjen)),
                            DataCell(Text(provider.bizappayacc)),
                            DataCell(Text(provider.jenissyarikatname)),
                            const DataCell(Text("-")), // bizappshop
                            DataCell(Text(provider.bizappage)), // bizappage
                            DataCell(Text(provider.woo)), // woo-commerce
                            DataCell(Text(provider.wsapme)), // wsapme
                            DataCell(Text(provider.statusShopee)), // shopee
                            DataCell(Text(provider.statusTiktok)), // tiktok
                          ]),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          )
        : SizedBox();
  }

  Widget _body4(BuildContext context, BoxConstraints constraints,
      SupportViewModel viewModel) {
    String formatDate(DateTime date) {
      String year = date.year.toString();
      String month = date.month.toString().padLeft(2, '0');
      String day = date.day.toString().padLeft(2, '0');
      String hour =
          (date.hour > 12) ? (date.hour - 12).toString() : date.hour.toString();
      if (hour == '0') hour = '12'; // Adjust 0 to 12 for midnight
      String minute = date.minute.toString().padLeft(2, '0');
      String period = (date.hour >= 12) ? 'PM' : 'AM';
      return '$day/$month/$year $hour:$minute $period';
    }

    DateTime now = DateTime.now();
    String formattedDate = formatDate(now);

    List<String> parts = formattedDate.split(' ');

    String date = parts[0];

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
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            // minHeight: MediaQuery.of(context).size.height * 0.3,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Scrollbar(
            controller: horizontalScrollController,
            thumbVisibility: false,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: horizontalScrollController,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Key In')),
                  DataColumn(label: Text('Source')),
                  DataColumn(label: Text('Medium')),
                  DataColumn(label: Text('Product')),
                  DataColumn(label: Text('Issue')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Level')),
                  DataColumn(label: Text('First Response')),
                  DataColumn(label: Text('Department')),
                  DataColumn(label: Text('PIC')),
                  DataColumn(label: Text('Follow Up')),
                  DataColumn(label: Text('Note')),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text(date)), // date today
                    DataCell(Text(widget.username)), // key in
                    DataCell(Text(selectedSource.value)), // source
                    DataCell(Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: selectedMediumValues
                          .map((value) => Text(value))
                          .toList(),
                    )), // medium (checkbox)
                    DataCell(Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: selectedProductValues
                          .map((value) => Text(value))
                          .toList(),
                    )), // product (checkbox)
                    DataCell(Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: selectedIssueValues
                          .map((value) => Text(value))
                          .toList(),
                    )), // issue (checkbox)
                    DataCell(
                        Text(viewModel.descController.text)), // description
                    DataCell(Text(selectedLevel.value)), // level
                    DataCell(Text(selectedInitial.value)), // first response
                    DataCell(Text(selectedDepartment.value)), // department
                    DataCell(Text(selectedPIC.value)), // pic
                    DataCell(Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: selectedFollowUpValues
                          .map((value) => Text(value))
                          .toList(),
                    )), // follow up (checkbox)
                    DataCell(Text(viewModel.noteController.text)), // note
                  ]),
                ],
              ),
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
          controller: viewModel.usernameController,
          onSearch: _performSearch,
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: _performSearch,
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildUserDetailsSection(StatusController model) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 10.0),
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
                    "Bizapp ID: ${model.username}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Package: ${model.roleid}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 50),
                  Text(
                    "Name: ${model.nama}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Email: ${model.emel}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "No. H/P: ${model.nohp}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 70),
        ],
      ),
    );
  }

  Widget _buildForm(SupportViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildDropdown(
            label: 'Source',
            value: selectedSource,
            items: viewModel.sourceList,
            width: 60,
            onChanged: (FormList? newValue) {
              setState(() {
                selectedSource = newValue!; // Update selectedSource
                viewModel.sourceController.text =
                    newValue.value; // Update the controller
              });
            },
          ),
          _buildCheckbox(
              label: 'Medium',
              items: viewModel.mediumCheckbox,
              width: 30,
              onChanged: (value, index) {
                handleCheckboxChanges(value, index, viewModel.mediumCheckbox);
              }),
          _buildCheckbox(
              label: 'Product',
              items: viewModel.productCheckbox,
              width: 32,
              onChanged: (value, index) {
                handleCheckboxChanges(value, index, viewModel.productCheckbox);
              }),
          _buildCheckbox(
              label: 'Issue',
              items: viewModel.issueCheckbox,
              width: 51,
              onChanged: (value, index) {
                handleCheckboxChanges(value, index, viewModel.issueCheckbox);
              }),
          _buildText(
              label: 'Description', controller: viewModel.descController),
          _buildFilePicker(),
          _buildDropdown(
            label: 'Level',
            value: selectedLevel,
            items: viewModel.levelList,
            width: 70,
            onChanged: (FormList? newValue) {
              setState(() {
                selectedLevel = newValue!;
                viewModel.levelController.text = newValue.value;
              });
            },
          ),
          _buildDropdown(
            label: 'Initial',
            value: selectedInitial,
            items: viewModel.firstResponseList,
            width: 70,
            onChanged: (FormList? newValue) {
              setState(() {
                selectedInitial = newValue!;
                viewModel.firstResponseController.text = newValue.value;
              });
            },
          ),
          _buildDropdown(
            label: 'Department',
            value: selectedDepartment,
            items: viewModel.departmentList,
            width: 20,
            onChanged: (FormList? newValue) {
              setState(() {
                selectedDepartment = newValue!;
                viewModel.departmentController.text = newValue.value;
              });
            },
          ),
          _buildDropdown(
            label: 'PIC',
            value: selectedPIC,
            items: viewModel.picList,
            width: 87,
            onChanged: (FormList? newValue) {
              setState(() {
                selectedPIC = newValue!;
                viewModel.picController.text = newValue.value;
              });
            },
          ),
          _buildCheckbox(
              label: 'Follow Up',
              items: viewModel.followUpCheckbox,
              width: 16,
              onChanged: (value, index) {
                handleCheckboxChanges(value, index, viewModel.followUpCheckbox);
              }),
          _buildText(label: 'Note', controller: viewModel.noteController),
        ],
      ),
    );
  }

  Widget _buildFilePicker() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Attachment: ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: _pickFile,
                icon: Icon(Icons.attach_file,
                    color: Colors.white), // Change icon color here
                label: Text(
                  'Insert file',
                  style:
                      TextStyle(color: Colors.white), // Change text color here
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(
                      255, 0, 0, 0), // Change text color when pressed here
                  minimumSize: Size(150, 50), // Minimum button size
                ),
              ),
              if (_fileName != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Selected file: $_fileName',
                    style: TextStyle(
                        color: Colors.black), // Change text color here
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  String? _fileName;
  String? _filePath;
  double _fileSizeLimit = 10 * 1024 * 1024; // 10 MB

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      if (file.size <= _fileSizeLimit) {
        setState(() {
          _fileName = file.name;
          _filePath = file.path;
        });
        // You can use the file as needed. For example, upload it to a server.
      } else {
        // Show a message if the file exceeds the size limit
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('File Size Limit Exceeded'),
            content: Text('Please select a file smaller than 10 MB.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  Widget _buildCheckbox({
    required String label,
    required List<CheckboxItem> items,
    required width,
    required void Function(bool, int) onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column for the label text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$label: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
            ],
          ),
          SizedBox(width: width),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Generate the checkboxes in a 3 by 3 layout
                for (int i = 0; i < items.length; i += 3)
                  Row(
                    children: [
                      for (int j = i; j < i + 3 && j < items.length; j++)
                        Expanded(
                          child: CheckboxListTile(
                            title: Text(items[j].name),
                            value: items[j].value,
                            onChanged: (bool? value) {
                              if (value != null) {
                                onChanged(value, j);
                              }
                            },
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

  Widget _buildDropdown({
    required String label,
    required FormList value,
    required List<FormList> items,
    required double width,
    required void Function(FormList) onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '$label: ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: width),
              DropdownButton<FormList>(
                value: value,
                items: items.map((FormList item) {
                  return DropdownMenuItem<FormList>(
                    value: item,
                    child: Text(item.name),
                  );
                }).toList(),
                onChanged: (FormList? newValue) {
                  if (newValue != null) {
                    onChanged(newValue);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildText({
    required String label,
    required TextEditingController controller,
    int maxLines = 2,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: maxLines,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateClearButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 500.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: _updateSelectedValues,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 125, 212, 98),
              minimumSize: Size(150, 50),
            ),
            child: Text(
              'Update',
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(width: 20),
          ElevatedButton(
            onPressed: _clearSelections,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 255, 109, 99),
              minimumSize: Size(150, 50),
            ),
            child: Text(
              'Clear',
              style: TextStyle(color: Colors.black),
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
        "Support",
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
