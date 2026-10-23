module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-120> : tensor<9x6x7x6xi16>}> : () -> tensor<9x6x7x6xi16>
    %1 = tosa.argmax %0 {axis = 2 : i32} : (tensor<9x6x7x6xi16>) -> tensor<9x6x6xi32>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = tosa.negate %1, %2, %3 : (tensor<9x6x6xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<9x6x6xi32>
    %c0 = "tosa.const"() <{values = dense<-1> : tensor<9x6x6xi32>}> : () -> tensor<9x6x6xi32>
    %t0 = tosa.minimum %4, %c0 : (tensor<9x6x6xi32>, tensor<9x6x6xi32>) -> tensor<9x6x6xi32>
    %5 = tosa.intdiv %4, %t0 : (tensor<9x6x6xi32>, tensor<9x6x6xi32>) -> tensor<9x6x6xi32>
    %cast = tensor.cast %5 : tensor<9x6x6xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}