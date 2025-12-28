package com.shikhar.seleniuminit;

import com.shikhar.seleniuminit.utils.ReplaceUtils;
import com.shikhar.seleniuminit.utils.ZipUtils;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class ProjectGenerator {

    public static void generate(String projectName) throws Exception {

        Path targetDir = Paths.get(projectName);

        if (Files.exists(targetDir)) {
            throw new RuntimeException("❌ Folder already exists: " + projectName);
        }

        Files.createDirectories(targetDir);

        InputStream zipStream = ProjectGenerator.class
                .getClassLoader()
                .getResourceAsStream("template/selenium-java-template.zip");

        if (zipStream == null) {
            throw new RuntimeException("❌ Template ZIP not found");
        }

        ZipUtils.unzip(zipStream, targetDir);

        ReplaceUtils.replaceAll(targetDir, projectName);
    }
}
