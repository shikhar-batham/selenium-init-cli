package com.shikhar.seleniuminit.utils;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

public class ZipUtils {

    public static void unzip(InputStream zipStream, Path targetDir) throws IOException {

        try (ZipInputStream zis = new ZipInputStream(zipStream)) {
            ZipEntry entry;

            while ((entry = zis.getNextEntry()) != null) {
                Path newPath = targetDir.resolve(entry.getName());

                if (entry.isDirectory()) {
                    Files.createDirectories(newPath);
                } else {
                    Files.createDirectories(newPath.getParent());
                    Files.copy(zis, newPath, StandardCopyOption.REPLACE_EXISTING);
                }
            }
        }
    }
}
