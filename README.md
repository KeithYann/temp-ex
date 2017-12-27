# bitcoin explore

## 配置需求
* 硬盘 > 500G 用于BTC区块文件，挂载到宿主，见 Dockerfile
* 内存 > 4G

## 使用流程
``` bash
# 打包镜像，需要 npm 网络畅通，大约10分钟左右
docker build \
  --build-arg LIMITHEIGHT=<LIMITHEIGHT> \
  -t bitconexpore .

# 前台运行镜像
docker run -p 4000:3001 bitconexpore

# 后台运行镜像
docker run -d -p 4000:3001 bitconexpore

# 打开浏览器输入 http://localhost:4000/insight
```

## 配置文件说明
```javascript
// ./bitcore-node.json
// datadir: BTC区块文件 默认 /bitcoindata 并且挂载到宿主，见 Dockerfile
// port: 暴露端口 默认 3001
// servicesConfig.bitcoind.limitHeight: 同步的最大高度，超过高度后不继续同步，默认为0表示不限制高度。也可以通过 docker 打包参数配置
```

