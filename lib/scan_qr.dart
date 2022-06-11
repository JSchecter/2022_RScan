import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rscan/checkin_info.dart';
import 'package:rscan/values.dart';



class MyHome extends StatelessWidget {
  MyHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: Column(
        children: [
          Container(
            height:400,
            child: ListView(
              children: [
                ListTile(
                  title: Text('Location 1'),onTap: (){
                  Values.locationName ='Location 1';
                },
                ),
                ListTile(
                  title: Text('Location 2'),onTap: (){
                  Values.locationName ='Location 2';

                },
                ),ListTile(
                  title: Text('Location 3'),onTap: (){
                  Values.locationName ='Location 3';

                },
                ),ListTile(
                  title: Text('Location 4'),onTap: (){
                  Values.locationName ='Location 4';
                },
                ),
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QRViewExample(),
                ));
              },
              child: const Text('qrView'),
            ),
          ),
        ],
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack (
        children: [ Expanded(flex: 4, child: _buildQrView(context)),
          Container(
              height:70,
              child: AppBar(
                elevation: 0,
                automaticallyImplyLeading: true,
                backgroundColor: Colors.transparent,
                leading: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child:
                    IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon : Icon(Icons.close, color: Colors.white, size: 30,)
                    )
                ),
                title: Text('Scan Qr Code',style: TextStyle(color: Colors.white),),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: IconButton(
                      onPressed: (){
                        Navigator.push(context,  MaterialPageRoute(builder: (context) => const RScan()));
                      },
                      icon: Icon(Icons.arrow_forward,size: 30,),
                    ),
                  ),
                ],
              )
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0))
                ),
                child: Image.asset('assets/qr_bottom_buttons2.png'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RScan()),
        );
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}