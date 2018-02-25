# libbitcoin-explorer-docker
Dockerfile of [libbitcoin-explorer](https://github.com/libbitcoin/libbitcoin-explorer)

今天给大家介绍一个学习比特币的有利工具——Bitcoin-explorer，简称BX，中文直译过来是「比特币浏览器」，很容易让人产生误解，它其实和我们平时上网使用的浏览器、以及以Web站点形式存在的区块浏览器(https://blockexplorer.com/)还是有很大区别的，BX的定义是
> The Bitcoin Command Line Tool
> BX is a general purpose Bitcoin command line utility that supports Linux, OSX and Windows. The application can be built an distributed as a single file binary with no run time dependencies apart from the operating system.
> ---
> 它是一个独立的、跨平台的比特币命令行工具

这是什么意思？确实定义得比较抽象，因为它没有解释这个工具是用来做什么的。从我对这个工具的使用来看，这个工具实现了钱包的各种功能，包括密钥算法、交易签名、账号余额、流水等。以下是用BX产生比特币地址的命令，是不是非常简单。

![](http://upload-images.jianshu.io/upload_images/1933644-095226808f9685f7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


下面的密钥流程图来自BX的文档，是不是觉得很强大。

![](http://upload-images.jianshu.io/upload_images/1933644-ad818fc0fe487ba1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 为什么是这个工具
现在我们都知道BX是什么了，但这对我们学习比特币又何帮助呢？比特币学习算是一种研究，做一门研究，使用工具和不使用工具还是有差异的，这就好比我们读书时，上完物理、化学课，还要做相应的实验，否则光看书本中的知识，是很难内化的。

如果把比特币整个系统拆成不同的模块，核心功能模块可能包括以下几个功能：
1. 记账
2. 发行货币
3. 账户（钱包）管理
3.1 私钥管理
3.2 发送和接收交易
3.3 账户余额及流水

其中第1点和第2点都是由比特币网络实现的——俗称「挖矿」，这不是BX所擅长的；而第3点运行在用户的钱包中，但钱包是不会告诉你所有这些功能的实现细节的，相反，隐藏这些细节才是它的目的。于是我们就需要求助其他的途径，而今天我们介绍的BX，就是这样的方案，它可以帮助我们深入学习比特币中，账户管理相关的细节。

既然利用工具学习比特币很有效，但有那么多的开源工具，我们为什么要采用这一个呢？在我看来，选择这个工具有3个原因
1. 文档（http://t.cn/RE4H5TM）详细
开源项目都有个通病，就是文档少，或文档更新不及时；但这个项目的文档非常详细，高质量的文档降低了探索成本
2. 功能比较全
BX几乎包含了钱包应该具备的所有功能，它是跨平台的，可以在Windows、MacOS等主流平台上运行；
3. 没有依赖
很多工具都需要依赖比特币全节点，例如`bitcoin-cli`，这个我们以后会提到，而搭建一个比特币全节点的工作量已经很大了，这会提升学习门槛，降低学习热情。在我看来，没有依赖是一件非常美好的事情。

所以，这个工具非常好，这也是我为什么会在年前，把它推荐到我的小密圈的原因。
![](http://upload-images.jianshu.io/upload_images/1933644-ed3d4e1b91c539a6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 如何更方便的使用这个工具
在使用这个工具的过程中，我也遇到了一些问题，在这里写出来，今后你再使用时，可能会更方便些吧。主要问题有两个
1. 项目比较大，编译的时间长
2. 使用的代码库和其他项目产生冲突

这个项目大概会产生2个多GB的程序和库文件，编译一次大概需要1-2个小时，所以它也不是那么「即用即走」的。

另外，当你的操作系统中安装了多个密码学区块链项目时，可能会产生动态链接库的冲突，例如：两个项目都使用了椭圆曲线算法，后安装的项目所带的椭圆曲线代码库覆盖了前一个项目的，导致前一个项目不可用。我就是这样的受害者，在安装完EOS.IO之后，BX就无法使用了，这又会浪费我2个小时的编译时间。

![](http://upload-images.jianshu.io/upload_images/1933644-3ba41d1360771d95.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

为了节省无数个两个小时，我把这个工具做成了Docker镜像，Docker是一个类似虚拟机的沙盒容器，通过Docker包装的程序，可以运行在任何操作系统中，且它和其他程序完全隔离。既无需二次编译，也不用担心它和别的项目产生冲突，一石二鸟的解决了上述我提到的两个问题。

你有两种方法使用使用Docker化的BX，在此之前，你需要先在你的计算机里安装Docker（http://t.cn/RE4144o），然后选择下面两项中的任意一项，我推荐是使用第1种方法
1. 直接从DockerHub上把这个镜像（http://t.cn/RE4g17F）下载下来，先别着急动手，后面还会继续介绍
2. 下载我写好的Dockerfile（http://t.cn/RE439qu），在你的本机构建镜像

上述两种方法达到的目的都一样，即在本地生成一个BX的Docker镜像，如果你下载镜像很慢的话，可以看一下我之间的文章《[从ELKa谈一下docker化的思路](https://mp.weixin.qq.com/s?__biz=MzA5NTg5MzgyOA==&mid=2247483757&idx=1&sn=80aa235758487496e1a616d22deff7b7&chksm=90b92146a7cea850a68907095e29a56c4145f40670fad467d079825d6ca539deb077d55f1601&scene=38#wechat_redirect)》，其中谈到了如何提升在国内使用Docker的效率。

运行下面的命令，你便可以进入Docker化的BX的环境，如果你本地没有镜像的话，该命令会先下载镜像，再运行Docker容器，也即上面说的第1步

![](http://upload-images.jianshu.io/upload_images/1933644-972962870f28e961.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

之后你就可以自如的使用BX了，下图产生比特币地址的BX程序就运行在Docker容器中，至此，have fun！

![](http://upload-images.jianshu.io/upload_images/1933644-7ee00a0d2ff39753.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


## 总结
本文介绍了什么是Bitcoin Explorer这个工具？它是一个具备钱包的基本功能的命令行工具。我们为什么要使用它？这对我们在学习比特币的过程中，能帮助我们真正的内化账户管理相关的知识，同时我们了解到了如何才能更高效的使用这个工具。

如果你认为这篇文章很有用，可以分享给其他有需要的同学，如果你有任何疑问，请随时跟我联系。

**相关文章**
[# 1 认识比特币](https://mp.weixin.qq.com/s/5hYVZX0CMTH2mKUaA1y5qw)
[# 2 比特币的历史和钱包的介绍](https://mp.weixin.qq.com/s/ugsn1SWE-uuln_HGUaULZA)
[# 3 推开比特币世界的大门](https://mp.weixin.qq.com/s/dGF9jalBMCX8arIEyOSGnA)
[# 4 比特币交易初探](https://mp.weixin.qq.com/s/8rWB4gwEd90xgEYGWb9GMg)

----
我建立了一个收费的知识星球，在这里，我会为大家营造一个沉下心来学习的环境，在今年，我至少会做三件事情： 

1.  精通比特币的实现原理
2.  精通EOS的实现原理，并着手在EOS上建立应用
3.  学习其他项目的白皮书，寻找有创意、有价值的项目

以上内容会不定期的输出分享，同时也会在能力范围内解答同学的问题，期待你的加入

![image.png](http://upload-images.jianshu.io/upload_images/1933644-12219c51766c1cd9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
