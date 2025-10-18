# MyNet - Technical Communication Platform

[![Project Status: WIP](https://img.shields.io/badge/Status-Work%20In%20Progress-orange)](https://github.com/your-org/mynet-infrastructure)

## Overview

MyNet is a specialized communication platform designed for mathematicians, programmers, and technical professionals who require advanced tools for interactive collaboration. Unlike conventional messaging platforms, MyNet integrates domain-specific functionality such as inline LaTeX rendering, automated expression evaluation, and executable code snippets, enabling users to communicate ideas with mathematical rigor and computational precision.

## ✨ Key Features

- **Real-time Messaging** - Instant communication with support for threads and channels
- **Inline LaTeX Rendering** - Mathematical expressions rendered beautifully using LaTeX syntax
- **Executable Code Snippets** - Run and test code in multiple languages directly in chat
- **Expression Evaluation** - Computational engine for mathematical expressions
- **Syntax Highlighting** - Professional code formatting across multiple languages
- **Markdown Support** - Rich text formatting for detailed explanations

## 🚀 Quick Start

### Prerequisites
- Docker
- Docker Compose

### Running the Application

1. **Clone the infrastructure repository:**
   ```bash
   git clone https://github.com/M1XaM/my-net-infra.git
   cd my-net-infra
   ```

2. **Start all services:**
   ```bash
   docker-compose up -d
   ```

3. **Access the application:**
   - https://localhost

4. **Stop the application:**
   ```bash
   docker-compose down
   ```

## 🏗️ Project Structure

This project is organized across three main repositories:

### [MyNet Server](https://github.com/M1XaM/my-net-server)
Backend services, including:
- Real-time messaging engine
- LaTeX rendering service
- User authentication and management
- Database operations

### [MyNet Client](https://github.com/M1XaM/my-net-client)
Frontend application featuring:
- Responsive chat interface
- LaTeX equation editor
- Real-time collaboration tools
- Mobile-friendly design

### [MyNet Infrastructure](https://github.com/your-org/mynet-infrastructure) (this repo)
Deployment and orchestration, including:
- Docker configurations
- Database setup
- Service orchestration
- Environment management

## 🛠️ Technology Stack

### Backend
- **Flask** - API server and real-time communication
- **WebSocket** - Real-time messaging
- **Docker** - Code execution sandboxing
- **PostgreSQL** - Primary database

### Frontend
- **React** - User interface framework
- **TypeScript** - Type safety
- **MathJax/KaTeX** - LaTeX rendering
- **Socket.io Client** - Real-time communication

## 📋 Current Status

🚧 **Work in Progress** - MyNet is currently under active development. Core features are being implemented and tested. The platform is not yet production-ready but shows promising functionality for technical collaboration.

### What's Working
- User authentication and authorization
- Basic real-time messaging
- LaTeX rendering prototype

### In Development
- Enhanced code execution environments
- Advanced LaTeX rendering
- Mobile application
- Performance optimization
- Security hardening

## 🎯 Use Cases

- **Academic Research** - Collaborate on mathematical proofs and algorithms
- **Software Development** - Share and test code snippets in real-time
- **Data Science** - Discuss statistical models with executable examples
- **Education** - Interactive teaching with immediate code execution
- **Technical Teams** - Streamlined communication for STEM professionals
