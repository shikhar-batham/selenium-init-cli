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

            String rootFolder = null;

            while ((entry = zis.getNextEntry()) != null) {

                String entryName = entry.getName();

                // Detect root folder
                if (rootFolder == null) {
                    rootFolder = entryName.split("/")[0];
                }

                // Remove root folder repeatedly if duplicated
                while (entryName.startsWith(rootFolder + "/")) {
                    entryName = entryName.substring(rootFolder.length() + 1);
                }

                if (entryName.isEmpty()) continue;

                Path newPath = targetDir.resolve(entryName);

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
