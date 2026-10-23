module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-51> : tensor<1x1x7x10xi32>}> : () -> tensor<1x1x7x10xi32>
    %1 = "tosa.const"() <{values = dense<181> : tensor<1x1x7x1xi32>}> : () -> tensor<1x1x7x1xi32>
    %2 = tosa.minimum %0, %1 : (tensor<1x1x7x10xi32>, tensor<1x1x7x1xi32>) -> tensor<1x1x7x10xi32>
    %3 = tosa.clz %2 : (tensor<1x1x7x10xi32>) -> tensor<1x1x7x10xi32>
    %4 = tosa.clz %3 : (tensor<1x1x7x10xi32>) -> tensor<1x1x7x10xi32>
    %5 = tosa.arithmetic_right_shift %4, %2 {round = false} : (tensor<1x1x7x10xi32>, tensor<1x1x7x10xi32>) -> tensor<1x1x7x10xi32>
    %6 = tosa.reduce_min %5 {axis = 1 : i32} : (tensor<1x1x7x10xi32>) -> tensor<1x1x7x10xi32>
    %7 = tosa.bitwise_xor %6, %3 : (tensor<1x1x7x10xi32>, tensor<1x1x7x10xi32>) -> tensor<1x1x7x10xi32>
    %cast = tensor.cast %7 : tensor<1x1x7x10xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

