import 'package:flutter/material.dart';

// ─────────────────────────── Цвета (розово-фиолетовая палитра) ───────────────────────────
const Color kPink = Color(0xFFE754B5);
const Color kPinkDeep = Color(0xFF9B3FD1);
const Color kPinkSoft = Color(0xFFF4A8E0);
const Color kPinkPale = Color(0xFFFCEFFB);
const Color kPinkLight = Color(0xFFF7D6F2);
const Color kLilac = Color(0xFFC9A7F5);
const Color kMint = Color(0xFFE3D6FB);
const Color kText = Color(0xFF3B1F4A);
const Color kGrey = Color(0xFF9C8AA8);

const List<BoxShadow> kSoftShadow = [
  BoxShadow(color: Color(0x1AB03AA8), blurRadius: 16, offset: Offset(0, 6)),
];

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pink UI Kit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primaryColor: kPink,
        scaffoldBackgroundColor: kPinkPale,
        colorScheme: const ColorScheme.light(primary: kPink, secondary: kPinkDeep),
      ),
      home: const RootPage(),
    );
  }
}

// ─────────────────────────── Корневой экран ───────────────────────────
class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    WelcomeScreen(),
    TasksScreen(),
    WalletScreen(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPinkPale,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: IndexedStack(index: _currentIndex, children: _screens),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: kPink,
        unselectedItemColor: kGrey,
        selectedFontSize: 11,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.spa_outlined),
            activeIcon: Icon(Icons.spa),
            label: 'Начало',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            activeIcon: Icon(Icons.check_circle),
            label: 'Задания',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            activeIcon: Icon(Icons.account_balance_wallet),
            label: 'Сумочка с деньгами',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── Общие виджеты ───────────────────────────

/// Прозрачный InkWell поверх содержимого: розовая волна при нажатии.
class TapBox extends StatelessWidget {
  const TapBox({super.key, required this.child, this.radius = 16});

  final Widget child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        child,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(radius),
              splashColor: const Color(0x33E754B5),
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }
}

/// Круглая заглушка аватара.
class AvatarBox extends StatelessWidget {
  const AvatarBox({super.key, this.size = 48});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kPinkSoft, kLilac],
        ),
      ),
      child: Icon(Icons.face, size: size * 0.55, color: Colors.white),
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.label,
    required this.icon,
    required this.background,
    required this.foreground,
  });

  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return TapBox(
      radius: 30,
      child: Container(
        height: 50,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: foreground),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: foreground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({super.key, required this.icon, this.badge = false});

  final IconData icon;
  final bool badge;

  @override
  Widget build(BuildContext context) {
    return TapBox(
      radius: 20,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: kSoftShadow,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, size: 20, color: kText),
            if (badge)
              Positioned(
                top: 8,
                right: 9,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: kPink,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: kText,
                ),
              ),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(fontSize: 12, color: kGrey)),
            ],
          ),
        ),
        const Icon(Icons.tune, size: 20, color: kPink),
        Container(
          width: 1,
          height: 20,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          color: kPinkLight,
        ),
        const Icon(Icons.add, size: 22, color: kPink),
      ],
    );
  }
}

class TagChip extends StatelessWidget {
  const TagChip({
    super.key,
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: foreground,
        ),
      ),
    );
  }
}

class AvatarStack extends StatelessWidget {
  const AvatarStack({super.key, required this.extra});

  final int extra;

