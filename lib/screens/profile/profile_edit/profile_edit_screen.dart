// lib/screens/profile/profile_edit_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../models/core_models.dart';
import '../../models/enums.dart';
import '../../models/sub_profiles_models.dart';
import '../../services/profile_service.dart';
import '../../services/auth_service.dart';
import '../../utils/enum_helpers.dart';

class ProfileEditScreen extends ConsumerStatefulWidget {
  final bool isCreating;
  
  const ProfileEditScreen({
    super.key,
    this.isCreating = false,
  });

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Main form controllers
  final _displayNameController = TextEditingController();
  final _bioController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  
  // Form state
  File? _profileImageFile;
  ProfileType _selectedProfileType = ProfileType.architect;
  WorkingMode _selectedWorkingMode = WorkingMode.onsite;
  int _yearsOfExperience = 1;
  List<Domain> _selectedDomains = [];
  
  // Specialized profile details controllers and state
  // For brevity, I'm not including all the controllers for each profile type
  
  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }
  
  @override
  void dispose() {
    // Dispose all controllers
    _displayNameController.dispose();
    _bioController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
  
  Future<void> _loadProfileData() async {
    if (widget.isCreating) return;
    
    final profileAsync = await ref.read(profileServiceProvider.future);
    if (profileAsync == null) return;
    
    // Populate the form with existing profile data
    setState(() {
      _displayNameController.text = profileAsync.displayName;
      _bioController.text = profileAsync.bio;
      _emailController.text = profileAsync.contactInfo.emails.isNotEmpty ? 
                            profileAsync.contactInfo.emails.first : '';
      _phoneController.text = profileAsync.contactInfo.phoneNumbers.isNotEmpty ? 
                            profileAsync.contactInfo.phoneNumbers.first : '';
      _addressController.text = profileAsync.mainLocation.address;
      _selectedProfileType = profileAsync.profileType;
      _selectedWorkingMode = profileAsync.workingMode;
      _yearsOfExperience = profileAsync.yearsOfExperience;
      _selectedDomains = List.from(profileAsync.domains);
      
      // Load specialized profile data based on profile type
      // (This would be expanded in a full implementation)
    });
  }
  
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      setState(() {
        _profileImageFile = File(pickedFile.path);
      });
    }
  }
  
  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _isLoading = true;
    });
    
    try {
      // Get current profile or create new one
      Profile profile;
      final currentProfile = ref.read(profileServiceProvider).valueOrNull;
      
      if (currentProfile != null && !widget.isCreating) {
        profile = currentProfile;
      } else {
        profile = Profile.empty().copyWith(
          id: ref.read(authServiceProvider.notifier).currentUserId!,
        );
      }
      
      // Upload profile image if selected
      String profilePhotoUrl = profile.profilePhoto;
      if (_profileImageFile != null) {
        profilePhotoUrl = await ref.read(profileServiceProvider.notifier)
                            .uploadProfileImage(_profileImageFile!);
      }
      
      // Create updated profile with form data
      final updatedProfile = profile.copyWith(
        displayName: _displayNameController.text,
        bio: _bioController.text,
        profilePhoto: profilePhotoUrl,
        profileType: _selectedProfileType,
        workingMode: _selectedWorkingMode,
        yearsOfExperience: _yearsOfExperience,
        domains: _selectedDomains,
        mainLocation: Location(
          address: _addressController.text,
          latLng: profile.mainLocation.latLng,  // Keep existing coordinates or use geocoding service
        ),
        contactInfo: ContactInfo(
          emails: [_emailController.text],
          phoneNumbers: [_phoneController.text],
          socials: profile.contactInfo.socials,
        ),
        
        // Add specialized profile data based on profile type
        // This would be expanded in a full implementation
        architectProfile: _selectedProfileType == ProfileType.architect 
            ? _buildArchitectProfile(profile.architectProfile) 
            : null,
        contractorProfile: _selectedProfileType == ProfileType.contractor 
            ? _buildContractorProfile(profile.contractorProfile) 
            : null,
        // ... other profile types
      );
      
      // Save the profile
      await ref.read(profileServiceProvider.notifier).saveProfile(updatedProfile);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile saved successfully')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving profile: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  
  // These methods would build the specialized profiles based on form data
  ArchitectProfile _buildArchitectProfile(ArchitectProfile? existing) {
    // This is a simplified example - would need form controllers for these fields
    return ArchitectProfile(
      architectRole: ArchitectRole.projectArchitect,
      designPhilosophy: 'Minimalist, functional design',
      designStyles: [DesignStyle.minimalism, DesignStyle.modern],
      education: existing?.education ?? [],
      portfolioLinks: existing?.portfolioLinks ?? [],
    );
  }
  
  ContractorProfile _buildContractorProfile(ContractorProfile? existing) {
    // This is a simplified example - would need form controllers for these fields
    return ContractorProfile(
      services: [ServiceType.fullConstruction, ServiceType.interiorFitOut],
      equipments: existing?.equipments ?? [],
      certifications: existing?.certifications ?? [],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isCreating ? 'Create Profile' : 'Edit Profile'),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.save, color: Colors.white),
            label: const Text('Save', style: TextStyle(color: Colors.white)),
            onPressed: _isLoading ? null : _saveProfile,
          ),
        ],
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile image
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: _profileImageFile != null
                                ? FileImage(_profileImageFile!)
                                : const AssetImage('assets/images/profile_placeholder.png') as ImageProvider,
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 20,
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt, color: Colors.white),
                                onPressed: _pickImage,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Basic Info Section
                    const Text(
                      'Basic Information',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    
                    TextFormField(
                      controller: _displayNameController,
                      decoration: const InputDecoration(
                        labelText: 'Display Name *',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    
                    TextFormField(
                      controller: _bioController,
                      decoration: const InputDecoration(
                        labelText: 'Bio *',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a bio';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email *',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone *',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        labelText: 'Address *',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Profile Type Dropdown
                    const Text(
                      'Profile Type',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<ProfileType>(
                      value: _selectedProfileType,
                      items: ProfileType.values.map((type) {
                        return DropdownMenuItem<ProfileType>(
                          value: type,
                          child: Text(EnumHelpers.getProfileTypeLabel(type)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedProfileType = value;
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Working Mode Dropdown
                    const Text(
                      'Working Mode',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<WorkingMode>(
                      value: _selectedWorkingMode,
                      items: WorkingMode.values.map((mode) {
                        return DropdownMenuItem<WorkingMode>(
                          value: mode,
                          child: Text(EnumHelpers.getWorkingModeLabel(mode)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedWorkingMode = value;
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Years of Experience Slider
                    const Text(
                      'Years of Experience',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            value: _yearsOfExperience.toDouble(),
                            min: 1,
                            max: 50,
                            divisions: 49,
                            label: _yearsOfExperience.toString(),
                            onChanged: (value) {
                              setState(() {
                                _yearsOfExperience = value.round();
                              });
                            },
                          ),
                        ),
                        Text('$_yearsOfExperience years'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Domains multi-select
                    const Text(
                      'Areas of Expertise',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: Domain.values.map((domain) {
                        final isSelected = _selectedDomains.contains(domain);
                        return FilterChip(
                          label: Text(EnumHelpers.getDomainLabel(domain)),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedDomains.add(domain);
                              } else {
                                _selectedDomains.remove(domain);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    
                    // Based on selected profile type, show different specialized fields
                    // This would be expanded in a full implementation
                    if (_selectedProfileType == ProfileType.architect)
                      _buildArchitectFields(),
                    if (_selectedProfileType == ProfileType.contractor)
                      _buildContractorFields(),
                    // ... other profile types
                    
                    const SizedBox(height: 40),
                    
                    // Save button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          _isLoading 
                              ? 'Saving...' 
                              : (widget.isCreating ? 'Create Profile' : 'Save Changes'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
  
  // These widgets would contain the specialized form fields for each profile type
  Widget _buildArchitectFields() {
    // Simplified example - would contain form fields for architect-specific fields
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Architect Details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text('Add architect-specific fields here'),
        // Additional fields would go here
      ],
    );
  }
  
  Widget _buildContractorFields() {
    // Simplified example - would contain form fields for contractor-specific fields
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contractor Details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text('Add contractor-specific fields here'),
        // Additional fields would go here
      ],
    );
  }
}
