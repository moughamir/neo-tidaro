// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'intl_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class IntlLocalizationsEs extends IntlLocalizations {
  IntlLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'TiDaro';

  @override
  String get hello => 'Hola';

  @override
  String helloUser(Object userName) {
    return 'Hola $userName';
  }

  @override
  String get welcome => 'Bienvenido';

  @override
  String get welcomeBack => 'Bienvenido de vuelta';

  @override
  String get goodbye => 'Adiós';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get edit => 'Editar';

  @override
  String get add => 'Añadir';

  @override
  String get create => 'Crear';

  @override
  String get update => 'Actualizar';

  @override
  String get remove => 'Quitar';

  @override
  String get close => 'Cerrar';

  @override
  String get open => 'Abrir';

  @override
  String get submit => 'Enviar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get retry => 'Reintentar';

  @override
  String get refresh => 'Actualizar';

  @override
  String get back => 'Atrás';

  @override
  String get next => 'Siguiente';

  @override
  String get previous => 'Anterior';

  @override
  String get continueAction => 'Continuar';

  @override
  String get skip => 'Omitir';

  @override
  String get done => 'Hecho';

  @override
  String get finish => 'Finalizar';

  @override
  String get home => 'Inicio';

  @override
  String get profile => 'Perfil';

  @override
  String get settings => 'Ajustes';

  @override
  String get about => 'Acerca de';

  @override
  String get help => 'Ayuda';

  @override
  String get contact => 'Contacto';

  @override
  String get dashboard => 'Panel de control';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get search => 'Buscar';

  @override
  String get filter => 'Filtrar';

  @override
  String get sort => 'Ordenar';

  @override
  String get themeSettings => 'Ajustes de tema';

  @override
  String get languageSettings => 'Ajustes de idioma';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get lightMode => 'Modo claro';

  @override
  String get systemMode => 'Modo del sistema';

  @override
  String get privacy => 'Privacidad';

  @override
  String get security => 'Seguridad';

  @override
  String get account => 'Cuenta';

  @override
  String get preferences => 'Preferencias';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get register => 'Registrarse';

  @override
  String get signUp => 'Crear cuenta';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get forgotPassword => 'Olvidé mi contraseña';

  @override
  String get resetPassword => 'Restablecer contraseña';

  @override
  String get changePassword => 'Cambiar contraseña';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get username => 'Nombre de usuario';

  @override
  String get name => 'Nombre';

  @override
  String get firstName => 'Nombre';

  @override
  String get lastName => 'Apellido';

  @override
  String get phone => 'Teléfono';

  @override
  String get address => 'Dirección';

  @override
  String get city => 'Ciudad';

  @override
  String get country => 'País';

  @override
  String get dateOfBirth => 'Fecha de nacimiento';

  @override
  String get loading => 'Cargando...';

  @override
  String get saving => 'Guardando...';

  @override
  String get processing => 'Procesando...';

  @override
  String get uploading => 'Subiendo...';

  @override
  String get downloading => 'Descargando...';

  @override
  String get connecting => 'Conectando...';

  @override
  String get syncing => 'Sincronizando...';

  @override
  String get success => 'Éxito';

  @override
  String get error => 'Error';

  @override
  String get warning => 'Advertencia';

  @override
  String get info => 'Información';

  @override
  String get noData => 'No hay datos disponibles';

  @override
  String get noResults => 'No se encontraron resultados';

  @override
  String get networkError => 'Error de red';

  @override
  String get connectionError => 'Error de conexión';

  @override
  String get serverError => 'Error del servidor';

  @override
  String get unknownError => 'Error desconocido';

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get required => 'Requerido';

  @override
  String get invalidEmail => 'Correo electrónico inválido';

  @override
  String get passwordTooShort => 'Contraseña muy corta';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get invalidPhoneNumber => 'Número de teléfono inválido';

  @override
  String get fieldRequired => 'Este campo es requerido';

  @override
  String fromNow(Object time) {
    return 'hace $time';
  }

  @override
  String get justNow => 'ahora mismo';

  @override
  String get aMinuteAgo => 'hace un minuto';

  @override
  String minutesAgo(Object minutes) {
    return 'hace $minutes minutos';
  }

  @override
  String get anHourAgo => 'hace una hora';

  @override
  String hoursAgo(Object hours) {
    return 'hace $hours horas';
  }

  @override
  String get aDayAgo => 'hace un día';

  @override
  String daysAgo(Object days) {
    return 'hace $days días';
  }

  @override
  String get aWeekAgo => 'hace una semana';

  @override
  String weeksAgo(Object weeks) {
    return 'hace $weeks semanas';
  }

  @override
  String get aMonthAgo => 'hace un mes';

  @override
  String monthsAgo(Object months) {
    return 'hace $months meses';
  }

  @override
  String get aYearAgo => 'hace un año';

  @override
  String yearsAgo(Object years) {
    return 'hace $years años';
  }

  @override
  String get today => 'Hoy';

  @override
  String get yesterday => 'Ayer';

  @override
  String get tomorrow => 'Mañana';

  @override
  String get thisWeek => 'Esta semana';

  @override
  String get lastWeek => 'La semana pasada';

  @override
  String get nextWeek => 'La próxima semana';

  @override
  String get thisMonth => 'Este mes';

  @override
  String get lastMonth => 'El mes pasado';

  @override
  String get nextMonth => 'El próximo mes';

  @override
  String get online => 'En línea';

  @override
  String get offline => 'Desconectado';

  @override
  String get available => 'Disponible';

  @override
  String get busy => 'Ocupado';

  @override
  String get away => 'Ausente';

  @override
  String get version => 'Versión';

  @override
  String get buildNumber => 'Número de compilación';

  @override
  String get copyright => 'Derechos de autor';

  @override
  String get termsOfService => 'Términos de servicio';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get licenses => 'Licencias';

  @override
  String get share => 'Compartir';

  @override
  String get copy => 'Copiar';

  @override
  String get paste => 'Pegar';

  @override
  String get cut => 'Cortar';

  @override
  String get selectAll => 'Seleccionar todo';

  @override
  String get undo => 'Deshacer';

  @override
  String get redo => 'Rehacer';

  @override
  String get incrementAction => 'Increment';

  @override
  String get decrementAction => 'Decrement';

  @override
  String itemCount(Object count) {
    return '$count elementos';
  }

  @override
  String selectedCount(Object count) {
    return '$count seleccionados';
  }

  @override
  String totalCount(Object count) {
    return 'Total: $count';
  }
}