  Widget _circle(Color color, Widget child) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 28,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: _circle(
              kPinkSoft,
              const Icon(Icons.person, size: 15, color: Colors.white),
            ),
          ),
          Positioned(
            left: 18,
            child: _circle(
              kLilac,
              const Icon(Icons.person, size: 15, color: Colors.white),
            ),
          ),
          Positioned(
            left: 36,
            child: _circle(
              kPink,
              Text(
                '$extra+',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WeeklyTaskCard extends StatelessWidget {
  const WeeklyTaskCard({
    super.key,
    required this.tags,
    required this.title,
    required this.extra,
    required this.date,
  });

  final List<Widget> tags;
  final String title;
  final int extra;
  final String date;

  @override
  Widget build(BuildContext context) {
    return TapBox(
      radius: 22,
      child: Container(
        width: 230,
        height: 200,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: kSoftShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(spacing: 6, runSpacing: 4, children: tags),
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                height: 1.25,
                fontWeight: FontWeight.w700,
                color: kText,
              ),
            ),
            AvatarStack(extra: extra),
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined, size: 14, color: kGrey),
                const SizedBox(width: 6),
                Text(date, style: const TextStyle(fontSize: 12, color: kGrey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TodayTaskCard extends StatelessWidget {
  const TodayTaskCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.extra,
    this.done = false,
  });

  final String title;
  final String subtitle;
  final String date;
  final int extra;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return TapBox(
      radius: 20,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: kSoftShadow,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: done ? kGrey : kText,
                          decoration:
                              done ? TextDecoration.lineThrough : TextDecoration.none,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(fontSize: 12, color: kGrey),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: done ? kPink : Colors.transparent,
                    border: done ? null : Border.all(color: kPinkLight, width: 2),
                  ),
                  child: Icon(
                    Icons.check,
                    size: 16,
                    color: done ? Colors.white : kPinkLight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: kPinkLight),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined, size: 14, color: kGrey),
                const SizedBox(width: 6),
                Text(date, style: const TextStyle(fontSize: 12, color: kGrey)),
                const Spacer(),
                AvatarStack(extra: extra),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.date,
    required this.amount,
    required this.isTopUp,
  });

  final IconData icon;
  final String title;
  final String date;
  final String amount;
  final bool isTopUp;

  @override
  Widget build(BuildContext context) {
    return TapBox(
      radius: 16,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: kPinkLight,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 22, color: kPinkDeep),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: kText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(date, style: const TextStyle(fontSize: 11, color: kGrey)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: kText,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isTopUp ? 'Пополнения' : 'Заказы',
                      style: const TextStyle(fontSize: 11, color: kGrey),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: isTopUp ? kLilac : kPink,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(
                        isTopUp ? Icons.south_west : Icons.north_east,
                        size: 11,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatItem extends StatelessWidget {
  const StatItem({super.key, required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: kText,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: kGrey)),
      ],
    );
  }
}

class PillButton extends StatelessWidget {
  const PillButton({
    super.key,
    required this.label,
    required this.filled,
    this.icon,
    this.compact = false,
  });

  final String label;
  final bool filled;
  final IconData? icon;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final Color fg = filled ? Colors.white : kPink;
    return TapBox(
      radius: 30,
      child: Container(
        height: compact ? 36 : 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: filled
              ? const LinearGradient(colors: [kPink, kPinkDeep])
              : null,
          color: filled ? null : Colors.white,
          border: filled ? null : Border.all(color: kPink, width: 1.4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: fg),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: compact ? 13 : 14,
                fontWeight: FontWeight.w600,
                color: fg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────── Макет 1: Начало ───────────────────────────
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFF8AD8), Color(0xFFD25FE0), Color(0xFF8E4DDB)],
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            left: 40,
            top: 190,
            child: Icon(Icons.favorite, size: 16, color: Color(0x99FFFFFF)),
          ),
          const Positioned(
            right: 36,
            top: 150,
            child: Icon(Icons.favorite, size: 22, color: Color(0x99FFFFFF)),
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 48, 24, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Отдых с душой',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Попробуйте для себя настоящее умиротворение!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Color(0xE6FFFFFF)),
                  ),
                ],
              ),
            ),
          ),
          // кнопки строго по центру экрана
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AuthButton(
                    label: 'Войти с Apple',
                    icon: Icons.apple,
                    background: Colors.white,
                    foreground: kText,
                  ),
                  SizedBox(height: 12),
                  AuthButton(
                    label: 'Продолжить с почтой или номером телефона',
                    icon: Icons.mail_outline,
                    background: Color(0xFFF7D6F2),
                    foreground: kPinkDeep,
                  ),
                  SizedBox(height: 12),
                  AuthButton(
                    label: 'Продолжить с Googoogaga',
                    icon: Icons.g_mobiledata,
                    background: Color(0x33FFFFFF),
                    foreground: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          // низ: сердечки и звёздочка
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  color: Color(0x33FFFFFF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.favorite, size: 52, color: Colors.white),
              ),
            ),
          ),
          const Positioned(
            left: 20,
            bottom: 24,
            child: Icon(Icons.favorite, size: 40, color: Color(0xCCFFFFFF)),
          ),
          const Positioned(
            right: 20,
            bottom: 24,
            child: Icon(Icons.star_rounded, size: 40, color: Color(0xCCFFFFFF)),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── Макет 2: Задания ───────────────────────────
class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        Row(
          children: [
            const AvatarBox(size: 44),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Вечерочка!', style: TextStyle(fontSize: 12, color: kGrey)),
                  Text(
                    'Скрипка',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: kText,
                    ),
                  ),
                ],
              ),
            ),
            const RoundIconButton(icon: Icons.search),
            const SizedBox(width: 8),
            const RoundIconButton(icon: Icons.notifications_none, badge: true),
          ],
        ),
        const SizedBox(height: 22),
        const SectionHeader(title: 'Еженедельные задания', subtitle: 'их оч много'),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              WeeklyTaskCard(
                tags: [
                  TagChip(label: 'Обед', background: kMint, foreground: kPinkDeep),
                  TagChip(label: 'Важно', background: kPinkLight, foreground: kPink),
                ],
                title: 'Приготовить\nгороховый суп',
                extra: 3,
                date: 'сегодня',
              ),
              SizedBox(width: 12),
              WeeklyTaskCard(
                tags: [
                  TagChip(label: 'Ужин', background: kPinkLight, foreground: kPinkDeep),
                  TagChip(label: 'Неважно', background: kMint, foreground: kPinkDeep),
                ],
                title: 'Заказать\nсуши/пиццу',
                extra: 2,
                date: 'суббота',
              ),
              SizedBox(width: 12),
              WeeklyTaskCard(
                tags: [
                  TagChip(label: 'Изучение', background: kPinkLight, foreground: kPink),
                  TagChip(label: 'Норм', background: kMint, foreground: kPinkDeep),
                ],
                title: 'Найти\nресторан',
                extra: 5,
                date: 'потом',
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const SectionHeader(title: 'Сегодня дела', subtitle: 'много'),
        const SizedBox(height: 12),
        const TodayTaskCard(
          title: 'Сделать сальто',
          subtitle: 'главное — приземлиться',
          date: 'сегодня',
          extra: 1,
          done: true,
        ),
        const SizedBox(height: 12),
        const TodayTaskCard(
          title: 'Сделать зарядку',
          subtitle: 'для бодрости',
          date: 'каждый день',
          extra: 2,
        ),
      ],
    );
  }
}

