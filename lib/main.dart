import 'package:flutter/material.dart';
import 'package:random_password_generator/random_password_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isUpperCase = false;
  bool isLowerCase = false;
  bool isSimbol = false;
  bool isNomor = false;
  final password = RandomPasswordGenerator();
  Color? passwordColor = null;
  String? passwordStatus = null;
  String? outputPassword = null;
  TextEditingController panjangController = new TextEditingController();

  void generatePassword(int panjangKarakter) {
    outputPassword = password.randomPassword(
        letters: isLowerCase,
        numbers: isNomor,
        passwordLength: panjangKarakter.toDouble(),
        specialChar: isSimbol,
        uppercase: isUpperCase);
    double passwordstrength = password.checkPassword(password: outputPassword!);
    if (passwordstrength < 0.3) {
      passwordColor = Colors.red;
      passwordStatus = 'This password is weak!';
    } else if (passwordstrength < 0.7) {
      passwordColor = Colors.blue;
      passwordStatus = 'This password is Good';
    } else {
      passwordColor = Colors.green;
      passwordStatus = 'This passsword is Strong';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(
                  "Aplikasi Password Generator",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Mengandung Upper case"),
                    Switch(
                        value: isUpperCase,
                        onChanged: (value) {
                          setState(() {
                            isUpperCase = value;
                          });
                        })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Mengandung Lower Case"),
                    Switch(
                        value: isLowerCase,
                        onChanged: (value) {
                          setState(() {
                            isLowerCase = value;
                          });
                        })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Mengandung Simbol"),
                    Switch(
                        value: isSimbol,
                        onChanged: (value) {
                          setState(() {
                            isSimbol = value;
                          });
                        })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Mengandung Nomor"),
                    Switch(
                        value: isNomor,
                        onChanged: (value) {
                          setState(() {
                            isNomor = value;
                          });
                        })
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: panjangController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Panjang karakter",
                      border: OutlineInputBorder(
                        borderSide: new BorderSide(),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    generatePassword(
                        int.parse(panjangController.text.toString()));
                    setState(() {});
                  },
                  child: Text("Buat Password"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50)),
                ),
                SizedBox(
                  height: 20,
                ),
                outputPassword != null
                    ? Column(
                        children: [
                          Text("👇👇👇👇👇"),
                          SizedBox(
                            height: 10,
                          ),
                          Text(outputPassword!, style: TextStyle(fontSize: 19)),
                          SizedBox(
                            height: 10,
                          ),
                          Text(passwordStatus!,
                              style: TextStyle(
                                  color: passwordColor != null
                                      ? passwordColor
                                      : Colors.black))
                        ],
                      )
                    : SizedBox()
              ],
            ),
          ),
        ),
      )),
    );
  }
}
