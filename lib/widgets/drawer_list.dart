import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  const DrawerList({
    Key? key,
    required this.name,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String name;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    var inkWell = InkWell(
      hoverColor: Colors.grey,

      onHover: ((Event) {}),
      onTap: onPressed,
      // code for icons of the items in list

      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: Color.fromARGB(255, 243, 241, 244),
            ),
            const SizedBox(
              width: 30,
            ),
            // text written next to the icon i.e. name of the item
            Text(
              name,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 255, 255, 255)),
            )
          ],
        ),
      ),
    );
    return inkWell;
  }
}
