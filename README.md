
## CocoaPods

**CocoaPod**  是开发 OS X 和 iOS 应用程序的一个第三方库的依赖管理工具。利用 CocoaPods，可以定义自己的依赖关系 (称作 pods)，并且随着时间的变化，以及在整个开发环境中对第三方库的版本管理非常方便。

CocoaPods 背后的理念主要体现在两个方面。首先，在工程中引入第三方代码会涉及到许多内容。针对 Objective-C 初级开发者来说，工程文件的配置会让人很沮丧。在配置 build phases 和 linker flags 过程中，会引起许多人为因素的错误。CocoaPods 简化了这一切，它能够自动配置编译选项。

其次，通过 CocoaPods，可以很方便的查找到新的第三方库。当然，这并不是说你可以简单的将别人提供的库拿来拼凑成一个应用程序。它的真正作用是让你能够找到真正好用的库，以此来缩短我们的开发周期和提升软件的质量。


我们将通过分析 podSpec 制作的过程，将公共模块以 pod 的方式引入工程
##什么是Spec Repo？

什么是Spec Repo？他是所有的Pods的一个索引，就是一个容器，所有公开的Pods都在这个里面，他实际是一个Git仓库remote端
在GitHub上，但是当你使用了Cocoapods后他会被clone到本地的~/.cocoapods/repos目录下，可以进入到这个目录看到master文件夹就是这个官方的Spec Repo了。

因此我们需要创建一个类似于master的Spec Repo，这里我们可以fork官方的Repo，也可以自己创建，个人建议不fork，因为你只是想添加自己的Pods，没有必要把现有的公开Pods都copy一份。所以创建一个 Git仓库，这个仓库你可以创建私有的也可以创建公开的，不过既然私有的Spec Repo，还是创建私有的仓库吧，需要注意的就是如果项目中有其他同事共同开发的话，你还要给他这个Git仓库的权限，所以我使用了其他Git服务，我使用的是
[GitHub](https://github.com/SlinceDog/PodMaster) ，当然还有其他的可供选择开源中国.....

##一、创建git仓库
注册没啥好说的需要注意的是：


###1、是否添加.gitignore文件
#### .gitignore文件里面记录了若干中文件类型，凡是该文件包含的文件类型，git都不会将其纳入到版本管理中。是否选择看个人需要；（被坑过，它会忽略一些文件commit及push）
###2、license类型
####正规的仓库都应该有一个license文件，Pods依赖库对这个文件的要求更严，是必须要有的。因此最好在这里让github创建一个，也可以自己后续再创建。我使用的license类型是MIT。(如果有兴趣了解也可以看这篇文章[开源许可证介绍](http://www.ruanyifeng.com/blog/2011/05/how_to_choose_free_software_licenses.html))
####上面的各项都填写完毕后，点击Create repository按钮即可，
##二、clone仓库到本地
```
$ git clone https://github.com/SlinceDog/PodMaster.git  
```

####推荐用SSH方式

##三、制作并提交podSpec文件
####注意：以下描述的文件都要放在步骤二clone到本地的git仓库的根目录下面。
![MacDown Screenshot](https://ww3.sinaimg.cn/large/006tNc79jw1fcozu2a9frj30xs0jyta2.jpg)

###如何创建podSpec文件？两种方法
1、
```
$ pod spec create XXX 
```
![MacDown Screenshot](https://ww1.sinaimg.cn/large/006tNc79gy1fcozuhz735j31kw1124ax.jpg)
出来是这个样子的，很多没有用的参数，不推荐用这种方式。

2、拷贝别人的

###podSpec参数说明
以DemoApp.podspec为例
![MacDown Screenshot](https://ww1.sinaimg.cn/large/006tNc79gy1fcozuyi5g7j317o0jugr1.jpg)
该文件是 ruby 文件，里面的条目都很容易知道含义。其中需要说明的有几个参数：

* 1、s.license : Pods 依赖库使用的 license 类型，大家填上自己对应的选择即可。
* 2、s.source_files : 表示源文件的路径，注意这个路径是相对 podspec 文件而言的。
* 3、s.frameworks : 需要用到的 frameworks，不需要加 .frameworks 后缀。
* 4、s.resource : 需要用到的 frameworks，不需要加 .frameworks : 需要用的资源文件 bundle
* 5、s.vendored_libraries : 需要用到的 .a 文件
* 修改好后save、 commit 、push ,需要注意的是不要加回车，否则可能podfile.lock 这是ruby语法错误，导致install不成功

##四、创建一个Demo工程
* 例如我新建了一个工程取名叫DemoApp在根目录下创建一个自定义UIView取名叫 CustomView 随便写点什么东西
![MacDown Screenshot](https://ww4.sinaimg.cn/large/006tNc79jw1fcp03tikh4j315q0n20vv.jpg)
* CustomView.h 自定义初始化
![MacDown Screenshot](https://ww2.sinaimg.cn/large/006tNc79gy1fcp06d650xj317u0s0n34.jpg)
* CustomView.h 实现自定义初始化
![MacDown Screenshot](https://ww2.sinaimg.cn/large/006tNc79gy1fcp0778rltj317m0wmdpk.jpg)
* 在demo工程中Appdelegate中引入该类
![MacDown Screenshot](https://ww2.sinaimg.cn/large/006tNc79gy1fcp0b3ijnij31kw0vztu4.jpg)
* 然后Run，模拟器跑起来了，就证明成功了！好了可以往target工程集成了
### 你也可以用 pod lib lint  命令去验证工程是否通过,其实这个验证也不太准确，你只要保证你的Demo工程可以正常跑起来就可以了！毕竟我们是给自己用的！如果是提交到CocoaPods官方的Specs仓库那就另说了。
* 基本上大功告成，我们这个spec打上tag就可以了，提交commit

##四、引入工程
* 新建一个xcode工程，cd到目录下，执行pod init
* 然后配置podfile
![MacDown Screenshot](https://ww2.sinaimg.cn/large/006tNc79jw1fcp0sds0juj31kw0rdq7x.jpg)
### 工程如果用swift的话，需要打开use_frameworks!

### cd到工程目录 pod install 
![MacDown Screenshot](https://ww3.sinaimg.cn/large/006tNc79gy1fcp0xfqu82j30d60li7b9.jpg)
![MacDown Screenshot](https://ww2.sinaimg.cn/large/006tNc79gy1fcp0xj43h3j31i60nmneg.jpg)
### 看到没，我们不需要添加pod引入的第三方库我的框架，他都会帮我们配置完了。只管用！

![MacDown Screenshot](https://ww2.sinaimg.cn/large/006tNc79jw1fcp135oendj319e0tunaj.jpg)
* 引入工程，开始用吧。
### 注意每次打tag的时候版本号要对应，否则会找不到你那个版本,如果Source源工程修改了，需要执行pod update DemoApp --verbose --no-repo-update

