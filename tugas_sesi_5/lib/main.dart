import 'package:flutter/material.dart';
import 'models/registration_ticket.dart';
import 'screens/home_events_screen.dart';

void main() {
  runApp(const NusaEventHubApp());
}

class NusaEventHubApp extends StatefulWidget {
  const NusaEventHubApp({Key? key}) : super(key: key);

  @override
  State<NusaEventHubApp> createState() => _NusaEventHubAppState();
}

class _NusaEventHubAppState extends State<NusaEventHubApp> {
  final List<RegistrationTicket> _registeredTickets = [];

  void _addTicket(RegistrationTicket ticket) {
    setState(() {
      _registeredTickets.add(ticket);
    });
  }

  void _cancelTicket(int index) {
    setState(() {
      _registeredTickets.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NusaEvent Hub',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: HomeEventsScreen(
        onTicketCreated: _addTicket,
        registeredTickets: _registeredTickets,
        onCancelTicket: _cancelTicket,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}