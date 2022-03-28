import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:hive/hive.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // // Initialize hive
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  // // Open the peopleBox
  await Hive.openBox('wallet');
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        // OKToast(
        //   textStyle: const TextStyle(fontSize: 19.0, color: Colors.white),
        //   backgroundColor: Colors.grey,
        //   radius: 10.0,
        //   child:
        MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              brightness: Brightness.light,
              /* light theme settings */
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              /* dark theme settings */
            ),
            themeMode: ThemeMode.dark,
            home: const MyHomePage(title: 'Flutter Demo Home Page')
            // ),
            // animationCurve: Curves.easeIn,
            // animationBuilder: const Miui10AnimBuilder(),
            // animationDuration: const Duration(milliseconds: 200),
            // duration: const Duration(seconds: 3),
            );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Razorpay _razorpay;
  int amount = 0;
  TextEditingController textEditingController = new TextEditingController();
  late Box b;
  String val = "0";

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    b = Hive.box('wallet');
  }

  savebox_Data(String am) async {
    b.add(am);
  }

  getbox_data(String key) async {
    return b.get(key);
  }

  Map getbox_dataAll() {
    return b.toMap();
  }

  // delete_All(){
  //   b.delete
  // }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
    Hive.close();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    response.toString();
    if (response.paymentId != null) {
      int t = amount ~/ 100;
      savebox_Data(t.toString());
      getdata();
    }
    // showToast("SUCCESS: " + response.paymentId!);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // showToast("ERROR: " + response.code.toString() + " - " + response.message!);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // showToast("EXTERNAL_WALLET: " + response.walletName!);
  }

  void startPayment() async {
    amount = int.parse(textEditingController.text) * 100;
    var startPay = {
      'key': 'rzp_test_5UkUURSOG0Mz2W',
      'amount': amount.toString(),
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };

    _razorpay.open(startPay);
    textEditingController.text = "";
  }

  List<Widget> getdata() {
    List<Widget> widget = [];
    // for (var i = 0; i < 20; i++) {
    //   widget.add(Card(
    //     child: ListTile(
    //       title: Text("SHubha"),
    //     ),
    //   ));
    // }
    int pp = 0;
    getbox_dataAll().forEach((key, value) {
      pp += int.parse(value);
      widget.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        child: SizedBox(
          height: 70,
          child: Card(
            child: ListTile(
              trailing: Text(
                "Added",
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              title: Row(
                children: [
                  Text("\u{20B9}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(value,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28)),
                  )
                ],
              ),
            ),
          ),
        ),
      ));
    });
    moneyFormat(pp.toString());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: <Widget>[
                Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 5.5,
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Column(
                            children: [
                              Text(
                                "Your Wallet",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "\u{20B9}" + val,
                                  style: TextStyle(
                                      fontSize: 40.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: Text(
                        "All Transaction",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    )),
                Column(
                  children: getdata(),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // startPayment();
          ff();
        },
        backgroundColor: Colors.black38,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future ff() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Add amount"),
              content: TextField(
                controller: textEditingController,
                keyboardType: TextInputType.number,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      startPayment();
                      Navigator.pop(context);
                    },
                    child: Text("OK"))
              ],
            ));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  moneyFormat(String price) {
    var value = price;
    if (price.length > 2) {
      value = value.replaceAll(RegExp(r'\D'), '');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
    }
    setState(() {
      val = value;
    });
  }
}
