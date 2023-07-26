import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'controllers/cont1.dart';
void main() {
  runApp(const MyApp());

}



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];
  final controller = Get.put(SecureZeta());
  getMessages() async{
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      final messages = await _query.querySms(
        kinds: [SmsQueryKind.inbox, SmsQueryKind.sent],
        // address: '+254712345789',
        count: 10,
      );
      debugPrint('sms inbox messages: ${messages.length}');
      setState(() {
        _messages = messages;
        controller.message = _messages;
      });
    } else {
      await Permission.sms.request();
    }
    controller.getCategories( _messages,context);
  }
  @override
  void initState() {
    super.initState();
  getMessages();


   }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        backgroundColor: Color(0xFFebebeb),
        appBar: AppBar(
          backgroundColor: Color(0xFFebebeb),
          title: Center(child: SvgPicture.asset('images/svglogo.svg',height: 50),
        ),),
        body: RefreshIndicator(

          onRefresh: ()=>getMessages(),
          child: ListView.builder(
            itemCount: controller.message.length,
            itemBuilder: (BuildContext context,int i) {






              return GestureDetector(
onTap: (){


},

              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Card(
                  elevation: 0,

                  color: Theme.of(context).colorScheme.surfaceVariant,

                child: Container(
                  decoration: BoxDecoration(
                    border: controller.msgg.result![i].spam == 1 ? Border.all(color: Colors.red):Border.all(color: Colors.transparent),
borderRadius: BorderRadius.circular(10)

                  ),

                child: Center(

                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Container(

                          width: Get.width,
                          color:controller.msgg.result![i].spam == 1 ? Color(0xFFbb3b0e):Colors.transparent,
                          child:controller.msgg.result![i].spam == 1?Row(
                            children: [

                              Icon(Icons.shield_moon_outlined,color: Colors.white,),
                              Center(child: Text('This Message is Detected as Spam',style: TextStyle(color: Colors.white)),),
                            ],
                          ):null ,
                        ),
                            controller.msgg.result![i].spam == 1 ?SizedBox(height: 10,):SizedBox(),

                            controller.msgg.result![i].spam == 0?    Text('${controller.message[i].sender} ',style: TextStyle(color: Colors.green,fontSize: 18),):Text('${controller.message[i].sender} ',style: TextStyle(color: Colors.red,fontSize: 18),),
                      Padding(
                        padding: const EdgeInsets.only(top:5.0),
                        child: Text('${controller.msgg.result![i].message.toString()}'),
                      ),
                      ]),
                    ),
                  )
                ),),),
              )
              );
            },
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //
        //   },
        //   child: const Icon(Icons.refresh),
        // ),
      ),
    );
  }
}
