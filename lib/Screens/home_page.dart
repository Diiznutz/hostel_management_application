import 'package:card_loading/card_loading.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

import '../Components/circle_reveal_clipper.dart';
import '../database.dart';
import '../Models/hostel_model.dart';
import '../Screens/students_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService dbService = DatabaseService();
  late var hostels = dbService.getHostels();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RefreshIndicator.adaptive(
          onRefresh: () async => setState(() {
            hostels = dbService.getHostels();
          }),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/hostels_banner.webp',
                  height: 200, fit: BoxFit.cover),
              const SizedBox(height: 48),
              Expanded(
                child: FutureBuilder<List<Hostel>>(
                  future: hostels,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return CardLoading(
                              height: 160, child: hostelCard(Hostel.empty()));
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final hostels = snapshot.data!;
                      return ListView.builder(
                        itemCount: hostels.length,
                        itemBuilder: (context, index) {
                          return hostelCard(hostels[index]);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget hostelCard(Hostel h) {
    final clr = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.push(
            context, transitionPageRoute(StudentsPage(hostel: h))),
        child: Card(
          surfaceTintColor: h.toColor(),
          shadowColor: h.toColor(),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: FancyShimmerImage(
                      width: 100, height: 100,
                      imageUrl: h.imageUrl,
                      errorWidget: const CardLoading(height: 100)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'Warden: ',
                        children: [
                          TextSpan(
                              text: h.warden,
                              style: const TextStyle(fontSize: 16))
                        ],
                      ),
                      style: TextStyle(fontSize: 14, color: clr.primary),
                    ),
                    Text(h.name,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('${h.studentCount} Students',
                        style: TextStyle(fontSize: 14, color: clr.secondary)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 40, color: clr.primary),
            ],
          ),
        ),
      ),
    );
  }
}
