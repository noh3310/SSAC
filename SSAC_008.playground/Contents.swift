import UIKit
import Security

var greeting = "Hello, playground"

// 클래스는 대문자로 입력해야 한다.
// 클래스가 인스턴스로 되기 위해서는, 클래스의 프로퍼티가 모두 초기화되어 있어야 한다.
// 일단 오류를 해결하기 위해서는 어떻게 새야하나요?
// 옵셔널 타입으로 바꾸면 된다.
// 프로퍼티가 옵셔널일 경우, 컴파일 오류는 나지 않지만 런타임 오류가 발생할 수 있다.
// 프로퍼티 초기화를 위해 빈 괄호를 사용하는 것이 아닌, 초기화 구문을 통해 인자값을 넣어서 프로퍼티를 초기화한다.

// 구조체는 클래스와 달리 초기화 구문을 제공한다. -> 멤버와이즈 초기화 구문
class Monster {
    
    var clothes: String
    var speed: Int
    var power: Int
    var exp: Double
    
    init(clothes: String, speed: Int, power: Int, exp: Double) {
        self.clothes = clothes
        self.speed = speed
        self.power = power
        self.exp = exp
    }
    
    func attack() {
        print("몬스터 공격")
    }
}

// 클래스는 상속이 가능하다. (내가 배웠을 때는 단일 상속만 가능하다고 알고있다)
// 오버라이딩은 재정의 한다
// Monster: 부모클래스(SuperClass), BossMonster: 자식클래스(SubClass)
class BossMonster: Monster {
    var bossName = "쿠파"
    
    override func attack() {
        super.attack()
        
        print("보스 공격")
    }
}

var boss = BossMonster(clothes: "블랙", speed: 100, power: 100, exp: 20000)
boss.bossName
boss.clothes
boss.power
boss.speed
boss.exp
boss.attack()

// easyMonster를 인스턴드라고 한다.
var easyMonster = Monster(clothes: "누더기", speed: 10, power: 10, exp: 30)
easyMonster.clothes
easyMonster.speed
easyMonster.power
easyMonster.exp
easyMonster.attack()

var hardMonster = Monster(clothes: "비싼옷", speed: 50, power: 50, exp: 50)
hardMonster.clothes
hardMonster.speed
hardMonster.power
hardMonster.exp
hardMonster.attack()

// Value Type vs Reference Type
var nickname: String = "고래밥"

var subNickname = nickname

nickname = "칙촉"

print(nickname) // 칙촉
print(subNickname) // 고래밥

class SuperBoss {
    var name: String
    var level: Int
    var power: Int
    
    init(name: String, level: Int, power: Int) {
        self.name = name
        self.level = level
        self.power = power
    }
}

var hardStepBoss = SuperBoss(name: "쉬운 보스", level: 1, power: 10)

var easyStepBoss = hardStepBoss

hardStepBoss.power = 50000
hardStepBoss.level = 100
hardStepBoss.name = "어려운 보스"

print(hardStepBoss.name, hardStepBoss.level, hardStepBoss.power)
print(easyStepBoss.name, easyStepBoss.level, easyStepBoss.power)
