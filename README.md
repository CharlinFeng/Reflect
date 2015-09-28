![image](./Reflect/logo.jpg)<br />
<br/>

##### 感谢小饭的翻译 [中文文档](https://github.com/nsdictionary/Reflect/blob/master/README_CN.md)



###Selfless pay, just to make you faster to conquer swift！

#### .Reflection
#### .convert dictionary to model
#### .convert model to dictionary
#### .convert plist to model
#### .One key archive


<br/><br/><br/>
Reflect
===============
<br/>
### Reflec
.Swift 2.0<br/>
.Xcode 7<br/>
.Reflection is available under the MIT license.


<br/><br/><br/>
Installation
===============
you can just drag the Reflect files into your own project, without any third-party library.<br/><br/>
Structure Details：<br/>
.Coding about archiving <br/>
.Reflect  reflection core package<br/>
.Dict2Model convert  dictionary to  custom object<br/>
.Model2Dict convert custom object to dictionary<br/>

#### Tips
This frame already prepares many examples for lazy guys and it’s easy to see the result when u just use the methord
Person1.Convert(),Studetn1.Parse(),Book1.Action()<br/>
1.Parse-Parse8: convert dictionary to model<br/>
2.Convert1-Convert4: convert model to dictionary<br/>
3.Archiver1-Archiver3: One key archive<br/>




<br/><br/><br/>
Core theory
===============
1. If you wanna use all the functions, all your custom model must inherit from `Reflec` Class.<br/>

2. It’s better to use implicitly optional type for properties. Try not to use strange type like var v1: [string?]? , var v2: [string!]! and this frame has lots of assertion to help you use data type reasonably.<br/>
3. This frame is based on requirement : parse json data into dictionaries then to model.
Limitation: reckon without complictated data like Core Data support; without consideration of Struct.
<br/>



<br/><br/><br/>
Reflect
===============
Call the properties of object directly can get the reflection for enumerations:

        p1.properties { (name, type, value) -> Void in
            println("\(name),\(type),\(value)")
        }

In addition, you can call class methods without initiate object while the value has no meaning:

        Person.properties { (name, type, _) -> Void in
            println("\(name),\(type)")
        }

The name is the property name of your model;
Type is the type of encapsulated ReflectType data;
Value is the value of variable;
You can also see the detail of properties by seeing the reference of ReflectType encapsulation. For example, the specific data type, if it is basic data type, if it is array, if it is optional, if it is object transferred from OC and if it is custom class.：<br/><br/>



    var typeName: String!
    
    /**  analysis type from system  */
    var typeClass: Any.Type!
    
    var disposition: MirrorDisposition!
    
    var dispositionDesc: String!
    
    /**  whether it is optional  */
    var isOptional: Bool = false
    
    /**  whether it is array  */
    var isArray: Bool = false
    
    /**  real type: optional + array  */
    var realType: RealType = .None

In addition to above, I also add the function of  printing like OC so that you can directly print the object. For example, print Book1(book1 class is in Archiver1.swift of the projcet)
println(book1):

    println(book1)
    

the result of console would be:

    Reflect.Book1 <0x7a09fb10>: 
    {
    name: tvb
    price: 36.6
    }

ignore the field and field reflection of the process of analyzing additional features, subclass needs only rewrite the method.

    /**  property mapping  */
    
    //The model's property named 'userModel',get value width key 'user_model' from dictionay
    func mappingDict() -> [String: String]? {
        return ["userModel":"user_model"]
    }
     
     
    /**  property ignore */
    
    //Ignore the 'info' property of the model.
    func ignorePropertiesForParse() -> [String]? {
        return ["info"]
    }


You also can use the method below to complete converting from string to class

    let cls = ClassFromString("Reflect.Person")
  
attention, the string here include the name space 




<br/><br/><br/>
convert dictionary to model
===============
it’s easy to convert dictionary to model, I already did the cascade im not going to repeat the details：

    let stu1 = Student1.parse(dict: Student1Dict)
    let stus = Student7.parses(arr: Student7DictArr)

If you property type is Bool, you may encounter UndefinedKey, which is due to Swift's own reasons, you just need to implement the following methods manually resolved:

    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        self.isVip = (value as! Int) != 0
    }


parse Plist file ,Please don't take the suffix

    let author = Author.parsePlist("Author")


<br/><br/><br/>
convert model to dictionary
===============
it’s easy to convert model to dictionary, I already did the cascade im not going to repeat the details:

    let dict = person3.toDict()


<br/><br/><br/>
One key archive
===============
Archive has done the cascade and easy for using. It also encapsulates the operation of Caches folder, directly save in Caches folder.

Archive: the name of  single model could be empty, but the name of array can’t be empty. Back to the position of archiving.

    let path1 =  Book2.save(obj: book2, name: nil)
    let path2 =  Book3.save(obj: bookArr, name: "book3")


Read data: please use the same key, if save name wich not used as nill, use nil for read data.

    let arcBook2 = Book2.read(name: nil)
    let arr = Book3.read(name: "book3")

delete data:

    Book1.delete(name: nil)


additional function: ignore archive field

    /**  ignore archive field  */
    
    //ignore archive property named 'icon'
    func ignoreCodingPropertiesForCoding() -> [String]? {
        return ["icon"]
    }


<br/><br/><br/>
Career
===============
WebSite：http://ios-android.cn <br/>
Sina WeiBo：http://weibo.com/charlin2015/<br/>
<br/><br/>

