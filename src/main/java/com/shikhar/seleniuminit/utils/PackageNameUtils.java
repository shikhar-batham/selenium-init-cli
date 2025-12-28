package com.shikhar.seleniuminit.utils;

public class PackageNameUtils {

    public static String buildBasePackage(String projectName) {
        String cleanName = projectName
                .toLowerCase()
                .replace("-", "")
                .replace("_", "");

        return "com.selenium." + cleanName;
    }

    public static String toPath(String packageName) {
        return packageName.replace(".", "/");
    }
}
