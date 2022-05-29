package org.informob

class Greeting {
    fun greeting(): String {
        return "Hello, ${Platform().platform}!"
    }
}