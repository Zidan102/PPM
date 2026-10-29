import 'package:flutter/material.dart';
import '../models/event_item.dart';
import '../models/registration_ticket.dart';

class EventRegistrationScreen extends StatefulWidget {
  final EventItem event;
  final Function(RegistrationTicket) onTicketCreated;

  const EventRegistrationScreen({Key? key, required this.event, required this.onTicketCreated}) : super(key: key);

  @override
  State<EventRegistrationScreen> createState() => _EventRegistrationScreenState();
}

class _EventRegistrationScreenState extends State<EventRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nimController = TextEditingController();
  final _emailController = TextEditingController();
  final _whatsappController = TextEditingController();

  String _participantType = 'Mahasiswa';
  String _selectedDate = '';
  String _seminarKit = 'Standard (Notebook + Pen)';
  bool _agreedToTerms = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.event.date;
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2026),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = "${picked.day} ${_getMonthName(picked.month)} ${picked.year}";
      });
    }
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
    return months[month - 1];
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _agreedToTerms) {
      setState(() {
        _isLoading = true;
      });

      // Simulasi proses network/loading
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        final newTicket = RegistrationTicket(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          eventTitle: widget.event.title,
          fullName: _nameController.text,
          nim: _nimController.text,
          email: _emailController.text,
          whatsapp: _whatsappController.text,
          participantType: _participantType,
          attendanceDate: _selectedDate,
          seminarKit: _seminarKit,
          agreedToTerms: _agreedToTerms,
        );

        widget.onTicketCreated(newTicket);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pendaftaran Berhasil! Tiket Anda telah diterbitkan.')),
        );

        Navigator.pop(context);
      });
    } else if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anda harus menyetujui tata tertib terlebih dahulu!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar: ${widget.event.title}')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Nama Lengkap', border: OutlineInputBorder()),
                      validator: (value) => value!.isEmpty ? 'Nama wajib diisi' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _nimController,
                      decoration: const InputDecoration(labelText: 'NIM', border: OutlineInputBorder()),
                      validator: (value) => value!.isEmpty ? 'NIM wajib diisi' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                      validator: (value) => value!.isEmpty || !value.contains('@') ? 'Email tidak valid' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _whatsappController,
                      decoration: const InputDecoration(labelText: 'Nomor WhatsApp', border: OutlineInputBorder()),
                      keyboardType: TextInputType.phone,
                      validator: (value) => value!.isEmpty ? 'Nomor WhatsApp wajib diisi' : null,
                    ),
                    const SizedBox(height: 16),
                    const Text('Tipe Peserta:', style: TextStyle(fontWeight: FontWeight.bold)),
                    DropdownButtonFormField<String>(
                      value: _participantType,
                      items: ['Mahasiswa', 'Dosen', 'Umum']
                          .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                          .toList(),
                      onChanged: (val) => setState(() => _participantType = val!),
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: Text('Tanggal Kehadiran: $_selectedDate')),
                        ElevatedButton(onPressed: _pickDate, child: const Text('Pilih Tanggal')),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('Paket Seminar Kit:', style: TextStyle(fontWeight: FontWeight.bold)),
                    DropdownButtonFormField<String>(
                      value: _seminarKit,
                      items: ['Standard (Notebook + Pen)', 'Premium (Totebag + Tumbler)', 'Digital Only']
                          .map((kit) => DropdownMenuItem(value: kit, child: Text(kit)))
                          .toList(),
                      onChanged: (val) => setState(() => _seminarKit = val!),
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      title: const Text('Saya menyetujui seluruh tata tertib dan ketentuan acara.'),
                      value: _agreedToTerms,
                      onChanged: (val) => setState(() => _agreedToTerms = val ?? false),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                        onPressed: _submitForm,
                        child: const Text('Kirim Pendaftaran', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}