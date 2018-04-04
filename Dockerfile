FROM microsoft/aspnetcore-build AS build-env

# Copy csproj and restore as distinct layers
WORKDIR /src
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o /app

# Build runtime image
FROM build-env
WORKDIR /app
#COPY --from=build-env /app .
ENTRYPOINT ["dotnet", "WebAppAzure.dll"]
