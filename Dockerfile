FROM hugomods/hugo:latest as build
ENV BUILD_ID 2024-12-20-080400

# Copy your static files
COPY src .

VOLUME /src

WORKDIR /src

# Build the Hugo site
RUN rm -rf /src/public && hugo && ls -la /src/public

# Create a new stage with the Nginx Alpine image
FROM nginx:alpine

# Copy the static website files generated by Hugo from the build stage to the Nginx container
COPY --from=build /src/public /usr/share/nginx/html

EXPOSE 80
