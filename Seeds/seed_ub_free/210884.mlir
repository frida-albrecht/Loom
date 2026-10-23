module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<136> : tensor<2x2x2x9xi32>}> : () -> tensor<2x2x2x9xi32>
    %1 = "tosa.const"() <{values = dense<-161> : tensor<2x2x1x9xi32>}> : () -> tensor<2x2x1x9xi32>
    %c1 = "tosa.const"() <{values = dense<0> : tensor<2x2x1x9xi32>}> : () -> tensor<2x2x1x9xi32>
    %t2 = tosa.maximum %1, %c1 : (tensor<2x2x1x9xi32>, tensor<2x2x1x9xi32>) -> tensor<2x2x1x9xi32>
    %c3 = "tosa.const"() <{values = dense<31> : tensor<2x2x1x9xi32>}> : () -> tensor<2x2x1x9xi32>
    %t4 = tosa.minimum %t2, %c3 : (tensor<2x2x1x9xi32>, tensor<2x2x1x9xi32>) -> tensor<2x2x1x9xi32>
    %2 = tosa.logical_left_shift %0, %t4 : (tensor<2x2x2x9xi32>, tensor<2x2x1x9xi32>) -> tensor<2x2x2x9xi32>
    %3 = tosa.identity %2 : (tensor<2x2x2x9xi32>) -> tensor<2x2x2x9xi32>
    %cast = tensor.cast %3 : tensor<2x2x2x9xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}