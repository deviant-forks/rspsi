{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Java 8 (required by the project)
    openjdk8
    
    # Gradle (version 7.x - compatible with Java 8, replacing removed gradle_6)
    gradle_7
    
    # Git for version control
    git
    
    # Common development tools
    which
    curl
    wget
  ];

  shellHook = ''
    echo "RSPSi Java Development Environment"
    echo "================================="
    echo "Java version: $(java -version 2>&1 | head -n 1)"
    echo "Gradle version: $(gradle --version | grep Gradle | head -n 1)"
    echo ""
    echo "Available commands:"
    echo "  gradle build          - Build the project"
    echo "  gradle clean          - Clean build artifacts"
    echo "  gradle run            - Run the application"
    echo "  gradle tasks          - Show available tasks"
    echo ""
    echo "Project modules:"
    echo "  - Client"
    echo "  - Editor" 
    echo "  - Plugins (with many sub-plugins)"
    echo "  - RS-Cache-Library"
    echo ""
    
    # Set JAVA_HOME for consistency
    export JAVA_HOME="${pkgs.openjdk8}/lib/openjdk"
    
    # Ensure gradle uses the correct Java version
    export GRADLE_OPTS="-Dorg.gradle.java.home=$JAVA_HOME"
  '';
}