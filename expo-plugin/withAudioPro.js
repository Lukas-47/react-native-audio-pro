// Expo config plugin for react-native-audio-pro
const withAudioPro = (config) => {
	// Add iOS background audio mode
	if (!config.ios) config.ios = {};
	if (!config.ios.infoPlist) config.ios.infoPlist = {};

	config.ios.infoPlist.UIBackgroundModes = [
		...(config.ios.infoPlist.UIBackgroundModes || []),
		'audio',
	];

	// Add Android foreground service permission
	if (!config.android) config.android = {};
	if (!config.android.permissions) config.android.permissions = [];

	config.android.permissions.push('android.permission.FOREGROUND_SERVICE');

	return config;
};

module.exports = withAudioPro;
