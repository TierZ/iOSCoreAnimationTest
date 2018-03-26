# iOSCoreAnimationTest
Core Animation其实是一个令人误解的命名。你可能认为它只是用来做动画的，但实际上它是从一个叫做Layer Kit这么一个不怎么和动画有关的名字演变而来，所以做动画这只是Core Animation特性的冰山一角。


1.图层的树状结构
	Core Animation是一个复合引擎，它的职责就是尽可能快地组合屏幕上不同的可视内容，这个内容是被分解成独 立的图层，存储在一个叫做图层树的体系之中。于是这个树形成了UIKit以及在iOS应用程序当中你所能在屏幕上 看见的一切的基础。

	CALayer 的一些功能（UIView没有暴露出来的）：
	• 阴影，圆角，带颜色的边框 
	• 3D变换
	• 非矩形范围
	• 透明遮罩
	• 多级非线性动画
2.图层的寄宿图
	CALayer类能够包含一张你喜欢的图片，寄宿图即图层中包含的图。
	CALayer 的 属性 contents,contentsGravity, contentsScale,masksToBounds，contentsRect，contentsCenter
3.图层几何学
	对于视图或者图层来说，frame并不是一个非常清晰的属性，它其实是一个虚拟属性，是根据position ，bounds
	和 transform  计算而来，所以当其中任何一个值发生改变，frame都会变化。相反，改变frame的值同样会影
	响到他们当中的值
	记住当对图层做变换的时候，比如旋转或者缩放,frame实际上代表了覆盖在图层旋转之后的整个轴对齐的矩形区域，也就是说frame 的宽高可能和bounds的宽高不再一致了
4.视觉效果
	cornerRadius，masksToBounds，borderWidth，borderColor ，shadow，mask 组透明
	如果一个view 既有shadow 又有圆角，你需 要用到两个图层，一个只画阴影的空的外图层，和一个用 masksToBounds 裁剪内容的内图层。

5.变换
	CGAffineTransform CATransform3D

6.专用图层

 	CAShapeLayer：
 	CAShapeLayer是一个通过矢量图形而不是bitmap来绘制的图层子类。你指定诸如颜色和线宽等属性，用CGPath来定义想要绘制的图形，最后'CAShapeLayer'就自动渲染出来了  
 	
 	CATextLayer：
 	它以图层的形式包含了UILabel几乎所有的绘制特性，并且额外提供了一些新的特性。同样，CATextLayer也要比UILabel渲染得快得多。很少有人知道在iOS 6及之前的版本，UILabel其实是通过WebKit来实现绘制的，这样就造成了当有很多文字的时候就会有极大的性能压力。而CATextLayer使用了Core text，并且渲染得非常快。

 	CATransfromLayer：（---->没理解/(ㄒoㄒ)/~~<----）
 	CATransformLayer不同于普通的CALayer，因为它不能显示它自己的内容。只有当存在了一个能作用域子图层的变换它才真正存在。CATransformLayer并不平面化它的子图层，所以它能够用于构造一个层级的3D结构，比如我的手臂示例

 	CAGradientLayer：
	CAGradientLayer是用来生成两种或更多颜色平滑渐变的。用Core Graphics复制一个CAGradientLayer并将内容绘制到一个普通图层的寄宿图也是有可能的，但是'CAGradientLayer'的真正好处在于绘制使用了硬件加速。

	CAReplicatorLayer：
	CAReplicatorLayer的目的是为了高效生成许多相似的图层。它会绘制一个或多个图层的子图层，并在每个复制体上应用不同的变换。

	CAScrollLayer：
	CAScrollLayer有一个-scrollToPoint:方法，它自动适应bounds的原点以便图层内容出现在滑动的地方。注意，这就是它做的所有事情。前面提到过，Core Animation并不处理用户输入，所以CAScrollLayer并不负责将触摸事件转换为滑动事件，既不渲染滚动条，也不实现任何iOS指定行为例如滑动反弹（当视图滑动超多了它的边界的将会反弹回正确的地方

	CATiledLayer：
	CATiledLayer为载入大图造成的性能问题提供了一个解决方案：将大图分解成小片然后将他们单独按需载入。

	CAEmitterLayer：
	CAEmitterLayer是一个高性能的粒子引擎，被用来创建实时例子动画如：烟雾，火，雨等等这些效果。

	CAEAGLLayer：
	苹果引入了一个新的框架叫做GLKit，它去掉了一些设置OpenGL的复杂性，提供了一个叫做CLKView的UIView的子类，帮你处理大部分的设置和绘制工作。前提是各种各样的OpenGL绘图缓冲的底层可配置项仍然需要你用CAEAGLLayer完成，它是CALayer的一个子类，用来显示任意的OpenGL图形。

	AVPlayerLayer:
	AVPlayerLayer 是用来在iOS上播放视频的。他是高级接口例如 MPMoivePlayer 的底层实现，提供了显示视频 的底层控制。 AVPlayerLayer 的使用相当简单:你可以用 +playerLayerWithPlayer: 方法创建一个已经绑定了 视频播放器的图层，或者你可以先创建一个图层，然后用 player 属性绑定一个 AVPlayer 实例。

