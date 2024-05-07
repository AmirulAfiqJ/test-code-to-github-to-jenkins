import 'package:bizapptrack/ui/button.dart';
import 'package:bizapptrack/ui/data_user.dart';
import 'package:bizapptrack/env.dart';
import 'package:bizapptrack/ui/list_to_excel.dart';
import 'package:bizapptrack/ui/loading_widget.dart';
import 'package:bizapptrack/viewmodel/status_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TestRenew extends StatefulWidget {
  const TestRenew({super.key});

  @override
  State<TestRenew> createState() => _TestRenewState();
}

class _TestRenewState extends State<TestRenew> {
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      floatingActionButton: BizappButton(
        color: Colors.black87,
        title: "Export Excel",
        tapCallback: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ListToExcel())),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(Env.versi, style: const TextStyle(color: Colors.black)),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Consumer<StatusController>(
          builder: (context, model, child) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const Header(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FormStatus(
                            constraints: constraints,
                            controller: usernameController),
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () async {
                            setState(() {
                              model.call = true;
                            });
                            try {
                              await model.loginServices(context,
                                  userid: usernameController.text);
                            } finally {
                              setState(() {
                                model.call = false;
                              });
                            }
                          },
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _body2(constraints),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Widget _booleanStatus() {
  //   return context;
  // }

  Widget _body2(BoxConstraints constraints) {

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

    return context.read<StatusController>().call == false
        ? Consumer<StatusController>(
            builder: (context, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[
                          200], // Set the background color of the box // Solid border
                      borderRadius: BorderRadius.circular(
                          10), // Optional: Add rounded corners
                    ),
                    child: Wrap(
                      runSpacing: 5,
                      children: [
                        /// data user
                        DataUser(children: [
                          BizappText(text: "Username:  ${provider.username}"),
                          BizappText(text: "Nama:  ${provider.nama}"),
                          BizappText(text: "Pakej:  ${provider.roleid}"),
                          BizappText(
                              text:
                                  "Tarikh naik taraf:  ${provider.tarikhnaiktaraf}"),
                          Text("Tarikh tamat:  ${provider.tarikhtamat}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                          Text("Tarikh sekarang: $formattedDate", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
                          // const Text("Status: Aktif",
                          //     style: TextStyle(
                          //         fontSize: 16,
                          //         fontWeight: FontWeight.bold,
                          //         color: Colors.green)),
                          //_tips(),
                          provider.basicplusonly != "-" &&
                                  provider.basicplusonly != ""
                              ? BizappText(
                                  text:
                                      "Basic+ Add On: ${provider.basicplusonly}\n")
                              : const SizedBox(),
                        ]),
                        SizedBox(width: constraints.maxWidth >= 501 ? 50 : 10),

                        /// data rekod
                        provider.callDedagang == false
                            ? DataUser(children: [
                                BizappText(
                                    text:
                                        "Rekod Tempahan : ${provider.rekodtempahan}"),
                                const SizedBox(height: 10),
                                BizappText(
                                    text:
                                        "Bil. Tempahan : ${provider.biltempahan}"),
                                const SizedBox(height: 10),
                                BizappText(
                                    text: "Bil. Ejen : ${provider.bilEjen}"),
                                const SizedBox(height: 10),
                                BizappText(
                                    text:
                                        "Ada Bizappay : ${provider.bizappayacc}"),
                              ])
                            : const GetLoad(text: "Load data statistics ..."),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.4),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors
                          .grey[200], 
                      borderRadius: BorderRadius.circular(
                          10), // Optional: Add rounded corners
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Center align content horizontally
                      children: [
                        SizedBox(height: 5), // Add space above the text
                        BizappText(text: 'Senarai rekod 5 terakhir: '),
                        SizedBox(height: 5), // Add space below the text
                        /// data list
                        provider.callRekod == false
                            ? provider.listrekod.isEmpty
                                ? Text('Tiada Rekod',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ))
                                : Center(
                                    child:
                                        DataList(listrekod: provider.listrekod))
                            : GetLoad(text: "Load data record ..."),
                      ],
                    ),
                  ),
                ],
              );
            },
          )
        : const GetLoad(text: "Load data ...");
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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text("Status Renew Bizapp User",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
            )),
      ),
    );
  }
}

class FormStatus extends StatelessWidget {
  final BoxConstraints constraints;
  final TextEditingController controller;
  const FormStatus(
      {super.key, required this.constraints, required this.controller});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: constraints.maxWidth >= 501
              ? MediaQuery.of(context).size.width * 0.3
              : MediaQuery.of(context).size.width * 0.9,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  style: const TextStyle(fontSize: 16),
                  keyboardType: TextInputType.emailAddress,
                  controller: controller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                  ],
                  decoration: InputDecoration(
                    hoverColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(50), // Rounded corners
                      borderSide: const BorderSide(
                        width: 2,
                        style: BorderStyle.solid,
                      ),
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
