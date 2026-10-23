FROM mcr.microsoft.com/dotnet/sdk:10.0 AS Build
WORKDIR /app_build

COPY ESCO_API.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o /app_publish

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS RUNTIME
WORKDIR /app_build
COPY --from=build /app_publish .

EXPOSE 8080

ENTRYPOINT [ "dotnet", "ESCO_API.dll" ]