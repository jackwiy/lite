demo {
    System
    Library
}

Main ()->() {
    n0 := node{0}
    n1 := node{1}
    n2 := node{2}
    n3 := node{3}
    n4 := node{4}
    n5 := node{5}
    n6 := node{6}

    n0.left = n1
    n0.right = n2

    n1.left = n3
    n1.right = n4

    n2.left = n5
    n2.right = n6

    cmd.prt("Pre Order Traverse")
    PreorderTraverse(n0)
    cmd.prt("Middle Order Traverse")
    MiddleorderTraverse(n0)
    cmd.prt("Post Order Traverse")
    PostorderTraverse(n0)

    n0 = InverseNode(n0)
    cmd.prt("Inverse node")
    PreorderTraverse(n0)

    arr := _{9,1,5,8,3,7,4,6,2}
    SimpleSort(arr)
    arr = _{9,1,5,8,3,7,4,6,2}
    BubbleSort(arr)
    arr = _{9,1,5,8,3,7,4,6,2}
    QuickSort(arr)

    cmd.prt("Filter Array")
    arr = FilterList(arr, $it > 4)
    @ [arr] { cmd.prt(ea) }

    cmd.prt("oop")
    app := App{"test", "Windows"}
    app.Start()
    app.Stop()
    Shutdown(app)
    cmd.rd()
}

node {..value :i32}-> {
    left :node?
    right :node?
}

PreorderTraverse (node:node?)->() {
    ? node -> nil { <- () }
    cmd.prt(node.value)
    PreorderTraverse(node.left)
    PreorderTraverse(node.right)
}

PostorderTraverse (node:node?)->() {
    ? node -> nil { <- () }
    PreorderTraverse(node.left)
    PreorderTraverse(node.right)
    cmd.prt(node.value)
}

MiddleorderTraverse (node:node?)->() {
    ? node -> nil { <- () }
    PreorderTraverse(node.left)
    cmd.prt(node.value)
    PreorderTraverse(node.right)
}

InverseNode (node:node?)->(node:node?) {
    ? node -> nil { <- (nil) }
    node.left = InverseNode(node.left)
    node.right = InverseNode(node.right)

    temp := node{node.value <- left = node.right, right = node.left}
    <- (temp)
}

Swap (list:[i32], i, j:i32)->() {
    _(list[i], list[j]) = _(list[j], list[i])
}

SimpleSort (list:[i32])->() {
    cmd.prt("Simple Sort")
    @ [0 < list.count] i {
        @ [i+1 < list.count] j {
            ? list[i] > list[j] {
                Swap(list, i , j)
            }
        }
    }
    @ [list] { cmd.prt(ea) }
}

BubbleSort (list:[i32])->() {
    cmd.prt("Bubble Sort")
    @ [0 < list.count] i {
        @ [list.count-2 >= i] j {
            ? list[j] > list[j+1] {
                Swap(list, j , j+1)
            }
        }
    }
    @ [list] { cmd.prt(ea) }
}

QuickSort (list:[i32])->() {
    cmd.prt("Quick Sort")
    QSort(list,0,list.count-1)
    @ [list] { cmd.prt(ea) }
}

QSort (list:[i32], low, high:i32)->() {
    pivot := 0
    ? low < high {
        pivot = Partition(list,low,high)

        QSort(list, low, pivot-1)
        QSort(list, pivot+1, high)
    }
}

Partition (list:[i32], low, high:i32)->(position:i32) {
    pivotkey := list[low]
    
    @ low < high {
        @ low<high & list[high] >= pivotkey {
            high -= 1
        }
        Swap(list, low , high)
        @ low<high & list[low] <= pivotkey {
            low += 1
        }
        Swap(list, low , high)
    }

    <- (low)
}

FilterList (list:[i32], fn:(take:i32)->(act:bl))->(l:[i32]) {
    filter := [i32]{}

    @ [list] {
        ? fn(ea) {
            filter += ea
        }
    }
    <- (filter)
}

Shutdown (ctrl:Control)->() {
    ctrl.Shutdown()
}

Program {..Name:str}-> {
    _running := false
}

Program += {
    Start ()->() {
        cmd.prt("Start")
        .._running = true
    }

    Stop ()->() {
        cmd.prt("Stop")
        .._running = false
    }
}

Control -> {
    Shutdown ()->(){}
}

Program += Control {
    Shutdown ()->() {
        cmd.prt("Shutdown")
        .._running = false
    }
}

App {name, ..Platform:str}-> Program{name}{}