import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class About_us extends StatelessWidget {
  const About_us({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Know all About Us'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 58, 116, 98),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'In today\'s world, all of us experience stress no matter what age group we belong to.\n\nStudents go through the stress of building good careers, dealing with peer pressure, keeping up with technology, and many more. Whereas grownups have to deal with the workload and manage personal and professional life. But sometimes situations can go out of hand and it becomes obvious to feel anxious or fearful.\n\nThis is the time when self-awareness and expert help comes into play. To be self-aware one will need to question themselves like "What ", "Why" and "How" a solution to a problem can be figured out. This might help in some cases but certainly not always.\n\nMost of the time people need someone to just hear them out quietly without judging or forcing opinions on them, but what about the 3 am thoughts? or What if one does not have anybody with this much understanding?\n\nKeeping such thoughts and emotions in our minds we have very mindfully developed this application to cater to all your emotional and psychological needs.\n\nWith RECONNECT, as the name says, you can reconnect with your inner and peaceful self and trace the improvement within you through constant efforts.\n\nOur application is safe for a user of any age since it does not reveal any kind of personal details to the public. This way it also eliminates the consciousness of being judged by anyone. You can write and post freely about anything and everything that you feel and also support others by replying to their posts. The chat feature enables you to talk to someone as if you are talking to your best friend! The ones who might seek professional help, need to go nowhere as the application already has a range of suggestions about the experts to whom you can pour your heart out.\n\nThe sole motive of building RECONNECT is to spread awareness about Mental well-being and offer help to the ones in need of it.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ]));
  }
}
