import 'package:bizapptrack/ui/dataUser.dart';
import 'package:bizapptrack/ui/loadingWidget.dart';
import 'package:bizapptrack/utils/constant_widgets.dart';
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

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  SupportViewModel viewModel = SupportViewModel();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController body2ScrollController = ScrollController();
  final ScrollController body4ScrollController = ScrollController();
  final ScrollController body3ScrollbarController = ScrollController();

  void dispose() {
    viewModel.sourceController.dispose();
    viewModel.descController.dispose();
    viewModel.levelController.dispose();
    viewModel.firstResponseController.dispose();
    viewModel.departmentController.dispose();
    viewModel.picController.dispose();
    viewModel.noteController.dispose();
    body2ScrollController.dispose();
    body4ScrollController.dispose();
    body3ScrollbarController.dispose();
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
      viewModel.clearAllCheckboxes();
      clearSelections();
    });
  }

  late FormList selectedSource;
  late FormList selectedLevel;
  late FormList selectedInitial;
  late FormList selectedDepartment;
  late FormList selectedPIC;
  final ConstantWidgets constantWidgets = ConstantWidgets();

  @override
  void initState() {
    super.initState();
    selectedSource = viewModel.sourceList.first;
    selectedLevel = viewModel.levelList.first;
    selectedInitial = viewModel.firstResponseList.first;
    selectedDepartment = viewModel.departmentList.first;
    selectedPIC = viewModel.picList.first;
  }

  void clearSelections() {
    selectedSource = viewModel.sourceList.first;
    selectedLevel = viewModel.levelList.first;
    selectedInitial = viewModel.firstResponseList.first;
    selectedDepartment = viewModel.departmentList.first;
    selectedPIC = viewModel.picList.first;
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
      constantWidgets.showCustomDialog(
        context,
        title: "Success!",
        content: "Form is saved successfully.",
        iconData: Icons.done,
        iconColor: Colors.green,
        button1Text: "OK",
        onButton1Pressed: _clearSelections,
        onButton2Pressed: () {},
        button1Color: Colors.green,
        button1TextColor: Colors.white,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      //backgroundColor: Colors.white,
      appBar:
          CustomAppBar(username: widget.username, scaffoldKey: _scaffoldKey),
      body: Row(children: [
        SideDrawer(username: widget.username), // Add the side navigation here
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) => Consumer<StatusController>(
              builder: (context, model, child) {
                return SingleChildScrollView(
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
                        buildCard(context),
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
        ),
      ]),
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
                      color: Color.fromARGB(255, 220, 246, 227),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Scrollbar(
                      controller: body2ScrollController,
                      thumbVisibility: false,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: body2ScrollController,
                        child: DataTable(
                          columns: const [
                            DataColumn(
                                label: Text('Bizapp ID',
                                    style:
                                        AppStyles.fixedTextStyle)), // username
                            DataColumn(
                                label: Text('Name',
                                    style: AppStyles.fixedTextStyle)), // nama
                            DataColumn(
                                label: Text('Email',
                                    style: AppStyles.fixedTextStyle)), // emel
                            DataColumn(
                                label: Text('No. H/P',
                                    style: AppStyles.fixedTextStyle)), // no hp
                            DataColumn(
                                label: Text('Package',
                                    style: AppStyles.fixedTextStyle)), // pakej
                            DataColumn(
                                label: Text('Date Start',
                                    style: AppStyles
                                        .fixedTextStyle)), // tarikh naik taraf
                            DataColumn(
                                label: Text('Date End',
                                    style: AppStyles
                                        .fixedTextStyle)), // tarikh tamat
                            DataColumn(
                                label: Text('Last Login',
                                    style: AppStyles
                                        .fixedTextStyle)), // tarikh log masuk
                            DataColumn(
                                label: Text('Last Order',
                                    style: AppStyles
                                        .fixedTextStyle)), // tarikh last order
                            DataColumn(
                                label: Text('Payment',
                                    style:
                                        AppStyles.fixedTextStyle)), // payment
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text(provider.username,
                                  style: AppStyles.fixedTextStyle)), // username
                              DataCell(Text(provider.nama,
                                  style: AppStyles.fixedTextStyle)), // nama
                              DataCell(Text(provider.emel,
                                  style: AppStyles.fixedTextStyle)), // emel
                              DataCell(Text(provider.nohp,
                                  style: AppStyles.fixedTextStyle)), // no hp
                              DataCell(Text(provider.roleid,
                                  style: AppStyles.fixedTextStyle)), // pakej
                              DataCell(Text(datePart,
                                  style: AppStyles
                                      .fixedTextStyle)), // tarikhnaiktaraf
                              DataCell(Text(datePart2,
                                  style:
                                      AppStyles.fixedTextStyle)), // tarikhtamat
                              DataCell(Text(provider.tarikhlogmasuk,
                                  style: AppStyles
                                      .fixedTextStyle)), // tarikh log masuk
                              DataCell(Text(datePart3,
                                  style: AppStyles
                                      .fixedTextStyle)), // tarikh last order
                              DataCell(Text(provider.typepayment,
                                  style: AppStyles.fixedTextStyle)), // payment
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                      color: Color.fromARGB(255, 220, 246, 227),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Scrollbar(
                      controller: body3ScrollbarController,
                      thumbVisibility: false,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: body3ScrollbarController,
                        child: DataTable(
                          columns: const [
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
                                    style:
                                        AppStyles.fixedTextStyle)), // bil ejen
                            DataColumn(
                                label: Text('Bizappay',
                                    style: AppStyles
                                        .fixedTextStyle)), // ada bizappay
                            DataColumn(
                                label: Text('Business',
                                    style: AppStyles
                                        .fixedTextStyle)), // jenis syarikat
                            DataColumn(
                                label: Text('Bizappshop',
                                    style: AppStyles.fixedTextStyle)),
                            DataColumn(
                                label: Text('Bizappage',
                                    style: AppStyles.fixedTextStyle)),
                            DataColumn(
                                label: Text('Woo-Commerce',
                                    style: AppStyles.fixedTextStyle)),
                            DataColumn(
                                label: Text('Wsapme',
                                    style: AppStyles.fixedTextStyle)),
                            DataColumn(
                                label: Text('Shopee',
                                    style: AppStyles.fixedTextStyle)),
                            DataColumn(
                                label: Text('Tiktok',
                                    style: AppStyles.fixedTextStyle)),
                          ],
                          rows: [
                            DataRow(cells: [
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
                              const DataCell(Text("-",
                                  style:
                                      AppStyles.fixedTextStyle)), // bizappshop
                              DataCell(Text(provider.bizappage,
                                  style:
                                      AppStyles.fixedTextStyle)), // bizappage
                              DataCell(Text(provider.woo,
                                  style: AppStyles
                                      .fixedTextStyle)), // woo-commerce
                              DataCell(Text(provider.wsapme,
                                  style: AppStyles.fixedTextStyle)), // wsapme
                              DataCell(Text(provider.statusShopee,
                                  style: AppStyles.fixedTextStyle)), // shopee
                              DataCell(Text(provider.statusTiktok,
                                  style: AppStyles.fixedTextStyle)), // tiktok
                            ]),
                          ],
                        ),
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
        Container(
          padding: const EdgeInsets.all(10),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            minHeight: MediaQuery.of(context).size.height * 0.3,
          ),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 220, 246, 227),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Scrollbar(
            controller: body4ScrollController,
            thumbVisibility: false,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: body4ScrollController,
              child: DataTable(
                columns: const [
                  DataColumn(
                      label: Text('Date', style: AppStyles.fixedTextStyle)),
                  DataColumn(
                      label: Text('Key In', style: AppStyles.fixedTextStyle)),
                  DataColumn(
                      label: Text('Source', style: AppStyles.fixedTextStyle)),
                  DataColumn(
                      label: Text('Medium', style: AppStyles.fixedTextStyle)),
                  DataColumn(
                      label: Text('Product', style: AppStyles.fixedTextStyle)),
                  DataColumn(
                      label: Text('Issue', style: AppStyles.fixedTextStyle)),
                  DataColumn(
                      label:
                          Text('Description', style: AppStyles.fixedTextStyle)),
                  DataColumn(
                      label: Text('Level', style: AppStyles.fixedTextStyle)),
                  DataColumn(
                      label: Text('First Response',
                          style: AppStyles.fixedTextStyle)),
                  DataColumn(
                      label:
                          Text('Department', style: AppStyles.fixedTextStyle)),
                  DataColumn(
                      label: Text('PIC', style: AppStyles.fixedTextStyle)),
                  DataColumn(
                      label:
                          Text('Follow Up', style: AppStyles.fixedTextStyle)),
                  DataColumn(
                      label: Text('Note', style: AppStyles.fixedTextStyle)),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text(constantWidgets.date(),
                        style: AppStyles.fixedTextStyle)), // date
                    DataCell(Text(widget.username,
                        style: AppStyles.fixedTextStyle)), // key in
                    DataCell(Text(selectedSource.value,
                        style: AppStyles.fixedTextStyle)), // source
                    DataCell(
                      IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: selectedMediumValues
                              .map((value) =>
                                  Text(value, style: AppStyles.fixedTextStyle))
                              .toList(),
                        ),
                      ),
                    ), // medium (checkbox)
                    DataCell(Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: selectedProductValues
                          .map((value) =>
                              Text(value, style: AppStyles.fixedTextStyle))
                          .toList(),
                    )), // product (checkbox)
                    DataCell(Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: selectedIssueValues
                          .map((value) =>
                              Text(value, style: AppStyles.fixedTextStyle))
                          .toList(),
                    )), // issue (checkbox)
                    DataCell(Text(viewModel.descController.text,
                        style: AppStyles.fixedTextStyle)), // description
                    DataCell(Text(selectedLevel.value,
                        style: AppStyles.fixedTextStyle)), // level
                    DataCell(Text(selectedInitial.value,
                        style: AppStyles
                            .fixedTextStyle)), // first response - initial
                    DataCell(Text(selectedDepartment.value,
                        style: AppStyles.fixedTextStyle)), // department
                    DataCell(Text(selectedPIC.value,
                        style: AppStyles.fixedTextStyle)), // pic
                    DataCell(Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: selectedFollowUpValues
                          .map((value) =>
                              Text(value, style: AppStyles.fixedTextStyle))
                          .toList(),
                    )), // follow up (checkbox)
                    DataCell(Text(viewModel.noteController.text,
                        style: AppStyles.fixedTextStyle)), // note
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
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.7; // 70% of screen width

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: containerWidth,
              padding: EdgeInsets.symmetric(horizontal: 70, vertical: 50),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 220, 246, 227),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bizapp ID: ${model.username}",
                      style: AppStyles.fixedBoldStyle),
                  SizedBox(height: 15),
                  Text("Package: ${model.roleid}",
                      style: AppStyles.fixedBoldStyle),
                  SizedBox(height: 30),
                  Text("Name: ${model.nama}", style: AppStyles.fixedBoldStyle),
                  SizedBox(height: 15),
                  Text("Email: ${model.emel}", style: AppStyles.fixedBoldStyle),
                  SizedBox(height: 15),
                  Text("No. H/P: ${model.nohp}",
                      style: AppStyles.fixedBoldStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilePicker() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Attachment: ', style: AppStyles.fixedBoldStyle),
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

  PageController _pageController = PageController();
  int _currentPage = 0;

  Widget buildCard(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double cardWidth = screenWidth * 0.7; // 70% of screen width
    double cardHeight = screenHeight * 0.75; // 75% of screen height

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: cardWidth,
          height: cardHeight,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // Rounded corners
            ),
            color: Color.fromARGB(255, 220, 246,
                227), // Set the background color of the Card to pure white
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildStepIndicators(),
                  SizedBox(height: 20),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        buildStep1(),
                        buildStep2(),
                        buildStep3(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStepIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildStepIndicator(0, '1'),
        buildStepIndicator(1, '2'),
        buildStepIndicator(2, '3'),
      ],
    );
  }

  Widget buildStepIndicator(int step, String number) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentPage = step;
        });
        _pageController.animateToPage(
          step,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
          color: _currentPage == step ? Colors.green : Colors.grey,
          shape: BoxShape.circle,
        ),
        child: Text(
          number,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildStep1() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              constantWidgets.buildDropdown(
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
              constantWidgets.buildCheckbox(
                  label: 'Medium',
                  items: viewModel.mediumCheckbox,
                  width: 30,
                  onChanged: (value, index) {
                    handleCheckboxChanges(
                        value, index, viewModel.mediumCheckbox);
                  }),
              constantWidgets.buildCheckbox(
                  label: 'Product',
                  items: viewModel.productCheckbox,
                  width: 32,
                  onChanged: (value, index) {
                    handleCheckboxChanges(
                        value, index, viewModel.productCheckbox);
                  }),
              SizedBox(height: 20),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: constantWidgets.buildButton(
              label: 'Next',
              onPressed: () {
                setState(() {
                  _currentPage = 1;
                });
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              buttonColor: Colors.blue, // Customize button color
              textColor: Colors.white, // Customize text color
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStep2() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          constantWidgets.buildCheckbox(
              label: 'Issue',
              items: viewModel.issueCheckbox,
              width: 51,
              onChanged: (value, index) {
                handleCheckboxChanges(value, index, viewModel.issueCheckbox);
              }),
          constantWidgets.buildText(
              label: 'Description', controller: viewModel.descController),
          _buildFilePicker(),
          constantWidgets.buildDropdown(
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
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              constantWidgets.buildButton(
                label: 'Back',
                onPressed: () {
                  setState(() {
                    _currentPage = 0;
                  });
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                buttonColor: Colors.white,
                textColor: Colors.black,
              ),
              constantWidgets.buildButton(
                label: 'Next',
                onPressed: () {
                  setState(() {
                    _currentPage = 2;
                  });
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                buttonColor: Colors.blue,
                textColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildStep3() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          constantWidgets.buildDropdown(
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
          constantWidgets.buildDropdown(
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
          constantWidgets.buildDropdown(
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
          constantWidgets.buildCheckbox(
            label: 'Follow Up',
            items: viewModel.followUpCheckbox,
            width: 16,
            onChanged: (value, index) {
              handleCheckboxChanges(value, index, viewModel.followUpCheckbox);
            },
          ),
          constantWidgets.buildText(
              label: 'Note', controller: viewModel.noteController),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              constantWidgets.buildButton(
                  label: "Back",
                  onPressed: () {
                    setState(() {
                      _currentPage = 1;
                    });
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  buttonColor: Color.fromARGB(255, 255, 255, 255),
                  textColor: Color.fromARGB(255, 0, 0, 0)),
              Row(
                children: [
                  constantWidgets.buildButton(
                      label: "Clear",
                      onPressed: () {
                        constantWidgets.showCustomDialog(
                          context,
                          title: "Are you sure?",
                          content: "This will clear out the entire form.",
                          iconData: Icons.warning,
                          iconColor: Colors.red,
                          button1Text: "Clear form",
                          button2Text: "Cancel",
                          onButton1Pressed: _clearSelections,
                          onButton2Pressed: () {},
                          button1Color: Colors.red,
                          button1TextColor: Colors.white,
                          button2Color: Colors.white,
                          button2TextColor: Colors.black,
                        );
                      },
                      buttonColor: Colors.red,
                      textColor: Colors.white),
                  SizedBox(width: 10),
                  constantWidgets.buildButton(
                      label: "Submit",
                      onPressed: () {
                        _updateSelectedValues();
                      },
                      buttonColor: Colors.green,
                      textColor: Colors.white),
                ],
              ),
            ],
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

class AppStyles {
  static const TextStyle fixedTextStyle = TextStyle(
    color: Color.fromARGB(255, 27, 27, 27), // or any fixed color you prefer
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle fixedBoldStyle =
      TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);
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
