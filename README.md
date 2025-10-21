# DeviceIdentifiers.Net

DeviceIdentifiers.Net is a lightweight .NET library for looking up Android device marketing names from their model identifiers using Google's official `supported_devices.csv`.


[![NuGet](https://img.shields.io/nuget/v/DeviceIdentifiers.Net.svg?style=flat-square)](https://www.nuget.org/packages/DeviceIdentifiers.Net/)
[![Build status](https://ci.appveyor.com/api/projects/status/80sxi14863411286/branch/main?svg=true)](https://ci.appveyor.com/project/mveism/deviceidentifiers-net/branch/main)

## Installation

Install the package via NuGet:

```bash
dotnet add package DeviceIdentifiers.Net
```

## Usage

Add the library to your project:

```csharp
using DeviceIdentifiers.Net;
```

Lookup a device's marketing name:

```csharp
var deviceModel = "Pixel 4";
var marketingName = DeviceIdentifier.GetMarketingName(deviceModel);
Console.WriteLine($"Device Model: {deviceModel}, Marketing Name: {marketingName}");
```

In this example, `"Pixel 4"` is the device model and `GetMarketingName` returns the corresponding marketing name.

## Features

- Lightweight and simple to use
- Based on Google's official `supported_devices.csv`
- Fast lookups without loading all data into memory

## Contributing

Contributions are welcome! Feel free to submit issues or pull requests.

## License

This project is licensed under the MIT License.
