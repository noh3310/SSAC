//
//  TestClass.swift
//  AccessLevelsProject
//
//  Created by 노건호 on 2021/12/23.
//

import Foundation
import AccessLevel

class TestClass: OpenClass {
    override func openFunction() {
        super.openFunction()
        print("open")
    }
}

class PublicTestClass: PublicClass {
    override func publicFunction() {
        super.publicFunction()
        print("public")
    }
}

public class A {
    public func a() {
        print("A")
    }
}

class B: A {
    override func a() {
        <#code#>
    }
}
