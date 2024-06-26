{
	appimageTools,
	fetchurl,
	versionInfo
}:
appimageTools.wrapType2 {
	pname = "shadow-pc";
	version = versionInfo.version;
	src = fetchurl {
		url = "https://update.shadow.tech/launcher/prod/linux/ubuntu_18.04/${versionInfo.path}";
		hash = "sha512-${versionInfo.sha512}";
	};
}
