
# OpenSSL FIPS App builder 
This script manages the setup and compilation process for building an OpenSSL application with FIPS (Federal Information Processing Standards) provider support inside a Docker environment. It compiles the FIPS module, configures OpenSSL to work in FIPS mode, and installs it on a separate Debian container.

## Prerequisites

Ensure you have the following:

- **Docker** installed and running on your system.
- **OpenSSL** FIPS version and OpenSSL application version, both configurable through environment variables.

## Configuration

### OpenSSL and FIPS Versions


You can configure the OpenSSL and FIPS versions by modifying the following environment variables:

- `OPENSSL_FIPS_VERSION`: Specifies the version of the OpenSSL FIPS module (default: `openssl-3.0.9`).
- `OPENSSL_APP_VERSION`: Specifies the OpenSSL application version (default: `openssl-3.3.2`).

you can check latest App and fips validated version here https://openssl-library.org/source/

## Key Steps Performed by the Script

### 1. Compiling OpenSSL FIPS Version:
The script compiles the specified `OPENSSL_FIPS_VERSION` and extracts the FIPS-validated provider files (e.g., `fips.so`), ensuring that the necessary FIPS modules are available.

### 2. Downloading and Compiling the OpenSSL Version:
It downloads the required `OPENSSL_APP_VERSION` and compiles it with the FIPS provider. This OpenSSL version will be configured to support FIPS mode, meeting security requirements for cryptographic operations.

### 3. Installing OpenSSL in a Separate Debian Container:
After compilation, the OpenSSL application and its FIPS provider are installed in a separate Debian-based container. This ensures that the environment is isolated and suitable for production use.

### 4. Configuring OpenSSL to Work in FIPS Mode:
Finally, the script configures the compiled OpenSSL to operate in FIPS mode, ensuring compliance with FIPS security standards for cryptographic functions.

## Usage
To execute the script, follow these steps:

### 1. Clone the repository and navigate to the script directory.
### 2. Ensure that all required dependencies are met before running the script.

### 3. configure the OpenSSL and FIPS versions by modifying the following environment variables:
```bash
export OPENSSL_FIPS_VERSION=openssl-3.0.9
export OPENSSL_APP_VERSION=openssl-3.3.2
```

### 4. Run the script with appropriate permissions.
```bash
chmod +x ./build.sh
```
### 5. Run the main build script 
```bash
./build.sh
```


## License
This project is licensed under the GNU General Public License (GPL). You are free to modify and distribute the software, but any derivative work must also be licensed under the GPL.

For more details, see the gpl license [GPL3 license](https://www.gnu.org/licenses/gpl-3.0.html)
