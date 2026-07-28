import 'package:go_router/go_router.dart';

import '../screens/auth/splash_screen.dart';
import '../screens/auth/welcome_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/auth/forgot_password_screen.dart';

import '../screens/onboarding/connect_bank_screen.dart';
import '../screens/onboarding/import_transactions_screen.dart';
import '../screens/onboarding/user_profile_setup_screen.dart';
import '../screens/onboarding/ai_budget_generation_screen.dart';
import '../screens/onboarding/create_goals_screen.dart';
import '../screens/onboarding/onboarding_complete_screen.dart';

import '../screens/main_shell_screen.dart';
import '../screens/profile/profile_screen.dart';

import '../screens/shared/settings_screen.dart';
import '../screens/shared/premium_screen.dart';
import '../screens/shared/notifications_screen.dart';
import '../screens/shared/add_goal_screen.dart';
import '../screens/shared/transaction_details_screen.dart';
import '../screens/shared/ai_result_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // 1. Splash & Auth Flow
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/welcome', builder: (context, state) => const WelcomeScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/signup', builder: (context, state) => const SignUpScreen()),
      GoRoute(path: '/forgot-password', builder: (context, state) => const ForgotPasswordScreen()),

      // 2. Onboarding Workflow
      GoRoute(path: '/onboarding/connect-bank', builder: (context, state) => const ConnectBankScreen()),
      GoRoute(path: '/onboarding/import-transactions', builder: (context, state) => const ImportTransactionsScreen()),
      GoRoute(path: '/onboarding/user-profile-setup', builder: (context, state) => const UserProfileSetupScreen()),
      GoRoute(path: '/onboarding/ai-budget-generation', builder: (context, state) => const AiBudgetGenerationScreen()),
      GoRoute(path: '/onboarding/create-goals', builder: (context, state) => const CreateGoalsScreen()),
      GoRoute(path: '/onboarding/complete', builder: (context, state) => const OnboardingCompleteScreen()),

      // 3. Main Shell (Bottom Navigation Tabs)
      GoRoute(path: '/home', builder: (context, state) => const MainShellScreen(initialIndex: 0)),
      GoRoute(path: '/transactions', builder: (context, state) => const MainShellScreen(initialIndex: 1)),
      GoRoute(path: '/budget', builder: (context, state) => const MainShellScreen(initialIndex: 2)),
      GoRoute(path: '/goals', builder: (context, state) => const MainShellScreen(initialIndex: 3)),
      GoRoute(path: '/ai', builder: (context, state) => const MainShellScreen(initialIndex: 4)),

      // 4. Shared / Extra Pages
      GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
      GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
      GoRoute(path: '/premium', builder: (context, state) => const PremiumScreen()),
      GoRoute(path: '/notifications', builder: (context, state) => const NotificationsScreen()),
      GoRoute(path: '/add-goal', builder: (context, state) => const AddGoalScreen()),
      GoRoute(
        path: '/transaction-details/:id',
        builder: (context, state) => TransactionDetailsScreen(
          transactionId: state.pathParameters['id'] ?? '',
        ),
      ),
      GoRoute(path: '/ai-result', builder: (context, state) => const AiResultScreen()),
    ],
  );
}
