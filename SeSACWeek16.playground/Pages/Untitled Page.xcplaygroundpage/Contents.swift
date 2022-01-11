import UIKit

// 사용자들, 길드, 길드장?
class Guild {
    var guildName: String
    
    unowned var owner: User?
    
    init(guildName: String) {
        self.guildName = guildName
        print("guild init")
    }
    
    deinit {
        print("guild deinit")
    }
}

class User {
    var userName: String
    
    var guild: Guild?
    
    init(userName: String) {
        self.userName = userName
        print("user init")
    }
    
    deinit {
        print("user deinit")
    }
}


// 인스턴스를 만들고 메모리에 올라가게 된다.
var sesac: Guild? = Guild(guildName: "SeSAC") // RC(레퍼런트 카운트)가 1이 된다.
//sesac = nil  // RC 0이 된다.


var nickname: User? = User(userName: "미묘한도사") // RC(레퍼런트 카운트)가 1이 된다.
//nickname = nil // RC가 0이 된다.

sesac?.owner = nickname // RC 1
nickname?.guild = sesac // RC 2

//sesac?.owner = nil // RC 1
//nickname?.guild = nil // RC 1

// 게임에서 나오게 된다.
nickname = nil  // RC 0
//sesac = nil  // RC 0

sesac?.owner
