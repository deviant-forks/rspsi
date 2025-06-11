{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Java 21 LTS (compatible with JavaFX 19+)
    openjdk21
    
    # Gradle (version 8.x - compatible with Java 21)
    gradle_8
    
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
    echo "Updated to Java 21 LTS with JavaFX 21 support"
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
    export JAVA_HOME="${pkgs.openjdk21}/lib/openjdk"
    
    # Ensure gradle uses the correct Java version
    export GRADLE_OPTS="-Dorg.gradle.java.home=$JAVA_HOME"
  '';
}