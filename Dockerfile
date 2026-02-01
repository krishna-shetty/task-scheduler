# Stage 1: Build stage
FROM ubuntu:latest AS build

# Install build-essential for compiling C++ code
RUN apt-get update && apt-get install -y build-essential

# Set the working directory
WORKDIR /app

# Copy the source code into the container
COPY main.cpp .

# Compile the C++ code statically to ensure it doesn't depend on runtime
RUN g++ -o main main.cpp -static


# Stage 2: Final stage
FROM scratch

# Copy yhe static binary from the build stage
COPY --from=build /app/main /main

# Command to run the binary
CMD ["/main"]