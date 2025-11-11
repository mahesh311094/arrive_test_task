import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/map_widget.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/primary_text_field.dart';
import '../providers/ip_lookup_provider.dart';

class IpLookupScreen extends ConsumerWidget {
  final TextEditingController _ipController = TextEditingController();

  IpLookupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ipState = ref.watch(ipLookupViewModelProvider);
    final ipViewModel = ref.read(ipLookupViewModelProvider.notifier);

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
                  child: PrimaryButton(
                    onPressed: () {
                      if (_ipController.text.trim().isNotEmpty) {
                        ipViewModel.fetchIpLookupInfo(
                          ip: _ipController.text.trim(),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please enter an IP address'),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    text: 'Lookup',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: PrimaryButton(
                    onPressed: () async {
                      await ipViewModel.fetchCurrentIpInfo();
                      final updatedState = ref.read(ipLookupViewModelProvider);
                      _ipController.text = updatedState.ipInfo?.ip ?? "";
                    },
                    text: 'Use My IP',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (ipState.isLoading)
              const Center(child: CircularProgressIndicator()),
            if (ipState.error != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  ipState.error!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 16),
            if (!ipState.isLoading)
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: MapWidget(
                    latitude: ipState.ipInfo?.latitude ?? 51.5074,
                    longitude: ipState.ipInfo?.longitude ?? -0.1278,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
