package com.shikhar.seleniuminit;

public class Main {
    public static void main(String[] args) {

        if (args.length == 0 || args[0].equals("--help") || args[0].equals("-h")) {
            System.out.println("Project name missing");
            System.out.println("Usage: selenium-init <project-name>");
            return;
        }

        String projectName = args[0];

        try {
            ProjectGenerator.generate(projectName);
            System.out.println("Selenium framework created successfully!");
            System.out.println("Next steps:");
            System.out.println("cd " + projectName);
            System.out.println("mvn test");
        } catch (Exception e) {
            System.out.println("Failed to create project");
            e.printStackTrace();
        }

    }
}