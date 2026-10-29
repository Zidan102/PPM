import 'package:flutter/material.dart';
import '../data/sample_events.dart';
import '../models/event_item.dart';
import '../models/registration_ticket.dart';
import '../widgets/event_card.dart';
import '../widgets/venue_map_viewer.dart';
import 'event_registration_screen.dart';
import 'registered_tickets_screen.dart';

class HomeEventsScreen extends StatefulWidget {
  final Function(RegistrationTicket) onTicketCreated;
  final List<RegistrationTicket> registeredTickets;
  final Function(int) onCancelTicket;

  const HomeEventsScreen({
    Key? key,
    required this.onTicketCreated,
    required this.registeredTickets,
    required this.onCancelTicket,
  }) : super(key: key);

  @override
  State<HomeEventsScreen> createState() => _HomeEventsScreenState();
}

class _HomeEventsScreenState extends State<HomeEventsScreen> {
  int _currentIndex = 0;
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final List<EventItem> filteredEvents = _selectedCategory == 'All'
        ? SampleData.events
        : SampleData.events.where((e) => e.category == _selectedCategory).toList();

    final List<Widget> pages = [
      // Tab 1: Seminar & Workshop
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['All', 'AI', 'Mobile', 'IoT', 'Cybersecurity'].map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: _selectedCategory == category,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                final event = filteredEvents[index];
                return EventCard(
                  event: event,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventRegistrationScreen(
                          event: event,
                          onTicketCreated: widget.onTicketCreated,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      // Tab 2: Galeri & Denah Venue
      const VenueMapViewer(),

      // Tab 3: Tiket Terdaftar
      RegisteredTicketsScreen(
        tickets: widget.registeredTickets,
        onCancelTicket: widget.onCancelTicket,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('NusaEvent Hub'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.event),
            label: 'Seminar',
          ),
          NavigationDestination(
            icon: Icon(Icons.map),
            label: 'Denah Venue',
          ),
          NavigationDestination(
            icon: Icon(Icons.confirmation_number),
            label: 'Tiket Saya',
          ),
        ],
      ),
    );
  }
}