import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormBody extends StatelessWidget {
  const FormBody({super.key});

  @override
  Widget build(BuildContext context) {
  final nameController = TextEditingController();
  final formController = TextEditingController();
  final toCotnroller = TextEditingController();
  String dropValueCategories = "Please Choose: ";
  var categoriesList = <String>[
    "Please Choose:",
    "Sick",
    "IDN Teaching",
    "others"
  ]; 

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            controller: nameController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              labelText: "Your Name",
              labelStyle: const TextStyle(
                fontSize: 14,
                color: Colors.black
              ),
              hintText: "Please enter your name",
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Colors.grey
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.blueAccent)
              )
            )
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: Text(
              "Description",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                color: Colors.blueAccent,
                style: BorderStyle.solid,
                width: 1
                )
              ),
              child: DropdownButton(
               dropdownColor: Colors.white,
               value: dropValueCategories,
               onChanged: (value) {
                dropValueCategories = value.toString(); //agar tdk miss
               },
               items: categoriesList.map((value) {
                return DropdownMenuItem(
                  value: value.toString(),
                  child: Text(
                    value.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black
                    ),
                  ),
                  );
               }).toList(), // method toList() berfungsi untuk mengkonfersi sebuah data acak menjadi berurutan pda list
               icon: const Icon(Icons.arrow_drop_down),
               iconSize: 24,
               elevation: 16,
               style: const TextStyle(
                fontSize: 14,
                color: Colors.black
               ),
               underline: Container(
                height: 2,
                color: Colors.blueGrey,
               ),
               isExpanded: true, //ini parnetnay si dorpdown jd ga semuanya
                ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Text(
                          "From",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context, 
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2025),
                                lastDate: DateTime(2025)
                                );
                                if (pickedDate != null) {
                                  //ini untuk mengonversikan data detail tanggal yg diambil dri picker date menjadi format dd/mm/yy
                                  formController.text = DateFormat('dd/mm/yy').format(pickedDate); 
                                }
                            },
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black
                            ),
                            controller: formController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              hintText: "Stating from",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.grey
                              )
                            ),
                          ),
                        )
                      ],
                    )
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: Row(
                        children: [
                          const Text(
                            "Until: ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2025),
                                  lastDate: DateTime(2025)
                                );
                                if (pickedDate != null) {
                                  toCotnroller.text = DateFormat('dd/mm/yy').format(pickedDate);
                                }
                              },
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black
                              ),
                              controller: toCotnroller,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                hintText: "Until",
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey
                                )
                              ),
                            ),
                          )
                        ],
                      )
                      )
                ],
              ),
              )
        ],
      ),
      );
  }
}