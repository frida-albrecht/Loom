module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<71> : tensor<10x10x2xi32>}> : () -> tensor<10x10x2xi32>
    %1 = "tosa.const"() <{values = dense<90> : tensor<1x10x2xi32>}> : () -> tensor<1x10x2xi32>
    %2 = tosa.intdiv %0, %1 : (tensor<10x10x2xi32>, tensor<1x10x2xi32>) -> tensor<10x10x2xi32>
    %3 = tosa.logical_left_shift %2, %2 : (tensor<10x10x2xi32>, tensor<10x10x2xi32>) -> tensor<10x10x2xi32>
    %4 = tosa.arithmetic_right_shift %3, %3 {round = true} : (tensor<10x10x2xi32>, tensor<10x10x2xi32>) -> tensor<10x10x2xi32>
    %5 = tosa.identity %4 : (tensor<10x10x2xi32>) -> tensor<10x10x2xi32>
    %cast = tensor.cast %5 : tensor<10x10x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

