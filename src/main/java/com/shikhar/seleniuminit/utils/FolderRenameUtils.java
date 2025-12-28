package com.shikhar.seleniuminit.utils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
public class FolderRenameUtils {

    public static void renameBasePackageFolders(Path root, String basePackage) throws IOException {

        String packagePath = basePackage.replace(".", File.separator);

        Path templateRoot = root.resolve("selenium-java-template");

        rename(templateRoot.resolve("src/main/java"), packagePath);
        rename(templateRoot.resolve("src/test/java"), packagePath);
    }

    private static void rename(Path javaRoot, String packagePath) throws IOException {

        if (!Files.exists(javaRoot)) return;

        Path basePackageDir = javaRoot.resolve("__BASE_PACKAGE__");
        if (!Files.exists(basePackageDir)) return;

        Path targetDir = javaRoot.resolve(packagePath);

        Files.createDirectories(targetDir.getParent());
        Files.move(basePackageDir, targetDir, StandardCopyOption.REPLACE_EXISTING);
    }
}

