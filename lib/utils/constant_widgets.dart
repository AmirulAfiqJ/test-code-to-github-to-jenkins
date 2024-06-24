import 'package:bizapptrack/viewmodel/support_viewmodel.dart';
import 'package:flutter/material.dart';

class ConstantWidgets {
  Future<void> showCustomDialog(
    BuildContext context, {
    required String title,
    required String content,
    required IconData iconData,
    required Color iconColor,
    required String button1Text,
    String? button2Text,
    required void Function() onButton1Pressed,
    void Function()? onButton2Pressed,
    TextStyle? titleTextStyle,
    TextStyle? contentTextStyle,
    TextStyle? buttonTextStyle,
    Color? button1Color,
    Color? button2Color,
    Color? button1TextColor,
    Color? button2TextColor,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(iconData, color: iconColor),
              const SizedBox(width: 8),
              Text(title, style: titleTextStyle),
            ],
          ),
          content: Text(content, style: contentTextStyle),
          actions: <Widget>[
            TextButton(
              child: Text(button1Text, style: buttonTextStyle),
              style: TextButton.styleFrom(
                foregroundColor: button1TextColor,
                backgroundColor: button1Color,
              ),
              onPressed: () {
                onButton1Pressed();
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
            ),
            if (button2Text != null &&
                onButton2Pressed !=
                    null) // Render only if button2Text and onButton2Pressed are provided
              TextButton(
                child: Text(button2Text, style: buttonTextStyle),
                style: TextButton.styleFrom(
                  foregroundColor: button2TextColor,
                  backgroundColor: button2Color,
                ),
                onPressed: () {
                  onButton2Pressed!();
                  Navigator.of(dialogContext).pop(); // Close the dialog
                },
              ),
          ],
        );
      },
    );
  }

  Widget buildButton({
    required String label,
    required void Function() onPressed,
    Color? buttonColor, // Optional parameter for button color
    Color? textColor, // Optional parameter for text color
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor, backgroundColor: buttonColor, // Text color
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }

  Widget buildCheckbox({
    required String label,
    required List<CheckboxItem> items,
    required width,
    required void Function(bool, int) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column for the label text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$label: ', style: AppStyles.fixedBoldStyle),
              const SizedBox(height: 16),
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
                            title: Text(items[j].name,
                                style: AppStyles.fixedTextStyle),
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

  Widget buildDropdown({
    required String label,
    required FormList value,
    required List<FormList> items,
    required double width,
    required void Function(FormList) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('$label: ', style: AppStyles.fixedBoldStyle),
              SizedBox(width: width),
              DropdownButton<FormList>(
                value: value,
                items: items.map((FormList item) {
                  return DropdownMenuItem<FormList>(
                    value: item,
                    child: Text(item.name, style: AppStyles.fixedGreyStyle),
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

  Widget buildText({
    required String label,
    required TextEditingController controller,
    int maxLines = 2,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: AppStyles.fixedBoldStyle),
          const SizedBox(width: 20),
          Expanded(
            child: TextField(
                controller: controller,
                maxLines: maxLines,
                keyboardType: keyboardType,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                style: AppStyles.fixedTextStyle),
          ),
        ],
      ),
    );
  }

  String date() {
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
    return date;
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

  static const TextStyle fixedGreyStyle = TextStyle(
      color: Colors.grey, fontSize: 16, fontWeight: FontWeight.normal);
}
