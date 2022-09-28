from node:18-alpine

WORKDIR /app

# COPY _app.js .
COPY app/ app/

EXPOSE 3000

# This will create a production-ready build of your app in the project's ./dist
# npm run build => for prod

#CMD [ "node", "_app.js" ]
CMD [ "npm", "run", "dev" ]
