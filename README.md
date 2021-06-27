### Swenson-He


## I. Add arithmetic operators (add, subtract, multiply, divide) to make the following expressions true. You can use any parentheses you’d like. 
3 1 3 9 = 12 

# ((3 + 1) / 3) * 9


## II. Write a function/method utilizing Swift to determine whether two strings are anagrams or not (examples of anagrams: debit card/bad credit, punishments/nine thumps, etc.) 

```
func getCleanString(string: String) -> String {
    
    var cleanString = String (string.lowercased().sorted())
    
    cleanString.unicodeScalars.removeAll {
        !(CharacterSet.lowercaseLetters.contains($0) || CharacterSet.decimalDigits.contains($0))
    }
    
    return cleanString
}

func getUniqueCharactersString(string: String) -> String {
    
    var set = Set<Character>()
    return string.filter{
        set.insert($0).inserted
    }
}

func checkAnagram(string1: String, string2: String) -> Bool {
    
    
    let cleanString1 = getCleanString(string: string1)
    let cleanString2 = getCleanString(string: string2)
    
    if abs(cleanString1.count - cleanString2.count) >= 2 {
        return false
    }
    
    let uniqueString1 = getUniqueCharactersString(string: cleanString1)
    let uniqueString2 = getUniqueCharactersString(string: cleanString2)
    
    return (uniqueString1 == uniqueString2)
}

print(checkAnagram(string1: "debit card", string2: "bad credit")) // true
print(checkAnagram(string1: "debit card", string2: "credit credit")) // false
```

## III. Write a method in Swift to generate the nth Fibonacci number (1, 1, 2, 3, 5, 8, 13, 21, 34) 

# A. recursive approach 
```
func recursive(first: Int, second:Int, limit: Int) {
    
    print(first)
    
    if limit > 1 {
        recursive(first: second, second: (first + second), limit: limit-1)
    }
}
recursive(first: 1, second: 1, limit: 9)
/*
1
1
2
3
5
8
13
21
34
*/
```

# B. iterative approach 
```
func iterative(limit: Int) {
    
    var first = 1
    var second = 1
    
    var ind: Int = 1
    while ind <= limit {
        print(first)
        let temp = first
        first = second
        second = temp + first
        ind += 1
    }
    
}
iterative(limit: 9)
/*
1
1
2
3
5
8
13
21
34
*/
```


## IV. Which architecture would you use for the required task below? Why?

> `MVVM`, I used to work with MVC, MVP, MVVM and VIPER, we all know that *MVC* leads to massive-view-controller issue. *MVP* is fine for me, but *the Presenter* has a refrence to the View (even it is a protocol refrence). so *MVVM* is the best for most business models, *view-model* is reusable and does not have any refrence to the View. the view is not one of its dependencies.
> 
> Adding `promises` to MVVM makes it reactive.
> 
> Apply coordinator for naviagtion logic, and `Dependency Injection`.

and finally, I have beend asked in the task to use MVVM in my solution.
