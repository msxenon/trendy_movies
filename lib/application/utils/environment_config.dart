class EnvironmentConfig {
  static const apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: 'AIzaSyBFoVpN4z9xP1jB-VtepwxuZ_31OMrhzpk',
  );
  static const projectId = String.fromEnvironment(
    'PROJECT_ID',
    defaultValue: 'trendy-movies',
  );
  static const authDomain = String.fromEnvironment(
    'AUTH_DOMAIN',
    defaultValue: 'trendy-movies.firebaseapp.com',
  );
  static const storageBucket = String.fromEnvironment(
    'STORAGE_BUCKET',
    defaultValue: 'trendy-movies.appspot.com',
  );
  static const messagingSenderId = String.fromEnvironment(
    'MESSAGING_SENDER_ID',
    defaultValue: '169820721988',
  );
  static const measurementId = String.fromEnvironment(
    'MEASUREMENT_ID',
    defaultValue: 'G-DXEMP13C9W',
  );
  static const appId = String.fromEnvironment(
    'MEASUREMENT_ID',
    defaultValue: '1:169820721988:web:fb14232dd5e149d4f23d11',
  );
  static const theMovieDbApiKey = String.fromEnvironment(
    'THE_MOVIEDB_API_KEY',
    defaultValue: '269cf15030b5a2d4f1a34c35b720202f',
  );
}
