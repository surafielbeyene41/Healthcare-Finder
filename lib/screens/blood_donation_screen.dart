import 'package:flutter/material.dart';
import 'package:healthcare_finder/models/blood_donation_campaign.dart';
import 'package:healthcare_finder/widgets/campaign_card.dart';

class BloodDonationScreen extends StatefulWidget {
  const BloodDonationScreen({super.key});

  @override
  _BloodDonationScreenState createState() => _BloodDonationScreenState();
}

class _BloodDonationScreenState extends State<BloodDonationScreen> {
  final List<BloodDonationCampaign> _campaigns = []; // List of campaigns

  @override
  void initState() {
    super.initState();
    _fetchCampaigns(); // Fetch campaigns from Firestore
  }

  // Fetch campaigns from Firestore (mock data for now)
  Future<void> _fetchCampaigns() async {
    // Replace this with actual Firestore data fetching
    List<BloodDonationCampaign> campaigns = [
      BloodDonationCampaign(
        id: '1',
        title: 'Blood Donation Camp - Addis Ababa',
        location: 'Addis Ababa, Ethiopia',
        date: 'October 20, 2023',
        time: '10:00 AM - 4:00 PM',
        organizer: 'Red Cross',
      ),
      BloodDonationCampaign(
        id: '2',
        title: 'Emergency Blood Drive - Bahir Dar',
        location: 'Bahir Dar, Ethiopia',
        date: 'October 25, 2023',
        time: '9:00 AM - 3:00 PM',
        organizer: 'Ethiopian Blood Bank',
      ),
    ];

    setState(() {
      _campaigns.addAll(campaigns);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Donation Campaigns'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _campaigns.length,
        itemBuilder: (context, index) {
          return CampaignCard(campaign: _campaigns[index]);
        },
      ),
    );
  }
}