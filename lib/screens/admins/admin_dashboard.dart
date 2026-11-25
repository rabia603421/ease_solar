import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';

import '../../core/services/auth_controller.dart';

const _navy = Color(0xFF0A2342);
const _gold = Color(0xFFFFB800);
const _bg = Color(0xFFF4F6FA);

/// Is width se upar sidebar hamesha nazar aayega (desktop),
/// neeche drawer (mobile / tablet).
const double _desktopBreakpoint = 900;

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);
}

const _navItems = <_NavItem>[
  _NavItem(Icons.dashboard_rounded, 'Dashboard'),
  _NavItem(Icons.solar_power, 'Solar Plants'),
  _NavItem(Icons.bolt, 'Energy'),
  _NavItem(Icons.people_alt_rounded, 'Customers'),
  _NavItem(Icons.bar_chart_rounded, 'Reports'),
  _NavItem(Icons.settings, 'Settings'),
];

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selected = 0;

  void _logout() {
    Get.find<AuthController>().logout();
    Get.offAllNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= _desktopBreakpoint;

    return Scaffold(
      backgroundColor: _bg,
      appBar: isDesktop
          ? null
          : AppBar(
              backgroundColor: _navy,
              iconTheme: const IconThemeData(color: Colors.white),
              title: Text(_navItems[_selected].label,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: _gold,
                    child: Icon(Icons.person, color: _navy, size: 20),
                  ),
                ),
              ],
            ),
      drawer: isDesktop
          ? null
          : Drawer(
              backgroundColor: _navy,
              child: _Sidebar(
                selected: _selected,
                onSelect: (i) {
                  setState(() => _selected = i);
                  Navigator.of(context).pop(); // drawer band
                },
                onLogout: _logout,
              ),
            ),
      body: Row(
        children: [
          if (isDesktop)
            SizedBox(
              width: 260,
              child: _Sidebar(
                selected: _selected,
                onSelect: (i) => setState(() => _selected = i),
                onLogout: _logout,
              ),
            ),
          Expanded(
            child: _selected == 0
                ? _DashboardContent(isDesktop: isDesktop)
                : _ComingSoon(item: _navItems[_selected]),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── SIDEBAR ─────────────────────────

class _Sidebar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;
  final VoidCallback onLogout;

  const _Sidebar({required this.selected, required this.onSelect, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _navy,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              child: Row(
                children: [
                  Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(color: _gold, borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.solar_power, color: _navy, size: 26),
                  ),
                  const SizedBox(width: 12),
                  const Text('SolarEase',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _navItems.length,
                itemBuilder: (_, i) {
                  final item = _navItems[i];
                  final active = i == selected;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Material(
                      color: active ? _gold : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => onSelect(i),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                          child: Row(
                            children: [
                              Icon(item.icon, size: 22, color: active ? _navy : Colors.white70),
                              const SizedBox(width: 14),
                              Text(
                                item.label,
                                style: TextStyle(
                                  color: active ? _navy : Colors.white70,
                                  fontWeight: active ? FontWeight.bold : FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(color: Colors.white12, height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: _gold,
                    child: Icon(Icons.person, color: _navy),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Admin', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Text(AuthController.adminEmail,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white54, fontSize: 11)),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Logout',
                    icon: const Icon(Icons.logout, color: _gold),
                    onPressed: onLogout,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── DASHBOARD CONTENT ─────────────────────────

class _StatData {
  final IconData icon;
  final String title;
  final String value;
  final String change;
  final Color color;
  const _StatData(this.icon, this.title, this.value, this.change, this.color);
}

const _stats = <_StatData>[
  _StatData(Icons.bolt, 'Total Energy', '12.4 MWh', '+8.2% this week', Color(0xFFFFB800)),
  _StatData(Icons.solar_power, 'Active Plants', '24 / 26', '98% uptime', Color(0xFF2E9E5B)),
  _StatData(Icons.savings_rounded, 'Total Savings', 'Rs 184,500', '+12% this month', Color(0xFF2F80ED)),
  _StatData(Icons.warning_amber_rounded, 'Alerts', '3', '2 need attention', Color(0xFFE5484D)),
];

class _DashboardContent extends StatelessWidget {
  final bool isDesktop;
  const _DashboardContent({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final pad = isDesktop ? 28.0 : 16.0;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(pad),
        child: LayoutBuilder(
          builder: (context, c) {
            final w = c.maxWidth;
            const gap = 16.0;

            // 4 cards desktop, 2 tablet/mobile, 1 bohat chhoti screen
            final cols = w >= 760 ? 4 : (w >= 340 ? 2 : 1);
            final cardW = (w - gap * (cols - 1)) / cols;
            final wide = w >= 800; // chart + plants side by side

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isDesktop) ...[
                  Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dashboard',
                                style: TextStyle(color: _navy, fontSize: 26, fontWeight: FontWeight.bold)),
                            SizedBox(height: 2),
                            Text('Welcome back, Admin', style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ] else ...[
                  const Text('Welcome back, Admin', style: TextStyle(color: Colors.black54, fontSize: 15)),
                  const SizedBox(height: 14),
                ],
                Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: _stats.map((s) => _StatCard(data: s, width: cardW)).toList(),
                ),
                const SizedBox(height: 24),
                if (wide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Expanded(flex: 3, child: _EnergyChart()),
                      SizedBox(width: 16),
                      Expanded(flex: 2, child: _PlantsList()),
                    ],
                  )
                else
                  const Column(
                    children: [
                      _EnergyChart(),
                      SizedBox(height: 16),
                      _PlantsList(),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final _StatData data;
  final double width;
  const _StatCard({required this.data, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: data.color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(data.icon, color: data.color, size: 22),
          ),
          const SizedBox(height: 14),
          Text(data.title, style: const TextStyle(color: Colors.black54, fontSize: 13)),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(data.value,
                style: const TextStyle(color: _navy, fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 6),
          Text(data.change, style: TextStyle(color: data.color, fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  final String title;
  final Widget child;
  const _Panel({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: _navy, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _EnergyChart extends StatelessWidget {
  const _EnergyChart();

  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static const _values = [320, 410, 380, 450, 520, 480, 560];

  @override
  Widget build(BuildContext context) {
    final maxV = _values.reduce((a, b) => a > b ? a : b);

    return _Panel(
      title: 'Weekly Energy (kWh)',
      child: SizedBox(
        height: 190,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(_values.length, (i) {
            final h = 130 * _values[i] / maxV;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('${_values[i]}', style: const TextStyle(fontSize: 11, color: Colors.black54)),
                    const SizedBox(height: 4),
                    Container(
                      height: h,
                      decoration: BoxDecoration(
                        color: i == _values.length - 1 ? _gold : _navy,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(_days[i], style: const TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _PlantsList extends StatelessWidget {
  const _PlantsList();

  static const _plants = [
    ['Plant A - Lahore', '4.2 kW', true],
    ['Plant B - Kamoke', '3.8 kW', true],
    ['Plant C - Gujranwala', '2.1 kW', true],
    ['Plant D - Sheikhupura', '0 kW', false],
  ];

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'Plants Status',
      child: Column(
        children: _plants.map((p) {
          final online = p[2] as bool;
          final color = online ? const Color(0xFF2E9E5B) : const Color(0xFFE5484D);
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              children: [
                Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.solar_power, color: color, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p[0] as String,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: _navy, fontWeight: FontWeight.w600)),
                      Text(p[1] as String, style: const TextStyle(color: Colors.black54, fontSize: 12)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(online ? 'Online' : 'Offline',
                      style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          );
          }).toList(),
        ),
      );
  }
}

// ───────────────────────── OTHER SECTIONS (placeholder) ─────────────────────────

class _ComingSoon extends StatelessWidget {
  final _NavItem item;
  const _ComingSoon({required this.item});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(item.icon, size: 56, color: _navy.withValues(alpha: 0.35)),
          const SizedBox(height: 12),
          Text(item.label, style: const TextStyle(color: _navy, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('Ye section jald banega', style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}
