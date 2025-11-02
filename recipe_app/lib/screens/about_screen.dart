import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/app_state.dart';
import '../utils/translations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          appStrings[AppState.language]!['about_title']!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App Name
            Text(
              appStrings[AppState.language]!['app_name']!,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            // Version
            Text(
              appStrings[AppState.language]!['version']!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 24),

            // App Description
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                appStrings[AppState.language]!['app_description']!,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 40),

            // Features Section
            _buildSectionTitle(
              appStrings[AppState.language]!['features_title']!,
              Icons.star_rounded,
            ),

            const SizedBox(height: 20),

            ..._buildFeaturesList(),

            const SizedBox(height: 40),

            // Developer Section - Avatar
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'ML',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Developer Name & Title
            Text(
              appStrings[AppState.language]!['developer_name']!,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              appStrings[AppState.language]!['developer_title']!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // Developer Bio
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Text(
                    appStrings[AppState.language]!['developer_bio_1']!,
                    style: const TextStyle(fontSize: 15, height: 1.6),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    appStrings[AppState.language]!['developer_bio_2']!,
                    style: const TextStyle(fontSize: 15, height: 1.6),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // About Me Section
            _buildSectionTitle(
              appStrings[AppState.language]!['about_me_title']!,
              Icons.person_rounded,
            ),

            const SizedBox(height: 16),

            _buildAboutMeText(
              appStrings[AppState.language]!['about_me_text_1']!,
            ),

            const SizedBox(height: 12),

            _buildAboutMeText(
              appStrings[AppState.language]!['about_me_text_2']!,
            ),

            const SizedBox(height: 12),

            _buildAboutMeText(
              appStrings[AppState.language]!['about_me_text_3']!,
            ),

            const SizedBox(height: 30),

            // Skills Section
            _buildSectionTitle(
              appStrings[AppState.language]!['skills_title']!,
              Icons.code_rounded,
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: _buildSkillChips(),
            ),

            const SizedBox(height: 40),

            // Projects Section
            _buildSectionTitle(
              appStrings[AppState.language]!['projects_title']!,
              Icons.work_rounded,
            ),

            const SizedBox(height: 20),

            ..._buildProjectCards().map((card) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: card,
              );
            }).toList(),

            const SizedBox(height: 30),

            // Contact Section
            _buildSectionTitle(
              appStrings[AppState.language]!['contact_title']!,
              Icons.contact_mail_rounded,
            ),

            const SizedBox(height: 16),

            Text(
              appStrings[AppState.language]!['contact_text']!,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade700,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // Contact Links
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildContactButton(
                  Icons.email_rounded,
                  appStrings[AppState.language]!['contact_email']!,
                  'mailto:minhle@example.com',
                ),
                const SizedBox(width: 12),
                _buildContactButton(
                  Icons.code_rounded,
                  appStrings[AppState.language]!['contact_github']!,
                  'https://github.com/minhleeee123',
                ),
                const SizedBox(width: 12),
                _buildContactButton(
                  Icons.facebook_rounded,
                  appStrings[AppState.language]!['contact_facebook']!,
                  'https://www.facebook.com/minh.le.187327',
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Footer
            Text(
              appStrings[AppState.language]!['made_with_love']!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 28),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildFeaturesList() {
    final features = [
      (Icons.language, 'feature_1'),
      (Icons.edit_note, 'feature_2'),
      (Icons.favorite, 'feature_3'),
      (Icons.devices, 'feature_4'),
      (Icons.search, 'feature_5'),
    ];

    return features.map((feature) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Row(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.black,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                appStrings[AppState.language]![feature.$2]!,
                style: const TextStyle(fontSize: 15, height: 1.4),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildAboutMeText(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, height: 1.6),
        textAlign: TextAlign.justify,
      ),
    );
  }

  List<Widget> _buildSkillChips() {
    final skills = [
      'React',
      'Node.js',
      'TypeScript',
      'Python',
      'PostgreSQL',
      'MongoDB',
      'Docker',
      'Git',
      'REST APIs',
      'GraphQL',
      'TailwindCSS',
      'AWS'
    ];

    return skills.map((skill) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          skill,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildProjectCards() {
    final projects = [
      ('project_1_title', 'project_1_desc', 'project_1_tech'),
      ('project_2_title', 'project_2_desc', 'project_2_tech'),
      ('project_3_title', 'project_3_desc', 'project_3_tech'),
    ];

    return projects.map((project) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appStrings[AppState.language]![project.$1]!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              appStrings[AppState.language]![project.$2]!,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                appStrings[AppState.language]![project.$3]!,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildContactButton(IconData icon, String label, String url) {
    return Builder(
      builder: (context) => InkWell(
        onTap: () => _launchUrl(url),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
