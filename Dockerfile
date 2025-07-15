# Используем официальный образ Flutter для сборки
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

# Копируем исходники
COPY . .

# Собираем веб-версию
RUN flutter pub get && flutter build web --release

# Используем Nginx для раздачи
FROM nginx:alpine

# Копируем собранные файлы из предыдущего этапа
COPY --from=build /app/build/web /usr/share/nginx/html

# Настраиваем Nginx для корректной работы SPA (Single Page Application)
COPY nginx.conf /etc/nginx/conf.d/default.conf