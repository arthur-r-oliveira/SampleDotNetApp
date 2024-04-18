#FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
FROM registry.access.redhat.com/ubi8/dotnet-80:8.0-6 AS build-env
WORKDIR /App

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore App.sln
# Build and publish a release
RUN dotnet publish App.sln -o out

# Build runtime image
#FROM mcr.microsoft.com/dotnet/aspnet:8.0
FROM registry.access.redhat.com/ubi8/dotnet-80:8.0-6
WORKDIR /App
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "DotNet.SampleNetApp01.dll"]
