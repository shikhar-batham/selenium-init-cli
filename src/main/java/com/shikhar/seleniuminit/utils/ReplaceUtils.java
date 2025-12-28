package com.shikhar.seleniuminit.utils;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Set;
import java.util.stream.Stream;
public class ReplaceUtils {

    private static final Set<String> TEXT_EXTENSIONS = Set.of(
            ".java", ".xml", ".properties", ".md", ".txt", ".yml", ".yaml"
    );

    public static void replaceAll(Path root, String projectName) throws IOException {

        String basePackage = PackageNameUtils.buildBasePackage(projectName);

        // 1️⃣ Replace content first
        try (Stream<Path> paths = Files.walk(root)) {
            paths
                    .filter(Files::isRegularFile)
                    .filter(ReplaceUtils::isTextFile)
                    .forEach(path -> {
                        try {
                            String content = Files.readString(path, StandardCharsets.UTF_8);

                            content = content.replace("__PROJECT_NAME__", projectName);
                            content = content.replace("__BASE_PACKAGE__", basePackage);

                            Files.writeString(path, content, StandardCharsets.UTF_8);

                        } catch (IOException e) {
                            throw new RuntimeException("Failed processing file: " + path, e);
                        }
                    });
        }

        // 2️⃣ Rename folders at the end
        FolderRenameUtils.renameBasePackageFolders(root, basePackage);
    }

    private static boolean isTextFile(Path path) {
        String fileName = path.getFileName().toString().toLowerCase();
        return TEXT_EXTENSIONS.stream().anyMatch(fileName::endsWith);
    }
}
