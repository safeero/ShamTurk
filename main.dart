import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ShamturScanApp());
}

abstract class CyberColors {
  static const Color background = Color(0xFF080B10);
  static const Color primaryNeon = Color(0xFF00E5FF);
  static const Color secondaryNeon = Color(0xFFFF0055);
  static const Color accentGreen = Color(0xFF00FF66);
  static const Color accentPurple = Color(0xFF9D00FF);
  static const Color cardBg = Color(0xFF101726);
}

class MerchantConfig {
  static const String appName = "ShamturScan";
  static const String workshopName = "ŞAMTUR OTO DIAGNOSTIC & PROGRAMMING";
  static const String location = "Adana / Türkiye";
  static const String accountHolder = "BAKRI ALLABABIDI";
  static const String ibanTR = "TR61 0001 0011 1986 6870 2650 01";
  static const String formattedPhone = "+90 551 151 2102";
}

class ShamturScanApp extends StatelessWidget {
  const ShamturScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: MerchantConfig.appName,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: CyberColors.background,
      ),
      home: const MainDashboardScreen(),
    );
  }
}

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State {
  String _selectedService = 'scan'; // 'scan' or 'programming'

  void _copyToClipboard(String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: CyberColors.accentGreen,
      ),
    );
  }

  void _showProgrammingOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: CyberColors.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.developer_board, color: CyberColors.accentPurple, size: 28),
                SizedBox(width: 10),
                Text(
                  'خدمات برمجة السيارات (ECU Coding)',
                  style: TextStyle(color: CyberColors.primaryNeon, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(color: Colors.white24, height: 25),
            _buildOptionTile(Icons.memory, 'برمجة كمبيوتر المحرك (ECU Tuning / Remap)'),
            _buildOptionTile(Icons.vpn_key, 'برمجة المفاتيح والبصمة (Key Coding)'),
            _buildOptionTile(Icons.build_circle, 'إغلاق ومحي أنظمة (DPF / EGR / AdBlue Off)'),
            _buildOptionTile(Icons.settings_input_component, 'تعيير الحساسات وتكويد القطع والأعطال'),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: CyberColors.accentPurple),
                onPressed: () => Navigator.pop(context),
                child: const Text('بدء عملية البرمجة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: CyberColors.accentGreen, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(title, style: const TextStyle(color: Colors.white70, fontSize: 13))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CyberColors.cardBg,
        elevation: 4,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              MerchantConfig.appName,
              style: TextStyle(color: CyberColors.primaryNeon, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              MerchantConfig.workshopName,
              style: TextStyle(color: Colors.white54, fontSize: 9),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // اختيار نوع الخدمة (فحص / برمجة)
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: CyberColors.cardBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: CyberColors.primaryNeon.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedService = 'scan'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedService == 'scan' ? CyberColors.primaryNeon : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'فحص تشخيصي',
                            style: TextStyle(
                              color: _selectedService == 'scan' ? Colors.black : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedService = 'programming'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedService == 'programming' ? CyberColors.accentPurple : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'برمجة سيارات',
                            style: TextStyle(
                              color: _selectedService == 'programming' ? Colors.white : Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // بطاقة بيانات البنك والدعم
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CyberColors.cardBg,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: CyberColors.accentGreen, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('صاحب الحساب المعتمد:', style: TextStyle(color: Colors.white54, fontSize: 11)),
                  const Text(
                    MerchantConfig.accountHolder,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text('رقم الـ IBAN:', style: TextStyle(color: Colors.white54, fontSize: 11)),
                  Row(
                    children: [
                      const Expanded(
                        child: SelectableText(
                          MerchantConfig.ibanTR,
                          style: TextStyle(color: CyberColors.accentGreen, fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy, color: Colors.white, size: 18),
                        onPressed: () => _copyToClipboard(MerchantConfig.ibanTR, 'تم نسخ رقم الـ IBAN!'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            // زر التنفيذ حسب الخيار المحدد
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedService == 'scan' ? CyberColors.primaryNeon : CyberColors.accentPurple,
                foregroundColor: _selectedService == 'scan' ? Colors.black : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                if (_selectedService == 'programming') {
                  _showProgrammingOptions();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('جاري بدء الفحص الشامل للسيارة...'),
                      backgroundColor: CyberColors.primaryNeon,
                    ),
                  );
                }
              },
              icon: Icon(_selectedService == 'scan' ? Icons.qr_code_scanner : Icons.developer_board, size: 24),
              label: Text(
                _selectedService == 'scan' ? 'بدء فحص جديد (Diagnostic Scan)' : 'خيارات برمجة السيارات (ECU Coding)',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
