module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<151> : tensor<1x2x1xi32>}> : () -> tensor<1x2x1xi32>
    %1 = tosa.reduce_product %0 {axis = 1 : i32} : (tensor<1x2x1xi32>) -> tensor<1x1x1xi32>
    %2 = tosa.bitwise_or %1, %1 : (tensor<1x1x1xi32>, tensor<1x1x1xi32>) -> tensor<1x1x1xi32>
    %3 = tosa.bitwise_xor %2, %1 : (tensor<1x1x1xi32>, tensor<1x1x1xi32>) -> tensor<1x1x1xi32>
    %4 = tosa.add %3, %3 : (tensor<1x1x1xi32>, tensor<1x1x1xi32>) -> tensor<1x1x1xi32>
    %5 = tosa.reverse %4 {axis = 2 : i32} : (tensor<1x1x1xi32>) -> tensor<1x1x1xi32>
    %cast = tensor.cast %5 : tensor<1x1x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

