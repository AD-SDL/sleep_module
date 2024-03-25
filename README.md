# sleep_module

An example module that implements a basic sleep(t) function

## Installation and Usage

### Python

```bash
# Create a virtual environment named .venv
python -m venv .venv

# Activate the virtual environment on Linux or macOS
source .venv/bin/activate

# Alternatively, activate the virtual environment on Windows
# .venv\Scripts\activate

# Install the module and dependencies in the venv
pip install -e .

# Run the environment
python -m sleep_rest_node --host 0.0.0.0 --port 2000
```

### Docker

1. Install Docker for your platform of choice.
2. Run `make init` to create the `.env` file, or copy `example.env` to `.env`
3. Open the .env file and ensure that all values are set and correct.

```bash
# Build and run just the module
docker compose up --build

# Run the module, but detach so you can keep working in the same terminal
docker compose up --build -d

# Run the module alongside a simple test workcell
docker compose --profile wei up --build -d
```
