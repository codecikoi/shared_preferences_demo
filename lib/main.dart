import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SharedPreferencesDemo(),
    );
  }
}

class SharedPreferencesDemo extends StatefulWidget {
  const SharedPreferencesDemo({Key? key}) : super(key: key);

  @override
  State<SharedPreferencesDemo> createState() => _SharedPreferencesDemoState();
}

class _SharedPreferencesDemoState extends State<SharedPreferencesDemo> {

  late SharedPreferences _prefs;

  static const String kNumberPrefKey = 'number_pref';
  static const String kBoolPrefKey = 'bool_pref';

  int _numberPref = 0;
  bool _boolPref = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance()
      ..then((prefs) {
        setState(() =>
        this._prefs = prefs);
        _loadNumberPref();
        _loadBoolPref();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared preferences'.toUpperCase()),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(children: [
                Text('Number Preference'),
                Text('0'),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Increment'),
                ),
              ]),
              TableRow(
                children: [
                  Text('Boolean Preference'),
                  Text('false'.toUpperCase()),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Toggle'),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Reset data'),
          ),
        ],
      ),
    );
  }


  Future<Null> _setNumberPref(int value) async {
    await this._prefs.setInt(kNumberPrefKey, value);
    _loadNumberPref();
  }

  Future<Null> _setBoolPref(bool value) async {
    await this._prefs.setBool(kBoolPrefKey, value);
    _loadBoolPref();
  }

  void _loadNumberPref() {
    setState(() {
      this._numberPref = this._prefs.getInt(kNumberPrefKey) ?? 0;
    });
  }

  void _loadBoolPref() {
    setState(() {
      this._boolPref = this._prefs.getBool(kBoolPrefKey) ?? false;
    });
  }

  Future<Null> _resetDataPref() async {
    await this._prefs.remove(kNumberPrefKey);
    await this._prefs.remove(kBoolPrefKey);
    _loadBoolPref();
    _loadNumberPref();
  }
}