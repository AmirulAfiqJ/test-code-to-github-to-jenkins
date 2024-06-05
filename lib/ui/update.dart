import 'package:bizapptrack/utils/route.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  final String username;
  final String nama;
  final String roleid;
  final String tarikhnaiktaraf;
  final String tarikhtamat;

  Update({
    required this.username,
    required this.nama,
    required this.roleid,
    required this.tarikhnaiktaraf,
    required this.tarikhtamat,
  });

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  late TextEditingController usernameController;
  late TextEditingController namaController;
  late TextEditingController roleidController;
  late TextEditingController tarikhnaiktarafController;
  late TextEditingController tarikhtamatController;

  String _selectedStatus = 'Active';
  String _selectedReason = 'Not enough stock';

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.username);
    namaController = TextEditingController(text: widget.nama);
    roleidController = TextEditingController(text: widget.roleid);
    tarikhnaiktarafController = TextEditingController(text: widget.tarikhnaiktaraf);
    tarikhtamatController = TextEditingController(text: widget.tarikhtamat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
        ),
        title: const Text(
          'Bizapp Back Office',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
       backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: PopupMenuButton(
              icon: const Icon(Icons.account_circle, color: Color.fromARGB(255, 237, 245, 255)),
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  child: Text('Welcome, John'),
                  enabled: false,
                ),
                      PopupMenuItem(
                        child: ListTile(
                          leading: const Icon(Icons.exit_to_app),
                          title: const Text('Logout'),
                          onTap: () {
                      //       Navigator.pushAndRemoveUntil(
                      //         context,
                      //         MaterialPageRoute(builder: (context) => LoginPage()),
                      //         (route) => false,
                      // );
                      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(100, 40, 100, 40),
        child: Column(
          children: [
            const Header(), // Calling the Header widget here
            Card(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(labelText: 'Username'),
                      enabled: false,
                    ),
                    TextFormField(
                      controller: namaController,
                      decoration: const InputDecoration(labelText: 'Nama'),
                      enabled: false,
                    ),
                    TextFormField(
                      controller: roleidController,
                      decoration: const InputDecoration(labelText: 'Pakej'),
                      enabled: false,
                    ),
                    TextFormField(
                      controller: tarikhnaiktarafController,
                      decoration: const InputDecoration(labelText: 'Tarikh naik taraf'),
                      enabled: false,
                    ),
                    TextFormField(
                      controller: tarikhtamatController,
                      decoration: const InputDecoration(labelText: 'Tarikh tamat'),
                      enabled: false,
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        const Text(
                          'Status : ',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 10),
                        DropdownButton<String>(
                          value: _selectedStatus,
                          items: <String>['Active', 'Inactive']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedStatus = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text(
                          'Reason for inactivity : ',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 10),
                        DropdownButton<String>(
                          value: _selectedReason,
                          items: <String>[
                            'Using Tiktok Shop',
                            'Using Shopee',
                            'Change business method',
                            'Not enough stock',
                            'KIV',
                            'Others'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedReason = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        // Add your save logic here
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(20, 40),
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
        padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
        child: Text("Update User Data",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
            )),
      ),
    );
  }
}