7.隐式动画
	隐式是因为我们并没有指定任何动画的类型。我们仅仅改变了一个属性，然后Core Animation来决定如何并且何时去做动画。

	但当你改变一个属性，Core Animation是如何判断动画类型和持续时间的呢?实际上动画执行的时间取决于当前事务的设置，动画类型取决于图层行为。
	事务实际上是Core Animation用来包含一系列属性动画集合的机制，任何用指定事务去改变可以做动画的图层属性都不会立刻发生变化，而是当事务一旦提交的时候开始用一个动画过渡到新值。
	事务是通过 CATransaction 类来做管理，这个类的设计有些奇怪，不像你从它的命名预期的那样去管理一个简单 的事务，而是管理了一叠你不能访问的事务。 CATransaction 没有属性或者实例方法，并且也不能用 +alloc 和 -init 方法创建它。但是可以用 +begin 和 +commit 分别来入栈或者出栈。
	任何可以做动画的图层属性都会被添加到栈顶的事务，你可以通过 +setAnimationDuration: 方法设置当前事务的 动画时间，或者通过 +animationDuration 方法来获取值(默认0.25秒) 
	
	UIKit会默认禁止隐式动画:每个 UIView 对它关联的图层都扮演了一个委托，并且提供了 -actionForLayer:forKey 的实现方法。当不在一个动画块的实现中， UIView 对所有图层行为返回 nil ，但是在动画 block范围之内，它就返回了一个非空值。属性在动画块之外发生改变， UIView 直接通过返回 nil 来禁用隐式动画。但如果在动画 块范围之内，根据动画具体类型返回相应的属性。

	UIView 关联的图层禁用了隐式动画，对这种图层做动画的唯一办法就是使用 UIView 的动画函数(而不是 依赖 CATransaction )，或者继承 UIView ，并覆盖 -actionForLayer:forKey: 方法，或者直接创建一个 显式动画(具体细节见第八章)。
	对于单独存在的图层，我们可以通过实现图层的 -actionForLayer:forKey: 委托方法，或者提供一个 actions 字典来控制隐式动画

8.显式动画
	显式动画，它能够对一些属性做指定 的自定义动画，或者创建非线性动画
	1.属性动画
		属性动画作用于图层的某个单一属性，并指定了它的一个目标值，或者一连串将要做动画的值。属性动画分为两种:基础和关键帧
	2.动画组 
	3.过渡
		过渡并不像属性动画那样平滑地在两个值之间做动画，而是影响到整个图层的变化。过渡动画首先展示之前的图层外观，然后通过一个交换过渡到新的外观。

9.图层时间
	CAMediaTiming 协议定义了在一段动画内用来控制逝去时间的属性的集合，CALayer和CAAnimation 都实现了这个协议，所以时间可以被任意基于一个图层或者动画的类控制

	持续和重复：duration  repeatCount
	相对时间: beginTime  speed  timeOffset

10.缓冲
	Core Animation使用缓冲来使动画移动更平滑更自然，而不是看起来的那种机械和人工。
	1.动画速度
		CAMediaTimingFunction
