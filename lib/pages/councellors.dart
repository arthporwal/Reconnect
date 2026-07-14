import 'package:flutter/material.dart';

class User {
  final String Username;
  final String description;
  final String urlAvatar;

  const User({
    required this.Username,
    required this.description,
    required this.urlAvatar,
  });
}

class Experts extends StatefulWidget {
  Experts({Key? key}) : super(key: key);

  @override
  State<Experts> createState() => _ExpertsState();
}

class _ExpertsState extends State<Experts> {
  List<User> users = [
    //1
    const User(
        Username: 'Dr. Sujatha D Sharma',
        description:
            '\nC/o Parivartan Centre For Mental Health, C-7/225-26, Safdarjung Development Area, Delhi- 110016.\n\nContact: 011-26526243/ 26564955',
        urlAvatar:
            'https://imgmediagumlet.lbb.in/media/2019/06/5d14afe882911550d32f8c23_1561636840571.JPG?fm=webp&w=750&h=500&dpr=1'),
    //2
    const User(
        Username: 'Dr. Reena Nath',
        description:
            '\nJ-6 Saket, New Delhi.\n\nContact: 011-41761717/ 29555320',
        urlAvatar:
            'https://imgmediagumlet.lbb.in/media/2019/06/5d14b04b82911550d32f8e4e_1561636939413.JPG?fm=webp&w=750&h=500&dpr=1'),
    //3
    const User(
        Username: 'Dr. Monika Sharma',
        description:
            '\nSantushti Apartments, 6102, Vasant Kunj, New Delhi, Delhi-110070.\n\nContact: 011-46052017',
        urlAvatar:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKIDzsNtpUyaQ7QAwlMYb_kXfspHIQ7VV8eQ&usqp=CAU'),
    //4
    const User(
        Username: 'Dr. Sameer Malhotra',
        description:
            '\nNo. 32, near Post Office, Block D, Nizamuddin East, New Delhi, Delhi-110013.\n\nContact: 011-46097200',
        urlAvatar:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSu2uMXgfEYG_PMPmBx6bIegsEpvZuAsPxYZQ&usqp=CAU'),
    //5
    const User(
        Username: 'Dr. Akshay Kumar',
        description: '\nGurgaon, India.\n\nContact: 0124-4511111',
        urlAvatar:
            'https://media-exp1.licdn.com/dms/image/C4D03AQFoAcdl2nv0wQ/profile-displayphoto-shrink_200_200/0/1617538885296?e=1663804800&v=beta&t=bsohzq-VqXZX7k_oark4BZeFa22n6MJ7708HwHpye8w'),
    //6
    const User(
        Username: 'Dr. Jyoti Kapoor',
        description:
            '\nParas Hospital, Gurgaon and private clinic-\'Mansthali\'.\n\nContact: 0124 4585555, +91 9958598967',
        urlAvatar: 'https://api.parashospitals.com/uploads/2017/01/2-1.jpg'),
    //7
    const User(
        Username: 'Dr. Shelja Sen',
        description:
            '\nChildren First, A2/35, Safdarjung Enclave, New Delhi.\n\nContact: 01146084842, 0124 4004625',
        urlAvatar:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQn5zWYvJnbVtsr-o2aWzWh9BguU9pkH3tbKA&usqp=CAU'),

    //8
    const User(
        Username: 'Sanchita Mental Health Foundation',
        description:
            '\nA-133, Sector 43, Noida, Uttar Pradesh.\n\nContact: +91 9910848200',
        urlAvatar:
            'https://i0.wp.com/feminisminindia.com/wp-content/uploads/2016/08/sanchita-mental-health-foundation-noida-sector-43-noida-psychological-counselling-services-kzzelk0fm9.jpg?fit=512%2C340&ssl=1'),
    //9
    const User(
        Username: 'Dr. Vaibhav Dubey',
        description:
            '\nCivil lines,Between Kilol Park Petrol Pump And Polytechnic Square, Bhopal, Madhya Pradesh-462001.\n\nContact: 082696 88901',
        urlAvatar:
            'https://assets.lybrate.com/img/documents/doctor/dp/2e8f427b80ff104a10e334f3625c5380/Psychiatry-VaibhavDubey-Bhopal-5d9029.jpg'),
    //10
    const User(
        Username: 'Dr. Sumeet Sahni',
        description:
            '\nC-401, Virasha Heights, Danish Kunj, Bhopal, Madhya Pradesh-462042.\n\nContact: 099779 28194',
        urlAvatar:
            'https://qph.fs.quoracdn.net/main-thumb-189677021-200-xkicjqdygajadphswxxnvtldesrzdclt.jpeg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: const Color.fromARGB(255, 58, 116, 98),
        title: const Text(
          'Consult an Expert',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final User = users[index];
              //final User= users
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(User.urlAvatar),
                    ),
                    title: Text(
                      User.Username,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      User.description,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    isThreeLine: true,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
