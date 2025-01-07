import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/contributor.dart';
import '../services/analytics_service.dart';

class ContributorsScreen extends StatefulWidget {
  const ContributorsScreen({super.key});

  @override
  _ContributorsScreenState createState() => _ContributorsScreenState();
}

class _ContributorsScreenState extends State<ContributorsScreen> {
  final AnalyticsService _analytics = AnalyticsService();

  @override
  void initState() {
    super.initState();
    _analytics.logScreenView(
      screenName: AnalyticsService.contributorsScreen,
      screenClass: 'ContributorsScreen',
    );
  }

  final List<Contributor> contributors = [
    Contributor(
      name: "Emmanuel Forster",
      department: "Electrical & Electronic Engineering",
      major: "Computer & Electronics Major",
      imagePath: "assets/images/emmanuel.jpg",
      socialLinks: {
        'linkedin': "https://www.linkedin.com/in/emmanuel-forster-3ab072296",
        'github': "https://github.com/Emmie05",
        'twitter': "https://twitter.com/EmmForster",
        'instagram': "https://instagram.com/emm_adams",
      },
    ),
  ];

  Future<void> _launchURL(
      String urlString, String platform, String contributorName) async {
    try {
      final Uri? url = Uri.tryParse(urlString);
      if (url == null) {
        debugPrint('Invalid URL: $urlString');
        return;
      }

      await _analytics.logContributorSocialClick(
        contributorName: contributorName,
        platform: platform,
      );

      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contributors"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: constraints.maxWidth < 600 ? 1 : 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: constraints.maxWidth < 600 ? 1.3 : 1.2,
              ),
              itemCount: contributors.length,
              itemBuilder: (context, index) {
                final contributor = contributors[index];
                return Card(
                  color: Theme.of(context).colorScheme.scrim,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(contributor.imagePath),
                          backgroundColor: Colors.transparent,
                          onBackgroundImageError: (exception, stackTrace) {
                            print(
                                'Error loading image ${contributor.imagePath}: $exception');
                          },
                        ),
                        const SizedBox(height: 10),
                        Text(
                          contributor.name,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.onError,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          contributor.department,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          contributor.major,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        const SizedBox(height: 12),
                        _buildSocialButtons(contributor),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildSocialButtons(Contributor contributor) {
    return Wrap(
      spacing: 6,
      alignment: WrapAlignment.center,
      children: contributor.socialLinks.entries.map((entry) {
        return IconButton(
          icon: Icon(
            _getSocialIcon(entry.key),
            color: _getIconColor(entry.key),
            size: 24,
          ),
          onPressed: () => _launchURL(
            entry.value,
            entry.key,
            contributor.name,
          ),
        );
      }).toList(),
    );
  }

  IconData _getSocialIcon(String platform) {
    switch (platform) {
      case 'twitter':
        return FontAwesomeIcons.twitter;
      case 'facebook':
        return FontAwesomeIcons.facebook;
      case 'github':
        return FontAwesomeIcons.github;
      case 'instagram':
        return FontAwesomeIcons.instagram;
      case 'linkedin':
        return FontAwesomeIcons.linkedin;
      default:
        return Icons.link;
    }
  }

  Color _getIconColor(String platform) {
    switch (platform) {
      case 'twitter':
        return Colors.lightBlue;
      case 'facebook':
        return Colors.blueAccent;
      case 'github':
        return Colors.black;
      case 'instagram':
        return Colors.purple;
      case 'linkedin':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
