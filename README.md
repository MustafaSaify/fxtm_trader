# fxtm_trader

This project is a Flutter-based application following the principles of **Clean Architecture** and leveraging the **BLoC (Business Logic Component)** pattern for state management. It consists of two primary modules:

1. **Forex List**:
   - Fetches a list of symbols using the [Finnhub API](https://finnhub.io/).
   - Updates live prices using socket connections.

2. **Forex History**:
   - Displays the historical price data of the selected symbol in a chart format.

---

## Features

### Forex List
- Fetches a list of currency symbols from the Finnhub API.
- Real-time price updates via WebSocket.
- Clean and responsive UI to display the list of symbols and their respective prices.

### Forex History
- Displays historical price data for a selected symbol. The data is currently been fetched from a local file as the Finnhub's candle api was not accessible.
- Interactive chart for better visualization of trends.

---

## Project Structure

The project follows the **Clean Architecture** principles, ensuring a separation of concerns and maintainability:

### Layers:

1. **Presentation Layer**:
   - Contains UI and widgets.
   - Uses the BLoC pattern for state management.

2. **Domain Layer**:
   - Contains business logic.
   - Includes use cases, entities, and repositories.

3. **Data Layer**:
   - Handles data fetching from the API and WebSocket.
   - Includes data models, data sources, and repository implementations.

---

## Technologies and Tools
- **Flutter**: Framework for building cross-platform applications.
- **BLoC**: State management solution.
- **Clean Architecture**: Ensures a scalable and testable codebase.
- **Finnhub API**: Provides financial data.
- **WebSocket**: Enables real-time data streaming.
- **Interactive Chart Library**: Visualizes historical data.

---

## Getting Started

### Prerequisites
- Flutter SDK installed ([installation guide](https://flutter.dev/docs/get-started/install)).
- An active [Finnhub API key](https://finnhub.io/).

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/MustafaSaify/fxtm_trader.git
   cd fxtm_trader
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Set Up Environment Variables

Create a .env file at the root of the project and add below variables

API_HOST="https://finnhub.io/api/v1"
API_KEY="your_finnhub_api_key_here"
WEBSOCKET_URL="wss://ws.finnhub.io"


env
Copy code
FINNHUB_API_KEY=your_finnhub_api_key_here
   ```

4. Run the application:
   ```bash
   flutter run
   ```

---

## Folder Structure

```
lib/
├── core/                # Core utilities (e.g., network, theme)
│   ├── network/         # Network client for making api calls.
│   ├── theme/           # Theme config for the app.
├── features/
│   ├── forex_list/      # Forex List module
│   │   ├── data/        # Data sources and models
│   │   ├── domain/      # Use cases and entities
│   │   ├── presentation/ # UI and BLoC
│   ├── forex_history/   # Forex History module
│       ├── data/        # Data sources and models
│       ├── domain/      # Use cases and entities
│       ├── presentation/ # UI and BLoC
├── router/               # App routing logic.
├── main.dart            # Application entry point
```

---

## How to Use

1. Open the **Forex List** module to view a list of symbols and their live prices.
2. Select a symbol to navigate to the **Forex History** module and view its historical data in an interactive chart.

---

## Contributions

Contributions are welcome! Please open an issue or submit a pull request.

1. Fork the repository.
2. Create your feature branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add some feature"
   ```
4. Push to the branch:
   ```bash
   git push origin feature-name
   ```
5. Open a pull request.

---

 
