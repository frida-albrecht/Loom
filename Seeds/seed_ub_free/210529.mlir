module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<158> : tensor<4xi32>}> : () -> tensor<4xi32>
    %1 = "tosa.const"() <{values = dense<198> : tensor<1xi32>}> : () -> tensor<1xi32>
    %c5 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %c6 = "tosa.const"() <{values = dense<31> : tensor<1xi32>}> : () -> tensor<1xi32>
    %s7 = tosa.maximum %1, %c5 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %s8 = tosa.minimum %s7, %c6 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %2 = tosa.logical_left_shift %0, %s8 : (tensor<4xi32>, tensor<1xi32>) -> tensor<4xi32>
    %3 = tosa.bitwise_or %2, %2 : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %4 = tosa.reduce_product %3 {axis = 0 : i32} : (tensor<4xi32>) -> tensor<1xi32>
    %cast = tensor.cast %4 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}