// ─────────────────────────── Макет 3: Сумочка с деньгами ───────────────────────────
class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        const Row(
          children: [
            Icon(Icons.account_balance_wallet_outlined, color: kPink, size: 26),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Мои деньги',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: kText,
                ),
              ),
            ),
            RoundIconButton(icon: Icons.search),
            SizedBox(width: 8),
            RoundIconButton(icon: Icons.more_horiz),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          height: 180,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [kPink, kPinkDeep],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x40E754B5),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Скрипка',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Text(
                        'VISA',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 30,
                        height: 20,
                        child: Stack(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xE6FFFFFF),
                              ),
                            ),
                            Positioned(
                              left: 10,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0x99F7D6F2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '•••• •••• •••• 6969',
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 2,
                      color: Color(0xCCFFFFFF),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Баланс',
                    style: TextStyle(fontSize: 12, color: Color(0xCCFFFFFF)),
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          '\$69',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TapBox(
                        radius: 20,
                        child: Container(
                          height: 36,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.credit_card, size: 16, color: kPink),
                              SizedBox(width: 6),
                              Text(
                                'Депнуть',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: kPink,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Row(
          children: [
            const Expanded(
              child: Text(
                'История операций',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: kText,
                ),
              ),
            ),
            TapBox(
              radius: 8,
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Text(
                  'Посмотреть все',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: kPink,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const TransactionTile(
          icon: Icons.music_note,
          title: 'Покупка Скрипки',
          date: 'вчера',
          amount: '\$200',
          isTopUp: false,
        ),
        const TransactionTile(
          icon: Icons.account_balance_wallet,
          title: 'Пополнение',
          date: '16.07.2026 | 10:36',
          amount: '\$67',
          isTopUp: true,
        ),
        const TransactionTile(
          icon: Icons.lightbulb_outline,
          title: 'Ядерный светильник',
          date: '18.07.2026',
          amount: '\$237',
          isTopUp: false,
        ),
        const TransactionTile(
          icon: Icons.table_restaurant,
          title: 'Пикми стол',
          date: '18.07.2026',
          amount: '\$160',
          isTopUp: false,
        ),
        const TransactionTile(
          icon: Icons.account_balance_wallet,
          title: 'Пополнение',
          date: '20.07.2026',
          amount: '\$125',
          isTopUp: true,
        ),
      ],
    );
  }
}

// ─────────────────────────── Макет 4: Профиль ───────────────────────────
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        Row(
          children: [
            TapBox(
              radius: 20,
              child: const Padding(
                padding: EdgeInsets.all(6),
                child: Icon(Icons.arrow_back, color: kPink, size: 22),
              ),
            ),
            const SizedBox(width: 6),
            const Expanded(
              child: Text(
                'Профиль',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: kText,
                ),
              ),
            ),
            TapBox(
              radius: 10,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: kPinkLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.more_vert, color: kPink, size: 20),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Center(child: AvatarBox(size: 96)),
        const SizedBox(height: 12),
        const Center(
          child: Text(
            'Скрипка',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: kText,
            ),
          ),
        ),
        const SizedBox(height: 18),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Expanded(child: StatItem(value: '67', label: 'Подписчиков')),
              Container(width: 1, color: kPinkLight),
              const Expanded(child: StatItem(value: '16', label: 'Подписки')),
              Container(width: 1, color: kPinkLight),
              const Expanded(child: StatItem(value: '69', label: 'События')),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Divider(height: 1, color: kPinkLight),
        const SizedBox(height: 16),
        const Row(
          children: [
            Expanded(
              child: PillButton(
                label: 'Подписаться',
                icon: Icons.person_add_alt_1,
                filled: true,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: PillButton(
                label: 'Сообщения',
                icon: Icons.chat_bubble_outline,
                filled: false,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(height: 1, color: kPinkLight),
        const SizedBox(height: 16),
        const Row(
          children: [
            Expanded(child: PillButton(label: 'О себе', filled: true, compact: true)),
            SizedBox(width: 10),
            Expanded(child: PillButton(label: 'События', filled: false, compact: true)),
            SizedBox(width: 10),
            Expanded(child: PillButton(label: 'Отзывы', filled: false, compact: true)),
          ],
        ),
        const SizedBox(height: 18),
        const Text(
          'About',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kText),
        ),
        const SizedBox(height: 8),
        const Text(
          'Так-так-так, как даня нибудь, 69 69 69 69 69 ВладыкаКартеля69 67',
          style: TextStyle(fontSize: 13, height: 1.6, color: kText),
        ),
        const SizedBox(height: 6),
        const Text(
          'Читать далее...',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: kPink),
        ),
      ],
    );
  }
}
