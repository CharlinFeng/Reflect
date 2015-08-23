![image](./Reflect/logo.jpg)<br />

<br/><br/><br/>
反射
===============
<br/>
### 版本信息
.Swift 1.2<br/>
.Xcode 6.3<br/>
.基于Mit开源协议


<br/><br/><br/>
导入框架
===============
直接拖拽Reflect文件夹到您的项目中即可，无任何第三方依赖！<br/><br/>
文件夹结构说明：<br/>
.Coding 归档相关<br/>
.Reflect 反射核心包<br/>
.Dict2Model 字典转模型<br/>
.Model2Dict 模型转字典<br/>

#### 提示
注：框架中已为您准备了大量懒人式示例，并且简单到你直接调用类方法即可查看效果，比如Person1.Convert(),Studetn1.Parse(),Book1.Action()



<br/><br/><br/>
核心理论
===============
1.想要使用所有功能，您的模型需要继承自Relfect基类。<br/>
2.属性的数据类型，最好使用隐式可选。 var v1: [string?]? 这种怪类型尽量不要出现，框架做了大量断言帮助您使用合理的数据类型。<br/>
3.框架建立的是网络json解析到字典再到模型需求之上.未考虑复杂数据类型如Core Data支持；未考虑Struct。<br/>



<br/><br/><br/>
反射
===============
直接调用对象的properties即可枚举反射您的对象

        self.properties { (name, type, value) -> Void in
            println("\(name),\(type),\(value)")
        }

除了使用对象调用之外，你还可以不创建对象，直接类方法调用,此时的value无意义：

        Person.properties { (name, type, _) -> Void in
            println("\(name),\(type)")
        }

其中name是您的模型的属性名，type是封装的ReflectType数据类型，value是变量的值，
重度使用者请详细参考ReflectType的封装，您可以详细的知道每个属性是什么情况，如：

.具体的数据类型
.是否是基本数据类型
.是否为数组
.是否为Optional
.是否为OC过来的对象
.是否为自定义的Class类

    var typeName: String!
    
    /**  系统解析出的Type  */
    var typeClass: Any.Type!
    
    var disposition: MirrorDisposition!
    
    var dispositionDesc: String!
    
    /**  是否是可选类型  */
    var isOptional: Bool = false
    
    /**  是否是数组  */
    var isArray: Bool = false
    
    /**  真实类型: 可选 + 数组  */
    var realType: RealType = .None

，除了上面介绍的功能之外，还加入了仿OC打印：
你可以直接打印您的对象,比如打印Book1对象（BOOK1类位于项目中的Archiver1.swift中）：

    println(book1)
    

控制台会这样输出：

    Reflect.Book1 <0x7a09fb10>: 
    {
    name: tvb
    price: 36.6
    }

附加功能之解析过程的字段映射与字段忽略，子类只需重写此方法即可：

    /**  字段映射  */
    func mappingDict() -> [String: String]? {
        return nil
    }
     
     
    /**  字段忽略  */
    func ignorePropertiesForParse() -> [String]? {
        return nil
    }


您还可以使用以下方法完成字符串向类的转变：

    let cls = ClassFromString("Reflect.Person")
  
不过请注意，这里的字符串是含有命名空间的。




<br/><br/><br/>
字典转模型
===============
字典转模型非常简单，已做各种级联，这里不再赘述细节了：

        let stu1 = Student1.parse(dict: Student1Dict)
        let stus = Student7.parses(arr: Student7DictArr)





<br/><br/><br/>
模型转字典
===============
模型转字典也非常简单，已做各种级联，这里不再赘述细节了：

      let dict = person3.toDict()


<br/><br/><br/>
一键归档
===============
归档已做了级联，使用同样简单,同时封装了Caches文件夹的操作，直接保存在Caches文件夹中

归档：单个模型归档name可为空，数组时name值不可为空,返回归档位置

    let path1 =  Book2.save(obj: book2, name: nil)
    let path2 =  Book3.save(obj: bookArr, name: "book3")


读取：请使用同样的key，如保存没有使用name为nil，读取同样使用nil

    let arcBook2 = Book2.read(name: nil)
    let arr = Book3.read(name: "book3")

删除数据：

    Book1.delete(name: nil)


附加功能：归档字段忽略

    /**  归档字段忽略  */
    func ignoreCodingPropertiesForCoding() -> [String]? {
        return nil
    }


<br/><br/><br/>
事业
===============
西成的事业，渺小而艰难的求生存。前期我们专做全国的移动app外包。如果您能在信息上援助我们，我们万分感谢您的帮助！<br/>
西成：http://ios-android.cn <br/>
我的个人微博：http://weibo.com/charlin2015/<br/>
