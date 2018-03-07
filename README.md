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

 	CATransfromLayer：
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

