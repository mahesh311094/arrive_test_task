import 'package:flutter/material.dart';

import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/primary_text_field.dart';

class IpLookupScreen extends StatefulWidget {
  const IpLookupScreen({super.key});

  @override
  State<IpLookupScreen> createState() => _IpLookupScreenState();
}

class _IpLookupScreenState extends State<IpLookupScreen> {
  final TextEditingController _ipController = TextEditingController();

  @override
  void dispose() {
    _ipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Arrive IP Locator'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PrimaryTextField(
              controller: _ipController,
              hint: 'Enter IP Address',
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(onPressed: () {}, text: 'Lookup'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: PrimaryButton(onPressed: () {}, text: 'Use My IP'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Map or Location will appear here',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
