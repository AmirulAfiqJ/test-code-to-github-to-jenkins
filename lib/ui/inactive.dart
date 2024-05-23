import 'package:bizapptrack/viewmodel/inactiveViewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bizapptrack/viewmodel/status_viewmodel.dart';
import 'package:bizapptrack/ui/sideNav.dart';
import 'customAppBar.dart';

class Inactive extends StatelessWidget {
    final String username;

  Inactive({super.key, required this.username});
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InactiveViewmodel(),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: CustomAppBar(username: username, scaffoldKey: _scaffoldKey),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Consumer<InactiveViewmodel>(
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
                        const SizedBox(height: 20),
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

  Widget _buildSearchSection(InactiveViewmodel model, BuildContext context) {
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

  Widget _buildUserDetailsSection(BuildContext context, InactiveViewmodel model) {
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
                    "Email: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "No. H/P: ",
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
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 125, 212, 98),
                      ),
                      child: Text('Update', style: TextStyle(color: Colors.black)),
                    ),
                    ElevatedButton(
                      onPressed: model.clearSelections,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 109, 99),
                      ),
                      child: Text('Clear', style: TextStyle(color: Colors.black)),
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
        "Inactive",
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
  const FormStatus({super.key, required this.controller, required this.onSearch});

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
            },
          ),
        ),
        onEditingComplete: onSearch,
      ),
    );
  }
}
