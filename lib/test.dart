// import 'package:flutter/material.dart';
// import 'package:payment_getway/main.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// main() {
//   runApp(MyApps());
// }

// class MyApps extends StatelessWidget {
//   const MyApps({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(primarySwatch: Colors.amber),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   late Razorpay _razorpay;
//   int amount = 90;
//   String tittle = "AMount";
//   TextEditingController textEditingController = new TextEditingController();
//   // late Box b;

//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//     // b = Hive.box('wallet');
//     // savebox_Data();
//     // getdata();
//   }

//   // savebox_Data() async {
//   //   b.put("test", "value");
//   // }

//   // getbox_data() async {
//   //   print('----------->' + b.get('test'));
//   // }

//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear();
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     // showToast("SUCCESS: " + response.paymentId!);
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     // showToast("ERROR: " + response.code.toString() + " - " + response.message!);
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     // showToast("EXTERNAL_WALLET: " + response.walletName!);
//   }

//   void startPayment() async {
//     int amount = int.parse(textEditingController.text) * 100;
//     var startPay = {
//       'key': 'rzp_test_5UkUURSOG0Mz2W',
//       'amount': amount.toString(),
//       'name': 'Acme Corp.',
//       'description': 'Fine T-Shirt',
//       'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
//     };

//     _razorpay.open(startPay);
//   }

//   List<Widget> getdata() {
//     List<Widget> widget = [];
//     for (var i = 0; i < 20; i++) {
//       widget.add(Card(
//         child: ListTile(
//           title: Text("SHubha"),
//         ),
//       ));
//     }

//     return widget;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       appBar: AppBar(
//         title: Text("ssss"),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: Column(
//               children: <Widget>[
//                 Card(
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height / 4.5,
//                         width: MediaQuery.of(context).size.width / 1.1,
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 18.0),
//                           child: Column(
//                             children: [
//                               Text(
//                                 "Your Wallet",
//                                 style: TextStyle(
//                                     fontSize: 40.0,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 8.0),
//                                 child: Text(
//                                   "180.00",
//                                   style: TextStyle(
//                                       fontSize: 30.0,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Column(
//                   children: getdata(),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // startPayment();
//           ff();
//         },
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }

//   Future ff() {
//     return showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               title: Text(tittle),
//               content: TextField(
//                 controller: textEditingController,
//               ),
//               actions: [
//                 ElevatedButton(
//                     onPressed: () => startPayment(), child: Text("OK"))
//               ],
//             ));
//   }
// }
