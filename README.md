# Daily Quote Application

A Spring Boot application that fetches a daily inspirational quote and displays it through a web interface.

## Features

- Scheduled task to fetch quotes daily at 07:00 AM to 08:00 AM
- Quotes are fetched from the ZenQuotes API
- Responsive JSP-based web interface
- REST API endpoint to access the current quote

## Setup Instructions

### Prerequisites

- Java 17 or higher
- Maven
- Git installed and configured

### Running the Application

1. Clone the repository:
```bash
git clone <repository-url>
cd Daily-Quote-Darshan
```

2. Build the application:
```bash
mvn clean install
```

3. Run the application:
```bash
mvn spring-boot:run
```

4. Access the application:
   - Web interface: http://localhost:8080/

### Configuration

The application can be configured by modifying the `application.properties` file:

- `quote.file.path`: Path where the quote is saved (default: quote.txt)
- `quote.api.url`: URL of the quote API (default: https://zenquotes.io/api/today)
- `quote.schedule.cron`: Schedule for quote fetching (default: 0 0 10 * * *)
- `git.script.path`: Path to the Git script (default: auto_commit.sh)

### Setting up Git Auto-commit

For the Git auto-commit functionality to work properly:

1. Ensure Git is installed and configured on your system
2. If you're using SSH for GitHub authentication, ensure your SSH keys are set up
3. If you're using HTTPS, configure Git credential manager to store your credentials

## Technology Stack

- Spring Boot 3.4.4
- Java 17
- JSP for views
- Maven for dependency management 