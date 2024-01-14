import 'package:get/get.dart';
import 'package:wor_admin/const/const.dart';
import 'package:wor_admin/views/messages/components/chat_bubble.dart';
import '../widgets/text_style.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: darkGrey,),
          onPressed: (){
            Get.back();
        }, 
        ),
        title: boldText(text: chats, size: 16.0, color: fontGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return chatBubble();
                },
              ),
              ),
            10.heightBox,
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(child: TextFormField(
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: "Enter message",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: purpleColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: purpleColor,
                        ),
                      )
                    ),
                  )),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.send, color: purpleColor,))
                ],
              ),
              
            ),
            10.heightBox,
          ],
          
        ),
      ),
    );
  }
}