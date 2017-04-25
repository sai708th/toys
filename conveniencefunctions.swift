
func within<T:Comparable>(value:T,min:T,max:T)->T{
    if value<min {
        return min
    }
    
    if value > max{
        return max
    }
    
    return value
}

func dispatch_async_main(block:()->()){
    dispatch_async(dispatch_get_main_queue(),block)
}

func dispatch_async_global(block:()->()){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),block)
}

public extension String {
    // quated from http://blog.sgr-ksmt.org/2016/03/22/string_split/
    public func split(length: Int) -> [String] {
        let array = self.characters.map { String($0) }  // ★1
        let limit = self.characters.count // ★2
        return 0
            .stride(to: limit, by: length) // ★3
            .map({
                array[$0..<$0.advancedBy(length, limit: limit)].joinWithSeparator("") // ★4
            })
    }

    func chopPrefix(count: Int = 1) -> String {
        if startIndex == endIndex{
            return ""
        }
        return self.substringFromIndex(self.startIndex.advancedBy(count))
    }
    
    func chopSuffix(count: Int = 1) -> String {
        if startIndex == endIndex{
            return ""
        }
        return self.substringToIndex(self.endIndex.advancedBy(-count))
    }
    
    func characterAtIndex(idxInt:Int)->String?{
        if characters.count <= idxInt || idxInt < 0 {return nil}
        let idx = startIndex.advancedBy(idxInt)
        return self[idx...idx]
    }
}

public extension NSString{
    // quated from http://stackoverflow.com/questions/5689288/how-to-remove-whitespace-from-right-end-of-nsstring
    func stringByTrimmingTrailingCharactersInSet(characterSet:NSCharacterSet)->NSString{
        let rangeOfLastWantedCharacter = self.rangeOfCharacterFromSet(characterSet.invertedSet,options: .BackwardsSearch)
        if rangeOfLastWantedCharacter.location == NSNotFound{
            return ""
        }
        return self.substringToIndex(rangeOfLastWantedCharacter.location+1)
    }
}

/*
    let path = NSBundle.mainBundle().pathForResource("hoge", ofType: "dat")
    let str = try! String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
    let strProvs = str.componentsSeparatedByString("=")
    let strProv = strProvs[index]
	let s = line.substringFromIndex(line.startIndex.advancedBy(1))
	let sParameters = line.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: ", "))
}
*/

public extension UIView{
    func relativeWidthGetterBasedOnRatio(ratio:CGFloat)->CGFloat->CGFloat{
        return { self.bounds.size.width * $0 / ratio }
    }
    
    func relativeHeightGetterBasedOnRatio(ratio:CGFloat)->CGFloat->CGFloat{
        return { self.bounds.size.height * $0 / ratio }
    }
    
    func relativePointGetterBasedOnRatio(ratio:CGSize)->(x:CGFloat->CGFloat,y:CGFloat->CGFloat){
        return (relativeWidthGetterBasedOnRatio(ratio.width),relativeHeightGetterBasedOnRatio(ratio.height))
    }
}

func shuffledIntegers(n:Int)->[Int]{
    var tmp = [Int](0 ..< n)
    for i in 0..<n{
        let c = arc4random_uniform_Int(n-i)
        if c != n-i-1 {
            swap(&tmp[c], &tmp[n-i-1])
        }
    }
    return tmp
}

func arc4random_uniform_Int(a:Int)->Int{
    return Int(arc4random_uniform(UInt32(a)))
}

func CGRectMake2(point:CGPoint,_ size:CGSize)->CGRect{
    return CGRectMake(point.x,point.y,size.width,size.height)
}

extension UIColor{
    func blendWithColor(color: UIColor, alpha:CGFloat)->UIColor{
        let fixedalpha = min(1.0, max(0.0,alpha))
        let beta = 1.0 - fixedalpha
        var cmp = (CGFloat(0),CGFloat(0),CGFloat(0),CGFloat(0))
        var cmp2 = (CGFloat(0),CGFloat(0),CGFloat(0),CGFloat(0))
        getRed(&cmp.0, green: &cmp.1, blue: &cmp.2, alpha: &cmp.3)
        color.getRed(&cmp2.0, green: &cmp2.1, blue: &cmp2.2, alpha: &cmp2.3)
        
        let red   = cmp.0 * beta + cmp2.0 * alpha
        let blue  = cmp.1 * beta + cmp2.1 * alpha
        let green = cmp.2 * beta + cmp2.2 * alpha
        let alpha = cmp.3 * beta + cmp2.3 * alpha
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

