import 'package:buildconnect/features/profile_data/providers/profile_data_provider.dart';
import 'package:buildconnect/shared/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:flutter/scheduler.dart';
import 'package:buildconnect/models/shared/shared_models.dart';

class ContactsTabScreen extends ConsumerStatefulWidget {
  const ContactsTabScreen({super.key});

  @override
  ConsumerState<ContactsTabScreen> createState() => ContactsTabScreenState();
}

class ContactsTabScreenState extends ConsumerState<ContactsTabScreen> {
  late final ProfileDataNotifier _profileDataNotifier;

  /// Local states
  List<Contact> _contacts = [];
  ContactType? _contactType = ContactType.values.first;
  final _contactValueController = TextEditingController();

  ///

  @override
  void initState() {
    super.initState();
    _profileDataNotifier = ref.read(profileDataNotifierProvider.notifier);
  }

  bool _initialized = false;
  void _loadData() {
    final profileData = ref.read(profileDataNotifierProvider);
    final _data = profileData.valueOrNull;

    if (_data != null && !_initialized) {
      final data = _data.profile;
      debugPrint('Initializing data: $data');
      setState(() {
        /////////////// Load data

        // debugPrint('Loading data: ${data.contacts}');
        _contacts = data.contacts.toList();

        ///////////////
        _initialized = true;
      });
    }
  }

  Future<void> dumpFromControllers() async {
    debugPrint('Right before dumping from controllers');
    await Future.microtask(() async {
    // SchedulerBinding.instance.addPostFrameCallback((_) {
      await _profileDataNotifier.dumpFromControllers(
        // designStyles: _designStyles.toList(),
        // portfolioLinks: _portfolioLinks,
        contacts: _contacts,
      );
    });
  }

  @override
  void dispose() {
    debugPrint('Disposing');
    // Future(() {
    dumpFromControllers();

    // _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileData = ref.watch(profileDataNotifierProvider);

    // Bind controller only once when data is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightWidget(widget: headerText(text: "Contacts")),

            heightWidget(
              widget:
                  _contacts.isEmpty
                      ? Center(
                        child: const Text(
                          'Create contacts below',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your contacts',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          ..._contacts.map((contact) {
                            return Card(
                              child: ListTile(
                                title: Text(contact.type.label),
                                subtitle: Text(contact.value),
                                leading: contact.type.icon(context),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      _contacts.remove(contact);
                                    });
                                  },
                                ),
                              ),
                            );
                          }),
                          const Divider(),
                        ],
                      ),
            ),

            heightWidget(
              widget: buildDrowndownButtonFormField(
                selectedValue: _contactType,
                values: ContactType.values,
                labelText: 'Method',
                title: 'Add More Contacts',
                gap: 8,
                onChanged: ((v) {
                  setState(() {
                    _contactType = v;
                  });
                }),
              ),
              height: 8,
            ),

            heightWidget(
              widget: buildTextFormField(
                controller: _contactValueController,
                hintText: _contactType!.hintText,
                labelText: '',
              ),
            ),

            heightWidget(
              widget: ElevatedButton.icon(
                onPressed: (() {
                  if (_contactValueController.text.isNotEmpty) {
                    setState(() {
                      _contacts.add(
                        Contact(
                          type: _contactType!,
                          value: _contactValueController.text,
                        ),
                      );
                      _contactValueController.clear();

                      for (final contact in _contacts) {
                        debugPrint(
                          'Contact: ${contact.type.label} - ${contact.value}',
                        );
                      }
                    });
                  }
                }),
                icon: const Icon(Icons.add),
                label: const Text('Add contact'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
