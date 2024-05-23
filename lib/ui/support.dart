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

  void dispose() {
    viewModel.sourceController.dispose();
    viewModel.descController.dispose();
    viewModel.levelController.dispose();
    viewModel.firstResponseController.dispose();
    viewModel.departmentController.dispose();
    viewModel.picController.dispose();
    viewModel.noteController.dispose();
  }

  void _performSearch() async {
    StatusController model =
        Provider.of<StatusController>(context, listen: false);
    setState(() {
      model.call = true;
    });
    try {
      await model.loginServices(context,userid: viewModel.usernameController.text);
      await model.profile(context, pid: model.pid);
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
                    _buildDDSource(viewModel),
                    _buildCheckboxMedium(viewModel),
                    _buildCheckboxProduct(viewModel),
                    _buildCheckboxIssue(viewModel),
                    _buildTextDesc(viewModel),
                    _buildDDLevel(viewModel),
                    _buildDDFirstResponse(viewModel),
                    _buildDDDepartment(viewModel),
                    _buildDDPIC(viewModel),
                    _buildCheckboxFollowUp(viewModel),
                    _buildTextNote(viewModel),
                    _buildUpdateClearButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      drawer: SideDrawer(username: widget.username),
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

  Widget _buildCheckboxMedium(SupportViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column for the "Select your choices" text
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Medium: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              //SizedBox(height: 16),
            ],
          ),
          SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Generate the checkboxes in a 3 by 3 layout
                for (int i = 0; i < viewModel.mediumCheckbox.length; i += 3)
                  Row(
                    children: [
                      for (int j = i;
                          j < i + 3 && j < viewModel.mediumCheckbox.length;
                          j++)
                        Expanded(
                          child: CheckboxListTile(
                            title: Text(viewModel.mediumCheckbox[j].name),
                            value: viewModel.mediumCheckbox[j].value,
                            onChanged: (bool? value) {
                              setState(() {
                                viewModel.mediumCheckbox[j].value = value!;
                              });
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

  Widget _buildCheckboxProduct(SupportViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column for the "Select your choices" text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(width: 32),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Generate the checkboxes in a 3 by 3 layout
                for (int i = 0; i < viewModel.productCheckbox.length; i += 3)
                  Row(
                    children: [
                      for (int j = i;
                          j < i + 3 && j < viewModel.productCheckbox.length;
                          j++)
                        Expanded(
                          child: CheckboxListTile(
                            title: Text(viewModel.productCheckbox[j].name),
                            value: viewModel.productCheckbox[j].value,
                            onChanged: (bool? value) {
                              setState(() {
                                viewModel.productCheckbox[j].value = value!;
                              });
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

  Widget _buildCheckboxIssue(SupportViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column for the "Select your choices" text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Issue: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(width: 51),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Generate the checkboxes in a 3 by 3 layout
                for (int i = 0; i < viewModel.issueCheckbox.length; i += 3)
                  Row(
                    children: [
                      for (int j = i;
                          j < i + 3 && j < viewModel.issueCheckbox.length;
                          j++)
                        Expanded(
                          child: CheckboxListTile(
                            title: Text(viewModel.issueCheckbox[j].name),
                            value: viewModel.issueCheckbox[j].value,
                            onChanged: (bool? value) {
                              setState(() {
                                viewModel.issueCheckbox[j].value = value!;
                              });
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

  Widget _buildCheckboxFollowUp(SupportViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column for the "Select your choices" text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Follow up: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
            ],
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Generate the checkboxes in a 3 by 3 layout
                for (int i = 0; i < viewModel.followUpCheckbox.length; i += 3)
                  Row(
                    children: [
                      for (int j = i;
                          j < i + 3 && j < viewModel.followUpCheckbox.length;
                          j++)
                        Expanded(
                          child: CheckboxListTile(
                            title: Text(viewModel.followUpCheckbox[j].name),
                            value: viewModel.followUpCheckbox[j].value,
                            onChanged: (bool? value) {
                              setState(() {
                                viewModel.followUpCheckbox[j].value = value!;
                              });
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

  Widget _buildDDSource(SupportViewModel viewModel) {
    if (viewModel.sourceController.text.isEmpty) {
      viewModel.sourceController.text = viewModel.sourceList.first.value;
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Source: ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 60),
              DropdownButton<String>(
                value: viewModel.sourceController.text,
                items: viewModel.sourceList.map((FormList formList) {
                  return DropdownMenuItem<String>(
                    value: formList.value,
                    child: Text(formList.name),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    viewModel.sourceController.text = newValue!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDDLevel(SupportViewModel viewModel) {
    if (viewModel.levelController.text.isEmpty) {
      viewModel.levelController.text = viewModel.levelList.first.value;
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Level: ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 70),
              DropdownButton<String>(
                value: viewModel.levelController.text,
                items: viewModel.levelList.map((FormList formList) {
                  return DropdownMenuItem<String>(
                    value: formList.value,
                    child: Text(formList.name),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    viewModel.levelController.text = newValue!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDDFirstResponse(SupportViewModel viewModel) {
    if (viewModel.firstResponseController.text.isEmpty) {
      viewModel.firstResponseController.text =
          viewModel.firstResponseList.first.value;
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'First Response: ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 20),
              DropdownButton<String>(
                value: viewModel.firstResponseController.text,
                items: viewModel.firstResponseList.map((FormList formList) {
                  return DropdownMenuItem<String>(
                    value: formList.value,
                    child: Text(formList.name),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    viewModel.firstResponseController.text = newValue!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDDDepartment(SupportViewModel viewModel) {
    if (viewModel.departmentController.text.isEmpty) {
      viewModel.departmentController.text =
          viewModel.departmentList.first.value;
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Department: ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 20),
              DropdownButton<String>(
                value: viewModel.departmentController.text,
                items: viewModel.departmentList.map((FormList formList) {
                  return DropdownMenuItem<String>(
                    value: formList.value,
                    child: Text(formList.name),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    viewModel.departmentController.text = newValue!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDDPIC(SupportViewModel viewModel) {
    if (viewModel.picController.text.isEmpty) {
      viewModel.picController.text = viewModel.picList.first.value;
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'PIC: ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 87),
              DropdownButton<String>(
                value: viewModel.picController.text,
                items: viewModel.picList.map((FormList formList) {
                  return DropdownMenuItem<String>(
                    value: formList.value,
                    child: Text(formList.name),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    viewModel.picController.text = newValue!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextDesc(SupportViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment
            .start, // Align text and text field vertically at the top
        children: [
          Text(
            'Description: ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: TextField(
              controller: viewModel.descController,
              maxLines: 3, // Set the maximum number of lines
              keyboardType: TextInputType.multiline, // Enable multiline input
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextNote(SupportViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment
            .start, // Align text and text field vertically at the top
        children: [
          Text(
            'Note: ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 70),
          Expanded(
            child: TextField(
              controller: viewModel.noteController,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
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
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {},
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
      width: MediaQuery.of(context).size.width * 0.6,
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
            },
          ),
        ),
        onEditingComplete: onSearch,
      ),
    );
  }
}
