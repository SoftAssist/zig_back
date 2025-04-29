# Zig Backend Project

Welcome to the Zig Backend Project! This project utilizes Zig to create a simple backend connected to MongoDB. The code is modular, clean, and production-ready. We've ensured to use minimal external dependencies and provide you with all the necessary build tools to get started.

## Project Structure

```
zig_back/
│
├── src/
│   ├── main.zig       # Entry point of the application
│   ├── db/
│   │   └── mongo.zig  # MongoDB connection logic
│   └── utils/         
│       └── helpers.zig # Helper functions
│
├── build.zig          # Build script
└── README.md          # Project documentation
```

## Getting Started

### Prerequisites

- [Zig](https://ziglang.org/download/) (version 0.10.0 or later)
- [MongoDB](https://www.mongodb.com/try/download/community)
- MongoDB connection URI (ensure your MongoDB server is running)

### Installation

1. **Clone the Repository**

   ```sh
   git clone <repository-url>
   cd zig_back
   ```

2. **Set up Environment**

   Ensure your MongoDB server is running and note your connection URI.

3. **Build the Project**

   Run the build script to compile the project:

   ```sh
   zig build
   ```

### Running the Project

After building the project, you can run it using:

```sh
zig build run
```

Ensure you have specified your MongoDB connection URI in the appropriate configuration file or environment variable.

## Code Overview

- **`main.zig`**: The entry point of the application where the execution begins.
- **`db/mongo.zig`**: Contains the functionality to connect to a MongoDB database.
- **`utils/helpers.zig`**: Provides additional utility functions used throughout the application.

## Building and Testing

- **Build**: Use `zig build` to compile the project.
- **Run Tests**: Use appropriate test commands if implemented in your specific setup.

## Contributing

Contributions are welcome! Please fork the repository and use a feature branch for your changes. When ready, submit a pull request.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.

---

Enjoy your coding journey with Zig and MongoDB! If you encounter any issues or have suggestions, feel free to open an issue on the project's GitHub repository.

test commit 
