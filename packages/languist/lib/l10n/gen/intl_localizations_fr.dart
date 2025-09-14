// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'intl_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class IntlLocalizationsFr extends IntlLocalizations {
  IntlLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'TiDaro';

  @override
  String get greetHello => 'Hello';

  @override
  String greetHelloUser(String userName) {
    return 'Hello $userName';
  }

  @override
  String get greetWelcome => 'Welcome';

  @override
  String get greetWelcomeBack => 'Welcome back';

  @override
  String get greetGoodMorning => 'Good Morning';

  @override
  String get greetGoodAfternoon => 'Good Afternoon';

  @override
  String get greetGoodEvening => 'Good Evening';

  @override
  String get greetGoodbye => 'Goodbye';

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get save => 'Enregistrer';

  @override
  String get delete => 'Supprimer';

  @override
  String get edit => 'Modifier';

  @override
  String get add => 'Ajouter';

  @override
  String get create => 'Créer';

  @override
  String get update => 'Mettre à jour';

  @override
  String get remove => 'Retirer';

  @override
  String get close => 'Fermer';

  @override
  String get open => 'Ouvrir';

  @override
  String get submit => 'Soumettre';

  @override
  String get confirm => 'Confirmer';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get retry => 'Réessayer';

  @override
  String get refresh => 'Actualiser';

  @override
  String get back => 'Retour';

  @override
  String get next => 'Suivant';

  @override
  String get previous => 'Précédent';

  @override
  String get continueAction => 'Continuer';

  @override
  String get skip => 'Ignorer';

  @override
  String get done => 'Terminé';

  @override
  String get finish => 'Finir';

  @override
  String get home => 'Accueil';

  @override
  String get profile => 'Profil';

  @override
  String get settings => 'Paramètres';

  @override
  String get about => 'À propos';

  @override
  String get help => 'Aide';

  @override
  String get contact => 'Contact';

  @override
  String get dashboard => 'Tableau de bord';

  @override
  String get notifications => 'Notifications';

  @override
  String get search => 'Rechercher';

  @override
  String get filter => 'Filtrer';

  @override
  String get sort => 'Trier';

  @override
  String get themeSettings => 'Paramètres du thème';

  @override
  String get languageSettings => 'Paramètres de langue';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get lightMode => 'Mode clair';

  @override
  String get systemMode => 'Mode système';

  @override
  String get privacy => 'Confidentialité';

  @override
  String get security => 'Sécurité';

  @override
  String get account => 'Compte';

  @override
  String get preferences => 'Préférences';

  @override
  String get login => 'Se connecter';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get register => 'S\'inscrire';

  @override
  String get signUp => 'Créer un compte';

  @override
  String get signIn => 'Se connecter';

  @override
  String get forgotPassword => 'Mot de passe oublié';

  @override
  String get resetPassword => 'Réinitialiser le mot de passe';

  @override
  String get changePassword => 'Changer le mot de passe';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get username => 'Nom d\'utilisateur';

  @override
  String get name => 'Nom';

  @override
  String get firstName => 'Prénom';

  @override
  String get lastName => 'Nom de famille';

  @override
  String get phone => 'Téléphone';

  @override
  String get address => 'Adresse';

  @override
  String get city => 'Ville';

  @override
  String get country => 'Pays';

  @override
  String get dateOfBirth => 'Date de naissance';

  @override
  String get loading => 'Chargement...';

  @override
  String get saving => 'Enregistrement...';

  @override
  String get processing => 'Traitement...';

  @override
  String get uploading => 'Téléchargement...';

  @override
  String get downloading => 'Téléchargement...';

  @override
  String get connecting => 'Connexion...';

  @override
  String get syncing => 'Synchronisation...';

  @override
  String get success => 'Succès';

  @override
  String get error => 'Erreur';

  @override
  String get warning => 'Avertissement';

  @override
  String get info => 'Information';

  @override
  String get noData => 'Aucune donnée disponible';

  @override
  String get noResults => 'Aucun résultat trouvé';

  @override
  String get networkError => 'Erreur réseau';

  @override
  String get connectionError => 'Erreur de connexion';

  @override
  String get serverError => 'Erreur serveur';

  @override
  String get unknownError => 'Erreur inconnue';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get required => 'Requis';

  @override
  String get invalidPhoneNumber => 'Numéro de téléphone invalide';

  @override
  String get fieldRequired => 'Ce champ est requis';

  @override
  String fromNow(Object time) {
    return 'il y a $time';
  }

  @override
  String get justNow => 'à l\'instant';

  @override
  String get aMinuteAgo => 'il y a une minute';

  @override
  String minutesAgo(Object minutes) {
    return 'il y a $minutes minutes';
  }

  @override
  String get anHourAgo => 'il y a une heure';

  @override
  String hoursAgo(Object hours) {
    return 'il y a $hours heures';
  }

  @override
  String get aDayAgo => 'il y a un jour';

  @override
  String daysAgo(Object days) {
    return 'il y a $days jours';
  }

  @override
  String get aWeekAgo => 'il y a une semaine';

  @override
  String weeksAgo(Object weeks) {
    return 'il y a $weeks semaines';
  }

  @override
  String get aMonthAgo => 'il y a un mois';

  @override
  String monthsAgo(Object months) {
    return 'il y a $months mois';
  }

  @override
  String get aYearAgo => 'il y a un an';

  @override
  String yearsAgo(Object years) {
    return 'il y a $years ans';
  }

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get yesterday => 'Hier';

  @override
  String get tomorrow => 'Demain';

  @override
  String get thisWeek => 'Cette semaine';

  @override
  String get lastWeek => 'La semaine dernière';

  @override
  String get nextWeek => 'La semaine prochaine';

  @override
  String get thisMonth => 'Ce mois-ci';

  @override
  String get lastMonth => 'Le mois dernier';

  @override
  String get nextMonth => 'Le mois prochain';

  @override
  String get online => 'En ligne';

  @override
  String get offline => 'Hors ligne';

  @override
  String get available => 'Disponible';

  @override
  String get busy => 'Occupé';

  @override
  String get away => 'Absent';

  @override
  String get version => 'Version';

  @override
  String get buildNumber => 'Numéro de build';

  @override
  String get copyright => 'Droits d\'auteur';

  @override
  String get termsOfService => 'Conditions d\'utilisation';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get licenses => 'Licences';

  @override
  String get apply => 'Apply';

  @override
  String get clear => 'Clear';

  @override
  String get customerInfo => 'Customer Information';

  @override
  String get createBooking => 'Create Booking';

  @override
  String get addStaff => 'Add Staff';

  @override
  String get staff => 'Staff';

  @override
  String get activityLog => 'Activity Log';

  @override
  String get searchActivities => 'Search activities...';

  @override
  String get noActivitiesFound => 'No Activities Found';

  @override
  String get noActivitiesFoundDescription =>
      'Try adjusting your search or filter criteria to find activities.';

  @override
  String get filterActivities => 'Filter Activities';

  @override
  String get allActivities => 'All Activities';

  @override
  String get bookingCreated => 'Booking Created';

  @override
  String get bookingConfirmed => 'Booking Confirmed';

  @override
  String get bookingCompleted => 'Booking Completed';

  @override
  String get bookingCancelled => 'Booking Cancelled';

  @override
  String get bookingRescheduled => 'Booking Rescheduled';

  @override
  String get professionalAssigned => 'Professional Assigned';

  @override
  String get professionalUnassigned => 'Professional Unassigned';

  @override
  String get paymentReceived => 'Payment Received';

  @override
  String get reviewSubmitted => 'Review Submitted';

  @override
  String get customerRegistered => 'Customer Registered';

  @override
  String get professionalRegistered => 'Professional Registered';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get userfullName => 'Full Name';

  @override
  String get userEmail => 'Email';

  @override
  String get userPhone => 'Phone';

  @override
  String get userJoined => 'Joined';

  @override
  String get share => 'Partager';

  @override
  String get copy => 'Copier';

  @override
  String get paste => 'Coller';

  @override
  String get cut => 'Couper';

  @override
  String get selectAll => 'Tout sélectionner';

  @override
  String get undo => 'Annuler';

  @override
  String get redo => 'Refaire';

  @override
  String get incrementAction => 'Increment';

  @override
  String get decrementAction => 'Decrement';

  @override
  String itemCount(Object count) {
    return '$count éléments';
  }

  @override
  String selectedCount(Object count) {
    return '$count sélectionnés';
  }

  @override
  String totalCount(Object count) {
    return 'Total : $count';
  }

  @override
  String get appBranding => 'TiDaro Admin';

  @override
  String get welcomeBackMessage => 'Welcome back! Please sign in to continue.';

  @override
  String get createAccount => 'Create an account';

  @override
  String get createAccountSubtitle =>
      'Enter your details below to create your account';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get nameHint => 'Enter your full name';

  @override
  String get createPasswordHint => 'Create a password';

  @override
  String get confirmPasswordHint => 'Confirm your password';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get forgotPasswordQuestion => 'Forgot password?';

  @override
  String get noAccountQuestion => 'Don\'t have an account?';

  @override
  String get haveAccountQuestion => 'Already have an account?';

  @override
  String get resetPasswordTitle => 'Reset Password';

  @override
  String get resetPasswordMessage =>
      'Enter your email address and we\'ll send you a link to reset your password.';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get passwordResetEmailSent => 'Password reset email sent!';

  @override
  String get termsAgreement =>
      'By clicking continue, you agree to our Terms of Service and Privacy Policy.';

  @override
  String get passwordsDontMatch => 'Passwords don\'t match';

  @override
  String get invalidEmail => 'E-mail invalide';

  @override
  String get passwordTooShort => 'Mot de passe trop court';

  @override
  String get bookings => 'Bookings';

  @override
  String get noBookings => 'No Bookings Found';

  @override
  String get noBookingsDescription =>
      'You haven\'t created any bookings yet. Create your first booking to get started.';

  @override
  String get comingSoon => 'Coming Soon';

  @override
  String get viewDetails => 'View Details';

  @override
  String get noStaff => 'No Staff Found';

  @override
  String get noStaffDescription =>
      'You haven\'t added any staff members yet. Add your first staff member to get started.';

  @override
  String get totalBookings => 'Total Bookings';

  @override
  String get activeBookings => 'Active Bookings';

  @override
  String get monthlyRevenue => 'Monthly Revenue';

  @override
  String get activeProfessionals => 'Active Professionals';

  @override
  String get totalCustomers => 'Total Customers';

  @override
  String get totalRevenue => 'Total Revenue';

  @override
  String get makeAvailableButtonLabel => 'Make Available';

  @override
  String get makeUnavailableButtonLabel => 'Make Unavailable';

  @override
  String get staffFiltersAppliedSuccessfully =>
      'Staff filters applied successfully';

  @override
  String get staffFilterByServiceSpecialties => 'Filter by service specialties';

  @override
  String get professionalStatusAvailable => 'Available';

  @override
  String get professionalStatusOnJob => 'On Job';

  @override
  String get professionalStatusOffline => 'Offline';

  @override
  String get professionalStatusOnBreak => 'On Break';

  @override
  String get serviceCategoryRegularCleaning => 'Regular Cleaning';

  @override
  String get serviceCategoryDeepCleaning => 'Deep Cleaning';

  @override
  String get serviceCategoryMoveInOut => 'Move In/Out';

  @override
  String get serviceCategoryPostConstruction => 'Post Construction';

  @override
  String get serviceCategoryCommercial => 'Commercial';

  @override
  String get serviceCategoryStandardCleaning => 'Standard Cleaning';

  @override
  String get serviceCategoryResidential => 'Residential';

  @override
  String get staffFilterRatingRange => 'Rating Range';

  @override
  String get staffFilterRating => 'Rating';

  @override
  String get staffFilterStar => 'star';

  @override
  String get parallaxExampleTitle => 'Parallax Example';

  @override
  String get parallaxBackgroundText => 'Background';

  @override
  String get parallaxMiddleText => 'Middle';

  @override
  String get parallaxForegroundText => 'Foreground';

  @override
  String get parallaxMouseMode => 'Mouse Mode';

  @override
  String get parallaxGyroscopeMode => 'Gyroscope Mode';

  @override
  String get bookingStarted => 'Booking Started';

  @override
  String durationDays(int count) {
    return '$count day';
  }

  @override
  String durationDaysPlural(int count) {
    return '$count days';
  }

  @override
  String durationHours(int count) {
    return '$count hour';
  }

  @override
  String durationHoursPlural(int count) {
    return '$count hours';
  }

  @override
  String durationMinutes(int count) {
    return '$count minute';
  }

  @override
  String durationMinutesPlural(int count) {
    return '$count minutes';
  }

  @override
  String durationSeconds(int count) {
    return '$count second';
  }

  @override
  String durationSecondsPlural(int count) {
    return '$count seconds';
  }

  @override
  String get housekeeping => 'Ménage';

  @override
  String get cleaning => 'Nettoyage';

  @override
  String get housekeeper => 'Femme de ménage';

  @override
  String get cleaner => 'Agent d\'entretien';

  @override
  String get domesticWorker => 'Employé(e) domestique';

  @override
  String get roleClient => 'Client';

  @override
  String get roleProvider => 'Prestataire de services';

  @override
  String get roleAdmin => 'Administrateur';

  @override
  String get roleModerator => 'Modérateur';

  @override
  String get selectRole => 'Sélectionnez votre rôle';

  @override
  String get clientDescription => 'J\'ai besoin de services de ménage';

  @override
  String get providerDescription => 'Je fournis des services de ménage';

  @override
  String get regularCleaning => 'Ménage régulier';

  @override
  String get deepCleaning => 'Grand ménage';

  @override
  String get oneTimeCleaning => 'Ménage ponctuel';

  @override
  String get moveInOutCleaning => 'Ménage de déménagement';

  @override
  String get postConstructionCleaning => 'Nettoyage après travaux';

  @override
  String get officeCleaning => 'Nettoyage de bureaux';

  @override
  String get laundryServices => 'Services de lessive';

  @override
  String get dishWashing => 'Vaisselle';

  @override
  String get windowCleaning => 'Nettoyage de vitres';

  @override
  String get carpetCleaning => 'Nettoyage de tapis';

  @override
  String get postJob => 'Publier une annonce';

  @override
  String get jobRequest => 'Demande de service';

  @override
  String get jobDescription => 'Description du travail';

  @override
  String get serviceNeeded => 'Service demandé';

  @override
  String get preferredDate => 'Date préférée';

  @override
  String get preferredTime => 'Heure préférée';

  @override
  String get estimatedDuration => 'Durée estimée';

  @override
  String get budget => 'Budget';

  @override
  String get budgetRange => 'Fourchette de prix';

  @override
  String get propertySize => 'Taille de la propriété';

  @override
  String get numberOfRooms => 'Nombre de pièces';

  @override
  String get numberOfBathrooms => 'Nombre de salles de bains';

  @override
  String get specialInstructions => 'Instructions spéciales';

  @override
  String get placeBid => 'Faire une offre';

  @override
  String get yourBid => 'Votre offre';

  @override
  String get bidAmount => 'Montant de l\'offre';

  @override
  String get acceptBid => 'Accepter l\'offre';

  @override
  String get rejectBid => 'Rejeter l\'offre';

  @override
  String get counterOffer => 'Contre-offre';

  @override
  String get bidsReceived => 'Offres reçues';

  @override
  String get averageBid => 'Offre moyenne';

  @override
  String get lowestBid => 'Offre la plus basse';

  @override
  String get highestBid => 'Offre la plus haute';

  @override
  String get bidMessage => 'Message d\'offre';

  @override
  String get negotiating => 'En négociation';

  @override
  String get location => 'Localisation';

  @override
  String get serviceArea => 'Zone de service';

  @override
  String get bouskoura => 'Bouskoura';

  @override
  String get casablanca => 'Casablanca';

  @override
  String get nearbyProviders => 'Prestataires à proximité';

  @override
  String kmAway(double distance) {
    return 'À $distance km';
  }

  @override
  String get cashOnDelivery => 'Paiement à la livraison';

  @override
  String get payInCash => 'Payer en espèces';

  @override
  String get paymentMethod => 'Mode de paiement';

  @override
  String get pricePerHour => 'Prix par heure';

  @override
  String get totalPrice => 'Prix total';

  @override
  String get moroccanDirham => 'Dirham Marocain (MAD)';

  @override
  String get mad => 'MAD';

  @override
  String get providerProfile => 'Profil du prestataire';

  @override
  String get yearsOfExperience => 'Années d\'expérience';

  @override
  String get verified => 'Vérifié';

  @override
  String get unverified => 'Non vérifié';

  @override
  String get verificationPending => 'Vérification en cours';

  @override
  String get idVerification => 'Vérification d\'identité';

  @override
  String get uploadId => 'Télécharger une pièce d\'identité';

  @override
  String get cnie => 'CNIE (Carte d\'identité nationale)';

  @override
  String get passport => 'Passeport';

  @override
  String get rating => 'Note';

  @override
  String get reviews => 'Avis';

  @override
  String get rateService => 'Noter ce service';

  @override
  String get writeReview => 'Écrire un avis';

  @override
  String get serviceRating => 'Note du service';

  @override
  String get wouldRecommend => 'Recommanderait';

  @override
  String get excellent => 'Excellent';

  @override
  String get good => 'Bon';

  @override
  String get average => 'Moyen';

  @override
  String get poor => 'Mauvais';

  @override
  String get selectUserRole => 'Sélectionnez votre rôle';

  @override
  String get selectUserRoleDescription =>
      'Choisissez comment vous comptez utiliser Tidaro';

  @override
  String get roleClientConsumer => 'J\'ai besoin de services';

  @override
  String get roleClientConsumerDescription =>
      'Réservez des services de ménage pour votre domicile';

  @override
  String get roleClientProfessional => 'Je fournis des services';

  @override
  String get roleClientProfessionalDescription =>
      'Offrez des services de ménage aux clients';

  @override
  String get dashboardNavigationKyc => 'KYC';

  @override
  String get dashboardNavigationBookings => 'Bookings';

  @override
  String get dashboardNavigationUsers => 'Users';
}
