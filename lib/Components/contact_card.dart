import 'package:flutter/material.dart';
import 'package:hostel_management_application/Components/random_person_icon.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../Models/student_model.dart';
import 'edit_student_dialog.dart';

class ContactCardDialog extends StatelessWidget {
  final Student student;

  const ContactCardDialog({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                student.toColor().withAlpha(10),
                student.toColor().withAlpha(50)
              ]),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => showEditStudentDialog(context, student),
                child: const Text('Edit'),
              ),
            ),
            const CircleAvatar(
              radius: 75,
              child: RandomPersonIcon(size: 120),
            ),
            const SizedBox(height: 16.0),
            Text(
              student.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'ID: ${student.id}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Ink(
                  decoration: const ShapeDecoration(
                      color: Colors.lightBlue, shape: CircleBorder()),
                  child: IconButton(
                    onPressed: () => launchUrlString('tel:${student.contact}'),
                    icon: const Icon(Icons.phone),
                  ),
                ),
                const SizedBox(width: 16.0),
                Ink(
                  decoration: const ShapeDecoration(
                      color: Colors.orange, shape: CircleBorder()),
                  child: IconButton(
                    onPressed: () => launchUrlString('mailto:${student.email}'),
                    icon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(width: 16.0),
                Ink(
                  decoration: const ShapeDecoration(
                      color: Colors.red, shape: CircleBorder()),
                  child: IconButton(
                    onPressed: () => launchUrlString('sms:${student.contact}'),
                    icon: const Icon(Icons.sms),
                  ),
                ),
                const SizedBox(width: 16.0),
                Ink(
                  decoration: const ShapeDecoration(
                      color: Colors.green, shape: CircleBorder()),
                  child: IconButton(
                    onPressed: () =>
                        launchUrlString('https://wa.me/91${student.contact}'),
                    icon: const Icon(Icons.message),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ListBody(
              children: [
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Phone'),
                  subtitle: Text(student.contact.toString()),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email'),
                  subtitle: Text(student.email),
                ),
                ListTile(
                  leading: const Icon(Icons.bed),
                  title: const Text('Room Number'),
                  subtitle: Text(student.room.toString()),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Hostel Name'),
                  subtitle: Text(student.hostel.id),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
