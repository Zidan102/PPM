import 'package:flutter/material.dart';
import '../models/registration_ticket.dart';

class RegisteredTicketsScreen extends StatelessWidget {
  final List<RegistrationTicket> tickets;
  final Function(int) onCancelTicket;

  const RegisteredTicketsScreen({Key? key, required this.tickets, required this.onCancelTicket}) : super(key: key);

  void _confirmCancel(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Pembatalan'),
        content: const Text('Apakah Anda yakin ingin membatalkan tiket terdaftar ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tidak'),
          ),
          TextButton(
            onPressed: () {
              onCancelTicket(index);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tiket berhasil dibatalkan.')),
              );
            },
            child: const Text('Ya, Batalkan', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (tickets.isEmpty) {
      const children = [
        Center(child: Text('Belum ada tiket terdaftar.', style: TextStyle(fontSize: 16)))
      ];
      return ListView(children: children);
    }

    return ListView.builder(
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        final ticket = tickets[index];
        return Dismissible(
          key: Key(ticket.id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (direction) async {
            _confirmCancel(context, index);
            return false; // Dialog will handle deletion confirmation
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(ticket.eventTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nama: ${ticket.fullName} (${ticket.nim})'),
                  Text('Tanggal: ${ticket.attendanceDate}'),
                  Text('Kit: ${ticket.seminarKit}'),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.cancel, color: Colors.red),
                onPressed: () => _confirmCancel(context, index),
              ),
            ),
          ),
        );
      },
    );
  }
}