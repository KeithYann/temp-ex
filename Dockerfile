# Use an official Python runtime as a parent image
FROM node:8
ENV NPM_CONFIG_LOGLEVEL warn

ARG LIMITHEIGHT="0"
ENV LIMITHEIGHT="${LIMITHEIGHT}"

WORKDIR /app

ADD ./bitcore-node-btc /app/bitcore-node-btc
ADD ./bitcoin-0.15.0 /app/bitcoin-0.15.0
ADD ./mynode /app/mynode
ADD ./index.js /app/index.js
ADD ./start.sh /app/start.sh

RUN cd /app/bitcore-node-btc && npm i
RUN cp -r /app/bitcore-node-btc /app/tmp/ 
RUN cp -r /app/bitcoin-0.15.0/* /app/bitcore-node-btc/
RUN cd /app/bitcore-node-btc/bin/ && mv /app/mynode ./
RUN cd /app/bitcore-node-btc/bin/mynode && npm i
RUN cd /app/bitcore-node-btc/bin/mynode && ../bitcore-node install https://github.com/satoshilabs/insight-api
RUN cd /app/bitcore-node-btc/bin/mynode && ../bitcore-node install insight-ui
RUN cp /app/index.js /app/bitcore-node-btc/bin/mynode/node_modules/insight-api/node_modules/bitcore-lib/index.js
RUN cp /app/index.js /app/bitcore-node-btc/bin/mynode/node_modules/bitcore-message/node_modules/bitcore-lib/index.js
RUN cd /app/bitcore-node-btc/bin/mynode
RUN node /app/bitcore-node-btc/bin/mynode/change_config.js ${LIMITHEIGHT}

EXPOSE 3001

CMD ["/app/start.sh"]
