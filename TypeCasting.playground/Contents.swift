import Foundation

class Food {
    let name: String

    init(name: String) {
        self.name = name
    }
}

class Chinesefood: Food {
    let type: String

    init(name: String, type: String) {
        self.type = type
        super.init(name: name)
    }
}

class KoreanFood: Food {
    let type: String

    init(name: String, type: String) {
        self.type = type
        super.init(name: name)
    }
}

let instanceList = [ Chinesefood(name: "cake", type: "케이크"),
                     KoreanFood(name: "김치", type: "전통음식"),
                     Chinesefood(name: "smoothie", type: "Drink"),
                     KoreanFood(name: "불고기", type: "전통음식"),
                     Chinesefood(name: "coke", type: "Drink"),
                     KoreanFood(name: "치킨", type: "현대음식")]

for instance in instanceList {
    if instance is KoreanFood {
        let koreanFoodInstance = instance as! KoreanFood
        print(koreanFoodInstance.name, koreanFoodInstance.type)
    } else if instance is Chinesefood {
        let chineseFoodInstance = instance as! Chinesefood
        print(chineseFoodInstance.name, chineseFoodInstance.type)
    }
}

for instance in instanceList {
    if instance is KoreanFood {
        if let koreanFoodInstance = instance as? KoreanFood {
            print(koreanFoodInstance.name, koreanFoodInstance.type)
        }
    } else if instance is Chinesefood {
        if let chineseFoodInstance = instance as? Chinesefood {
            print(chineseFoodInstance.name, chineseFoodInstance.type)
        }
    }
}
