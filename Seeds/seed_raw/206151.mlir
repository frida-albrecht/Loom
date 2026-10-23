module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<56> : tensor<9xi32>}> : () -> tensor<9xi32>
    %1 = "tosa.const"() <{values = dense<-109> : tensor<1xi32>}> : () -> tensor<1xi32>
    %2 = tosa.minimum %0, %1 : (tensor<9xi32>, tensor<1xi32>) -> tensor<9xi32>
    %3 = tosa.bitwise_and %2, %2 : (tensor<9xi32>, tensor<9xi32>) -> tensor<9xi32>
    %4 = tosa.minimum %3, %2 : (tensor<9xi32>, tensor<9xi32>) -> tensor<9xi32>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %7 = tosa.negate %4, %5, %6 : (tensor<9xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<9xi32>
    %8 = tosa.maximum %7, %3 : (tensor<9xi32>, tensor<9xi32>) -> tensor<9xi32>
    %cast = tensor.cast %8 : tensor<9xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

